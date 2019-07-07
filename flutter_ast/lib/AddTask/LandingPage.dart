import 'package:flutter/material.dart';
import 'AddTaskPage.dart';
class LandingPage extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    return new Scaffold(
      body:SafeArea(
        top: false,
      child:Container(
        child:Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0,bottom: 10.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 200.0),
                    child: new FloatingActionButton(
                        elevation: 0.0,
                        child: new Icon(Icons.add),
                        backgroundColor: Colors.lightGreen,
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AddTaskPage("Landing")));
                        }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text("Add Your Task"),
                  ),
                ],
              ),
            )
        ),
      ),/* add child content here */
      ),
    );
  }
}
