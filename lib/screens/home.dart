import 'package:flutter/material.dart';
import 'package:my_task/app_state_container.dart';
import 'package:my_task/code/app_state.dart';
import 'package:my_task/screens/login.dart';
import 'package:my_task/screens/task_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppState appState;

  Widget get _pageToDisplay {
    if (appState.isLoading) {
      return _loadingView;
    } else if (!appState.isLoading && appState.user == null) {
      return new LoginScreen();
    } else {
      return new TaskList();
    }
  }

  Widget get _loadingView {
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  Widget get _homeView {
    return new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            'Logged In:',
            style: new TextStyle(
              fontSize: 18.0,
            ),
          ),
          new Text(
            appState.user.displayName,
            style: new TextStyle(fontSize: 24.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final container = AppStateContainer.of(context);
    var container = AppStateContainer.of(context);
    appState = container.state;
    Widget body = _pageToDisplay;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('My Tasks'),
        actions: <Widget>[
          new PopupMenuButton(
            onSelected: null,
            itemBuilder: (BuildContext context) {
            },
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          primary: false,
          children: <Widget>[
            new DrawerHeader(
              child: new Center(
                child: new Text('Account Settings'),
              ),
            ),
            new ListTile(
              title: const Text('Logout', textAlign: TextAlign.right,),
              trailing: const Icon(Icons.exit_to_app),
              onTap: () async {
                await container.signOutFirebase();
                Navigator.of(context).pushReplacementNamed('/');
              },
            )
          ],
        ),
      ),
      body: body,
    );
  }
}
