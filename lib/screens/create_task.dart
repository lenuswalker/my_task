import 'package:flutter/material.dart';
import 'package:my_task/code/task.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => new _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String subject = '';
  String details = '';

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Create Task'),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: Form(
          key: this._formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter a Task Name';
                  }
                  subject = value;
                },
                decoration: new InputDecoration(
                  hintText: 'Task Name'
                ),
              ),
              const SizedBox(height: 24.0),
              new TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    subject;
                  }
                  subject = value;
                },
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              new Container(
                width: screenSize.width,
                child: new RaisedButton(
                  child: new Text('Save Task'),
                  onPressed: null
                ),
                margin: new EdgeInsets.only(
                  top: 20.0
                ),
              )
            ],
          )
        ),
      ),
    );
  }

  /*void _pushNote() {
    task = new Task(subject: subject, description: details);
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = (
             new ListTile(
              title: new Text(
                task.subject,
              ),
            )
          );
          final divided = ListTile
            .divideTiles(
              context: context,
              tiles: tiles
            ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Testing'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }*/
}