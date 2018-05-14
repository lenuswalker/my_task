import 'package:flutter/material.dart';
import 'package:my_task/screens/task_details.dart';
import 'package:my_task/code/db_manager.dart';
import 'package:my_task/app_state_container.dart';
import 'package:my_task/screens/home.dart';

class TaskList extends StatefulWidget {
  @override
  _TaskListState createState() => new _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final DbManager manager = new DbManager();
  List<Task> tasks;

  @override
  void dispose() {
    super.dispose();
    manager.closeDb();
  }

  @override
  Widget build(BuildContext context) {
    var container = AppStateContainer.of(context);
    return new FutureBuilder<List<Task>>(
      future: manager.getTasks(),
      builder: (context, snapshot) {
        return new Scaffold(
          /*appBar: new AppBar(
            title: Text('My Tasks'),
          ),*/
          body: buildTasksList(snapshot),
          floatingActionButton: new FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
                new MaterialPageRoute(builder: (_) => new TaskDetailWidget(manager))
            ),
            child: new Icon(Icons.add),
          ),
        );
      },
    );
  }
  
  Widget buildTasksList(AsyncSnapshot<List<Task>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
      case ConnectionState.waiting:
        return new CircularProgressIndicator();
      default:
        if (snapshot.hasError) {
          return new Text('Unexpected error occured: ${snapshot.error}');
        }
        tasks = snapshot.data;
        return new ListView.builder(
          itemBuilder: (BuildContext context, int index) => _createItem(index),
          itemCount: tasks.length,
        );
    }
  }
  
  /*Widget _createItem(int index) {
    return new Dismissible(
      key: new UniqueKey(),
      onDismissed: (direction) {
        manager.deleteTask(tasks[index].id)
            .then((dynamic) => print('Deleted!'));
      },
      child: new ListTile (
        title: new Text(tasks[index].title, style: new TextStyle(fontSize: 20.0),),
        subtitle: new Text(tasks[index].detail.length > 50
          ? tasks[index].detail.substring(0,50)
          : tasks[index].detail
        ),
        onTap: () {
          Navigator.of(context)
            .push(new MaterialPageRoute(builder: (_) => TaskDetailWidget(manager, task: tasks[index],)));
        },
      ),
    );
  }*/

  Widget _createItem(int index) {
    bool _checked;
    if (tasks[index].completed == 1) {
      _checked = true;
    } else {
      _checked = false;
    }
    return new Dismissible(
      key: new UniqueKey(),
      onDismissed: (direction) {
        manager.deleteTask(tasks[index].id)
            .then((dynamic) => print('Deleted!'));
      },
      background: new Container(
        color: Colors.blueAccent,
      ),
      child: new Container (
        decoration: new BoxDecoration(
          color: Colors.white,
          border: new Border(
            bottom: new BorderSide(
              color: Colors.grey,
              width: .25,
            )
          )
        ),
        child: new ListTile (
          title: new Text(tasks[index].title),
          subtitle: new Text(tasks[index].detail.length > 50
              ? tasks[index].detail.substring(0,50)
              : tasks[index].detail
          ),
          leading: new Checkbox(
            value: _checked,
            onChanged: (bool value) {
              if (value == true){
                manager.updateTask(
                    new Task(title: tasks[index].title,
                        detail: tasks[index].detail,
                        id: tasks[index].id,
                        completed: 1));
              } else {
                manager.updateTask(
                    new Task(title: tasks[index].title,
                        detail: tasks[index].detail,
                        id: tasks[index].id,
                        completed: 0));
              }
              setState(() {
              });
              /*Navigator.of(context)
                .push(new MaterialPageRoute(builder: (_) => HomeScreen()));*/
            }
          ),
          onTap: () {
            Navigator.of(context)
                .push(new MaterialPageRoute(builder: (_) => TaskDetailWidget(manager, task: tasks[index],)));
          },
        ),
      )
    );
  }
}