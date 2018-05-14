import 'package:flutter/foundation.dart';

class Task {

  final String id;
  String title;
  String detail;
  bool completed;

  Task({
    @required this.id,
    @required this.title,
    this.detail,
    this.completed = false,
  })
      : assert(id != null && id.isNotEmpty),
        assert(title != null && title.isNotEmpty),
        assert(completed != null);

  Task.fromMap(Map<String, dynamic> data)
    : this(id: data['id'], title: data['title'], detail: data['detail'], completed: data['completed'] ?? false);

  Map<String, dynamic> toMap() =>
      {
        'id': this.id,
        'title': this.title,
        'detail': this.detail,
        'completed': this.completed,
      };


}