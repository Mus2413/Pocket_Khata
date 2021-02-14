import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  String _email;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password'),
      backgroundColor: Colors.black,),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              onChanged: (value) {
                setState(() {
                  _email = value.trim();
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Text('Send Request'),
                onPressed: () {
                  auth.sendPasswordResetEmail(email: _email);
                  Fluttertoast.showToast(
                      msg: 'An Email has been sent to your registered Email Id',
                      toastLength: Toast.LENGTH_SHORT,
                      //gravity: ToastGravity.SNACKBAR,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white30,
                      textColor: Colors.black
                  );

                  Navigator.of(context).pop();
                },
                color: Colors.cyan,
              ),

            ],
          ),

        ],),
    );
  }
}