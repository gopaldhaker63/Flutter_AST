import 'package:flutter/material.dart';
import 'package:flutter_ast/TaskModel/TaskModel.dart';
import 'package:flutter_ast/TaskModel/TaskModel.dart';
import 'package:intl/intl.dart';
import 'package:flutter_ast/Database/DatabaseHelper.dart';

  class TaskDetail extends StatefulWidget {
  final TaskModel taskModel;

  TaskDetail(this.taskModel);

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: AppBar(
        title: Text("TASK DETAIL"),
      ),
      body: buildDetailPage(context),
    );
  }

  Widget buildDetailPage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text((widget.taskModel.taskTitle),textAlign: TextAlign.left,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text((widget.taskModel.taskDescription),textAlign: TextAlign.left,style: TextStyle(fontSize: 13.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text((readTimestamp(widget.taskModel.taskDate)),textAlign: TextAlign.right,style: TextStyle(fontSize: 13.0)),
            ),
          ],
        ),
      ),
    );
  }

  String readTimestamp(String timestamp) {
    var intTimestamp = int.parse(timestamp);
    var now =  new DateTime.fromMillisecondsSinceEpoch(intTimestamp);
    var formatter = new DateFormat('dd/MM/yyyy');
    String formatted = formatter.format(now);
    return formatted;

  }
}