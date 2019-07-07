import 'package:flutter/material.dart';
import 'package:flutter_ast/TaskModel/TaskModel.dart';
import 'Home/Home.dart';
import 'package:flutter_ast/AddTask/LandingPage.dart';

TaskModel taskModel = TaskModel();

void main() async {
  Widget _defaultHome = new LandingPage();
  var arrTask = new List<TaskModel>();
  var counter = await taskModel.getTaskCount();

  if (counter > 0) {
    _defaultHome = Home();
  }
  // Run app!
  runApp(new MaterialApp(
    title: 'App',
    home: _defaultHome,
    debugShowCheckedModeBanner: false,
  ));
}
