import 'package:flutter/material.dart';
import 'package:my_task/code/db_manager.dart';

class TaskDetailWidget extends StatefulWidget {
  final DbManager _manager;
  final Task task;

  TaskDetailWidget(this._manager, {this.task});

  @override
  _TaskDetailWidgetState createState() => new _TaskDetailWidgetState(_manager, task);
}

class _TaskDetailWidgetState extends State<TaskDetailWidget> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _title;
  String _detail;
  final DbManager _manager;
  final Task task;

  _TaskDetailWidgetState(this._manager, this.task);

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      task == null ? _manager.insertTask(new Task(title: _title, detail: _detail))
        .then((id) => Navigator.pop(context))
        : _manager.updateTask(new Task(title: _title, detail: _detail, id: task.id))
        .then((id) => Navigator.pop(context));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Edit Task Details'),
      ),
      body: new Form(
        key: _formKey,
        child: new Container(
          margin: new EdgeInsets.all(16.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                child: new TextFormField(
                  decoration: new InputDecoration(
                    labelText: 'Title',
                    border: InputBorder.none,
                  ),
                  validator: (val) => val.isNotEmpty ? null : "Title must not be empty",
                  onSaved: (val) => _title = val,
                  initialValue: task?.title,
                ),
              ),
              new Container(
                child: new Divider(
                  color: Colors.black,
                ),
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Details',
                  border: InputBorder.none
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onSaved: (val) => _detail = val,
                initialValue: task?.detail,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => _submit(),
        child: new Icon(Icons.check),
      ),
    );
  }
}