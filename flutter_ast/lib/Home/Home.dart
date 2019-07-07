import 'package:flutter/material.dart';
import 'package:flutter_ast/Database/DatabaseHelper.dart';
import 'package:flutter_ast/TaskModel/TaskModel.dart';
import 'package:flutter_ast/AddTask/AddTaskPage.dart';
import 'package:flutter_ast/AddTask/LandingPage.dart';
import 'package:flutter_ast/TaskDetail/TaskDetail.dart';
import 'package:intl/intl.dart';


class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  var arrTask = new List<TaskModel>();

  @override
  void initState() {
    super.initState();
    print("SATATATATATA");
    getManageAccount();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("TASK"),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTaskPage("AddTask")));
          },
          child: Icon(Icons.add)),
      body: buildAccountManageList(),
    );
    // TODO: implement build
//    return buildAccountManageList();
  }

  Widget buildAccountManageList() {
    return Align(
      alignment: Alignment.topLeft,
      child: SafeArea(
          child: ListView.separated(
              itemBuilder: (context, index) {
                TaskModel taskModel = arrTask[index];
                var isComplete = true;
                print("TASK::::${taskModel.taskTitle}");

                print("DATE::::${taskModel.iscomplete}");
                return ListTile(
                  title: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: taskModel.iscomplete == "Y"? Text(taskModel.taskTitle,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.normal)):Text(taskModel.taskTitle,style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0,bottom: 5.0),
                        child: Text(taskModel.taskDescription,style: TextStyle(fontSize: 13.0)),
                      ),
                    ],
                  ),
                  subtitle: Text(readTimestamp(taskModel.taskDate),textAlign: TextAlign.right,),
                  leading:CircleAvatar(child: Text(taskModel.taskTitle[0])),
                  trailing: PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == "Delete") {
                        _deleteManageAccount(taskModel);
                      } else if (value == "Edit") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddTaskPage(
                                      "Edit",
                                  taskModel: taskModel,
                                    )));
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                              value: 'Edit',
                              child: ListTile(
                                  leading: Icon(Icons.add),
                                  title: Text('Edit'))),
                          const PopupMenuItem<String>(
                              value: 'Delete',
                              child: ListTile(
                                leading: Icon(Icons.delete),
                                title: Text('Delete'),
                              ))
                        ],
                  ),
                  onTap: (){
                    showTaskDeail(taskModel);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Divider(height: 0.5, color: Colors.black26),
                );
              },
              itemCount: this.arrTask.length)),
    );
  }

  Future<void> getManageAccount() async {
    DatabaseHelper instance = DatabaseHelper.instance;
    var mapp = await instance.getAllTask();

    print("RESponse");
    print(mapp);

    if(mapp.length == 0){
  Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => LandingPage()));
  }

    setState(() {
      this.arrTask = mapp;
      print("Length:: {$this.arrAccount.length}");
  print(this.arrTask[0].iscomplete);

  });
  }

  _deleteManageAccount(TaskModel taskModel) async {
    DatabaseHelper instance = DatabaseHelper.instance;
    var mapp = await instance.deleteAccount(taskModel.taskId);

    setState(() {
      getManageAccount();
    });
  }

  addManageAccount() {

  }
  showTaskDeail(TaskModel taskModel) async {
    Navigator.push(
  context,
  MaterialPageRoute(
  builder: (context) => TaskDetail(taskModel)));
  DatabaseHelper instance = DatabaseHelper.instance;
  TaskModel tempTaskModel = TaskModel();
  tempTaskModel.taskTitle = taskModel.taskTitle;
  tempTaskModel.taskDescription = taskModel.taskDescription;
  var timeStamp = new DateTime.now().millisecondsSinceEpoch;

  tempTaskModel.taskDate = taskModel.taskDate;
  tempTaskModel.taskId = taskModel.taskId;
  tempTaskModel.iscomplete = "Y";
  print("YY::${taskModel.taskId}");
  print(tempTaskModel.iscomplete);
  var s = await instance.updateTask(tempTaskModel);
  setState(() {
  getManageAccount();
  });
  }

  String readTimestamp(String timestamp) {
  var intTimestamp = int.parse(timestamp);
  var now =  new DateTime.fromMillisecondsSinceEpoch(intTimestamp);
  var formatter = new DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(now);
  return formatted;

  }
}
