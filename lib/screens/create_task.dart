import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  @override
  _CreateTaskState createState() => new _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
                },
                decoration: new InputDecoration(
                  hintText: 'Task Name'
                ),
              ),
              const SizedBox(height: 24.0),
              new TextFormField(
                decoration: const InputDecoration(
                  border: const OutlineInputBorder(),
                ),
                maxLines: 5,
              ),
              new Container(
                width: screenSize.width,
                child: new RaisedButton(
                  child: new Text('Submit'),
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
}