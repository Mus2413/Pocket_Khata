import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:khata/Home.dart';
import 'package:khata/Register.dart';
import 'package:khata/Services/Authentication.dart';
import 'package:khata/Services/helper.dart';

import 'Loginpage.dart';
class khata extends StatefulWidget{

  @override
  _khataState createState() => _khataState();
}

class _khataState extends State<khata> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  new Container(
                    margin: new EdgeInsets.only(right:30.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Colors.red
                    ),
                    child: new Icon(Icons.create,color:Colors.white,),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 90.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Colors.lightBlueAccent
                    ),
                    child: new Icon(Icons.attach_money,color:Colors.white,),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 30.0,top: 80.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFFFFCE56)
                    ),
                    child: new Icon(Icons.assignment,color:Colors.white,),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(left: 150.0,top: 80.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Colors.teal
                    ),
                    child: new Icon(Icons.calendar_today,color:Colors.white,),
                  ),
                  new Container(
                    margin: new EdgeInsets.only(right: 90.0,top: 80.0),
                    height: 60.0,
                    width: 60.0,
                    decoration: new BoxDecoration(
                        borderRadius: new BorderRadius.circular(50.0),
                        color: Color(0xFF18D191)
                    ),
                    child: new Icon(Icons.add ,color:Colors.white,),
                  ),
                ]
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                ),
                new Text("Khata",style: new TextStyle
                  (fontSize: 80.0,fontWeight: FontWeight.bold,fontFamily: 'GreatVibes'),)
              ],
            ),
            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top:20.0,left: 50.0,right: 50.0,bottom: 10.0),
                    child: GestureDetector(
                      onTap:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Register()),
                        );
                      },
                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        width: 60.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: new Text("Get Started",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            new Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0,left: 50.0,right: 50.0),
                    child: GestureDetector(
                      onTap:() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Loginpage()),
                        );
                      },

                      child: new Container(
                        alignment: Alignment.center,
                        height: 60.0,
                        width: 60.0,
                        decoration: new BoxDecoration(
                          color: Colors.black,
                          borderRadius: new BorderRadius.circular(20.0),
                        ),
                        child: new Text("Sign In ",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                      ),

                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

}
