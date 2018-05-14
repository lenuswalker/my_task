import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:my_task/model/task.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference todoCollection = Firestore.instance.collection('todos');

class TodoStorage {
  final FirebaseUser user;

  TodoStorage.forUser({
    @required this.user,
  }) : assert(user != null);

  static Task fromDocument(DocumentSnapshot document) => _fromMap(document.data);

  static Task _fromMap(Map<String, dynamic> data) => new Task.fromMap(data);

  Map<String, dynamic> _toMap(Task task, [Map<String, dynamic> other]) {
    final Map<String, dynamic> result = {};
    if (other != null) {
      result.addAll(other);
    }
    result.addAll(task.toMap());
    result['uid'] = user.uid;

    return result;
  }

  /// Returns a stream of data snapshots for the user, paginated using limit/offset
  Stream<QuerySnapshot> list({int limit, int offset}) {
    Stream<QuerySnapshot> snapshots = todoCollection.where('uid', isEqualTo: this.user.uid).snapshots();
    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      // TODO can probably use _query.limit in an intelligent way with offset
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }

  Future<Task> create(String title) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot newDoc = await tx.get(todoCollection.document());
      final Task newTask = new Task(id: newDoc.documentID, title: title);
      final Map<String, dynamic> data = _toMap(newTask, {
        'created': new DateTime.now().toUtc().toIso8601String(),
      });
      await tx.set(newDoc.reference, data);

      return data;
    };

    return Firestore.instance.runTransaction(createTransaction).then(_fromMap).catchError((e) {
      print('dart error: $e');
      return null;
    });
  }

  Future<bool> update(Task task) async {
    final TransactionHandler updateTransaction = (Transaction tx) async {
      final DocumentSnapshot doc = await tx.get(todoCollection.document(task.id));
      // Permission check
      if (doc['uid'] != this.user.uid) {
        throw new Exception('Permission Denied');
      }

      await tx.update(doc.reference, _toMap(task));
      return {'result': true};
    };

    return Firestore.instance.runTransaction(updateTransaction).then((r) {
      return r['result'] == true; // forcefully cast to boolean
    }).catchError((e) {
      print('dart error: $e');
      return false;
    });
  }

  Future<bool> delete(String id) async {
    final TransactionHandler deleteTransaction = (Transaction tx) async {
      final DocumentSnapshot doc = await tx.get(todoCollection.document(id));
      // Permission check
      if (doc['uid'] != this.user.uid) {
        throw new Exception('Permission Denied');
      }

      await tx.delete(doc.reference);
      return {'result': true};
    };

    return Firestore.instance.runTransaction(deleteTransaction).then((r) => r['result']).catchError((e) {
      print('dart error: $e}');
      return false;
    });
  }
}