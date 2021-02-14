
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata/Home.dart';
import 'package:khata/Services/Authentication.dart';
import 'package:khata/Services/auth.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';

import 'Loginpage.dart';

class Register extends StatefulWidget{

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();
  TextEditingController usernameEditingController = new TextEditingController();

  AuthService authService = new AuthService();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  singUp() async {

    if(formKey.currentState.validate()){
      setState(() {

        isLoading = true;
      });

      await authService.signUpWithEmailAndPassword(emailEditingController.text,
          passwordEditingController.text).then((result){
        if(result != null){

          Map<String,String> userDataMap = {
            "Name" : usernameEditingController.text,
            "Email" : emailEditingController.text,
            "Password":passwordEditingController.text
          };

          databaseMethods.addUserInfo(userDataMap,emailEditingController.text);

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          HelperFunctions.saveUserNameSharedPreference(usernameEditingController.text);
          HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);
          Fluttertoast.showToast(
              msg: 'You are now registered as \nName : '+usernameEditingController.text +'\nEmail : '
                  + emailEditingController.text,
              toastLength: Toast.LENGTH_SHORT,
              //gravity: ToastGravity.SNACKBAR,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.white30,
              textColor: Colors.black);
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home()));
        }
        else
          {
            Fluttertoast.showToast(
                msg: 'Account with this Email already exist',
                toastLength: Toast.LENGTH_SHORT,
                //gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.white30,
                textColor: Colors.black);
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
              height: 15.0,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                    child: TextFormField(
                      decoration: textFieldInputDecoration('Name'),
                      controller: usernameEditingController,
                      validator: (val){
                        return val.isEmpty || val.length < 3 ? "Enter Username 3+ characters" : null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                    child: TextFormField(
                      decoration: textFieldInputDecoration('Email'),
                      keyboardType: TextInputType.emailAddress,
                      controller: emailEditingController,
                      validator: (val){
                        return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val) ?
                        null : "Enter correct email";
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                    child: TextFormField(
                      decoration: textFieldInputDecoration('Password'),
                      obscureText: true,
                      controller: passwordEditingController,
                      validator:  (val){
                        return val.length < 6 ? "Enter Password 6+ characters" : null;
                      },
                    ),
                  ),

                ],
              ),
            ),
            new Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:20.0,bottom: 10.0,left: 80,right: 50.0),
                  child: GestureDetector(
                    onTap:() {
                      FocusScopeNode currentFocus = FocusScope.of(context);
                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      singUp();
                    },
                    child: new Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: 250.0,
                      decoration: new BoxDecoration(
                        color: Colors.teal,
                        borderRadius: new BorderRadius.circular(15.0),
                      ),
                      child: new Text("Sign Up",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Have an Account? ",style: new TextStyle
                    (fontSize: 20.0,),),
                  GestureDetector(
                    onTap:() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );

                    } ,
                    child: new Text("Sign In",style: new TextStyle
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