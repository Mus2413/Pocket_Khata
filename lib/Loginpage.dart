import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata/Home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:khata/Reset.dart';
import 'package:khata/Services/Authentication.dart';
import 'package:khata/Services/auth.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';
import 'Register.dart';
import 'package:fluttertoast/fluttertoast.dart';
class Loginpage extends StatefulWidget{


  @override
  _LoginpageState createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  AuthService authService = new AuthService();

  final formKey = GlobalKey<FormState>();

  bool isLoading = false;

  signIn() async {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });

      await authService
          .signInWithEmailAndPassword(
          emailEditingController.text, passwordEditingController.text)
          .then((result) async {
        if (result != null)  {
          QuerySnapshot userInfoSnapshot =
          await DatabaseMethods().getUserInfo(emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(
              userInfoSnapshot.docs[0].data()["Name"]);
          HelperFunctions.saveUserEmailSharedPreference(
              userInfoSnapshot.docs[0].data()["Email"]);
          Fluttertoast.showToast(
              msg: 'Welcome '+emailEditingController.text+'!',
              toastLength: Toast.LENGTH_SHORT,
              //gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white30,
              textColor: Colors.black);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home()));
        } else {
          setState(() {
            isLoading = false;
            //print("INvalid");
            Fluttertoast.showToast(
                msg: 'Invalid Email Id/Password',
                toastLength: Toast.LENGTH_SHORT,
                //gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white30,
                textColor: Colors.black
            );
          });
        }
      });
    }
  }


  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Colors.white,
     body: Container(
       decoration: BoxDecoration(
         image: DecorationImage(
           image:AssetImage('images/loginpic.jpg'),
           fit: BoxFit.fill,
         )
       ),
       child: ListView(
         children: <Widget>[
           Padding(
             padding: const EdgeInsets.only(top: 20.0),
             child: Center(
               child: Container(
                 height: 150,
                 width: 350,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10.0),
                 ),
                 child: Stack(
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
                       margin: new EdgeInsets.only(left: 30.0,top: 90.0),
                       height: 60.0,
                       width: 60.0,
                       decoration: new BoxDecoration(
                           borderRadius: new BorderRadius.circular(50.0),
                           color: Color(0xFFFFCE56)
                       ),
                       child: new Icon(Icons.assignment,color:Colors.white,),
                     ),
                     new Container(
                       margin: new EdgeInsets.only(left: 150.0,top: 90.0),
                       height: 60.0,
                       width: 60.0,
                       decoration: new BoxDecoration(
                           borderRadius: new BorderRadius.circular(50.0),
                           color: Colors.teal
                       ),
                       child: new Icon(Icons.calendar_today,color:Colors.white,),
                     ),
                     new Container(
                       margin: new EdgeInsets.only(right: 90.0,top: 90.0),
                       height: 60.0,
                       width: 60.0,
                       decoration: new BoxDecoration(
                           borderRadius: new BorderRadius.circular(50.0),
                           color: Color(0xFF18D191)
                       ),
                       child: new Icon(Icons.add ,color:Colors.white,),
                     ),
                   ],
                 ),
               ),
             ),
           ),
           Center(
             child: new Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Text("Khata",style: new TextStyle
                   (fontSize: 60.0,fontWeight: FontWeight.bold,fontFamily: 'GreatVibes'),)
               ],
             ),
           ),
           SizedBox(
             height: 35.0,
           ),
           Form(
             key: formKey,
             child: Column(
               children: [
                 Padding(
                   padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                   child: TextFormField(
                     decoration: textFieldInputDecoration('Email'),
                     validator: (val) {
                       return RegExp(
                           r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                           .hasMatch(val)
                           ? null
                           : "Please Enter Correct Email";
                     },
                     keyboardType:TextInputType.emailAddress,
                     controller: emailEditingController,

                   ),
                 ),
                 SizedBox(
                   height: 15.0,
                 ),
                 Padding(
                   padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                   child: TextFormField(
                     obscureText: true,
                     decoration: textFieldInputDecoration('Password'),
                     validator: (val) {
                       return val.length >=6
                           ? null
                           : "Enter Password 6+ characters";
                     },
                     controller: passwordEditingController,
                   ),
                 ),

               ],
             ),
           ),
              new Row(
               children: <Widget>[
                    Padding(
                     padding: const EdgeInsets.only(top:20.0,bottom: 10.0,left: 120,right: 120.0),
                     child: GestureDetector(
                       onTap:() {
                         FocusScopeNode currentFocus = FocusScope.of(context);
                         if (!currentFocus.hasPrimaryFocus) {
                           currentFocus.unfocus();
                         }
                         signIn();
                       },
                       child: new Container(
                         alignment: Alignment.center,
                         height: 50.0,
                         width: 150.0,
                         decoration: new BoxDecoration(
                           color: Colors.teal,
                           borderRadius: new BorderRadius.circular(10.0),
                         ),
                         child: new Text("Sign In",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                       ),
                     ),
                   ),
               ],
           ),
           Center(
             child: new Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Text("Or  ",style: new TextStyle
                   (fontSize: 20.0,),),
                 GestureDetector(
                   onTap:() {
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context) => Register()));
                   } ,
                   child: new Text("New User",style: new TextStyle
                     (fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline,),),
                 )
               ],
             ),
           ),
           SizedBox(
             height: 15.0,
           ),
           Center(
             child: new Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 new Text("Or  ",style: new TextStyle
                   (fontSize: 20.0,),),
                 GestureDetector(
                   onTap:() {
                     Navigator.pushReplacement(context,
                         MaterialPageRoute(builder: (context) => ResetScreen()));
                   } ,
                   child: new Text("Forget Password",style: new TextStyle
                     (fontSize: 20.0,fontWeight: FontWeight.bold,decoration:TextDecoration.underline,),),
                 )
               ],
             ),
           ),

    ],
    ),
     ),
   );
  }
}


InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan.shade700)),
      enabledBorder:
      UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan.shade700)));
}