import 'package:flutter/material.dart';
import 'package:my_task/code/task.dart';
import 'package:my_task/screens/create_task.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Tasks'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(32.0),
        child: new Column(
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new CreateTask()),
          );
        },
        tooltip: 'New Task',
        child: new Icon(Icons.add),
      ),
    );
  }
}