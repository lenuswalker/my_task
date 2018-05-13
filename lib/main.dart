import 'package:flutter/material.dart';
import 'package:my_task/app.dart';
import 'package:my_task/app_state_container.dart';

void main() {
  runApp(new AppStateContainer(
    child: new MyAppWidget(),
  ));
}