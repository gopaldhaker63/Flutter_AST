import 'package:flutter_ast/Database/DatabaseHelper.dart';
import 'dart:async';
import 'package:flutter/material.dart';

final String tableTaskInfo = "taskinfo";
final String columnTaskId = "taskid";
final String columnTaskTitle = "tasktitle";
final String columnTaskDescription = "taskdescription";
final String columnTaskDate = "taskdate";
final String columnIsComplete = "iscomplete";

class TaskModel{

  int taskId;
  String taskTitle;
  String taskDescription;
  String taskDate;
  String iscomplete;

  DatabaseHelper dabaseHelper;


  TaskModel(){
    dabaseHelper = DatabaseHelper.instance;
  }

  TaskModel.fromMap(Map<String, dynamic> map){
    taskTitle = map[columnTaskTitle];
    taskId = map[columnTaskId];
    taskDescription = map[columnTaskDescription];
    taskDate = map[columnTaskDate];
    iscomplete = map[columnIsComplete];
  }
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{columnTaskTitle:taskTitle,columnTaskDescription:taskDescription,columnTaskDate:taskDate,columnIsComplete:iscomplete};
    if (taskId != null){
      map[columnTaskId] = taskId;
    }
    return map;
  }

  Future<int> getTaskCount() async {
    DatabaseHelper instance = DatabaseHelper.instance;
    var mapp = await instance.getAllTask();
    return mapp.length;
  }
  Future getTask() async {
    DatabaseHelper instance = DatabaseHelper.instance;
    var mapp = await instance.getAllTask();
    return mapp;
  }

  Future deleteTask(TaskModel taskModel) async {
    DatabaseHelper instance = DatabaseHelper.instance;
    var mapp = await instance.deleteAccount(taskModel.taskId);
  }


}
