import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_ast/Database/DatabaseHelper.dart';
import 'package:flutter_ast/Home/Home.dart';
import 'package:flutter_ast/TaskModel/TaskModel.dart';

class AddTaskPage extends StatefulWidget {
  @override

  TaskModel taskModel;
  String fromPage;

  AddTaskPage(this.fromPage,{this.taskModel}){

  }

  _AddTaskPageState createState() => _AddTaskPageState(this.fromPage,taskModel);
}

class _AddTaskPageState extends State<AddTaskPage> {
  TaskModel taskModel;
  String fromPage;


  @override
  final TextEditingController textTaskTitle = TextEditingController();
  final TextEditingController txtTaskDescription = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  String _taskTitle;
  String _taskDescription;

  _AddTaskPageState(this.fromPage, this.taskModel) {
    print(this.fromPage);
    if (this.fromPage == "Edit") {
      textTaskTitle.text = taskModel.taskTitle;
      txtTaskDescription.text = taskModel.taskDescription;
    }
  } //constructor


  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        key: _scaffoldKey,

        body: SafeArea(
          top: false,
          child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: new ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          IconButton(icon: Icon(Icons.close),
                            onPressed: () {
                              Navigator.pop(context);
                            },)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Add your task",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
                      child: formSetup(context),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget formSetup(BuildContext context) {
    return new Form(
      key: _formKey,
      child: new Column(
        children: <Widget>[
          new TextFormField(
            decoration: InputDecoration(
                hintText: "Task Title", labelText: "Task Title"),
            controller: textTaskTitle,
            validator: (val) {
              if (val.length == 0)
                return "Please enter task title";
              else
                return null;
            },
            onSaved: (val) => _taskTitle = val,
          ),
          new TextFormField(
            decoration: InputDecoration(
                hintText: "Task Description", labelText: "Task Description"),
            controller: txtTaskDescription,
            keyboardType: TextInputType.url,
            validator: (val) {
              if (val.length == 0)
                return "Please enter task description";
              else
                return null;
            },
            onSaved: (val) => _taskDescription = val,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Container(
              width: 400,
              height: 50,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: new RaisedButton(
                child: new Text(
                  "Submit",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  debugPrint("click on submit button");
                  if (_formKey.currentState.validate()) {
                    pressedOnSubmit();
                  }
                },
                color: Colors.lightGreen,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                highlightColor: Colors.blueGrey,
              ),
            ),
          )
        ],
      ),
    );
  }

  void pressedOnSubmit() async {
    DatabaseHelper instance = DatabaseHelper.instance;
    TaskModel tempTaskModel = TaskModel();
    tempTaskModel.taskTitle = textTaskTitle.text;
    tempTaskModel.taskDescription = txtTaskDescription.text;
    var timeStamp = new DateTime.now().millisecondsSinceEpoch;
    tempTaskModel.taskDate = timeStamp.toString();
    tempTaskModel.iscomplete = "N";

    if (this.fromPage == "Edit") {
      tempTaskModel.taskId = this.taskModel.taskId;
      var s = await instance.updateTask(tempTaskModel);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    } else {
      var s = await instance.inserAccount(tempTaskModel);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
    }
  }
}
