import 'package:flutter/material.dart';
import 'package:my_task/screens/login.dart';
import 'package:my_task/screens/home.dart';

class MyAppWidget extends StatefulWidget {
  @override
  _MyAppWidgetState createState() => _MyAppWidgetState();
}

class _MyAppWidgetState extends State<MyAppWidget> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'My Tasks',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      //home: new LoginScreen(),
      routes: {
        '/': (BuildContext context) => new HomeScreen(),
        '/signin': (BuildContext context) => new LoginScreen(),
      },
    );
  }
}