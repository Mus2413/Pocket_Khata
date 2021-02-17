import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}


class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String data="";
  @override
  void initState() {
    fetchfiledata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: Colors.black,
      ),
      body:ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Text(
                data,style: TextStyle(
                fontSize: 20,
              ),
              ),
            ),
          )
        ],
      )
    );
  }

  void fetchfiledata ()async{
    String responsedata;
    responsedata=await rootBundle.loadString('txtfile/privacypolicy.txt');
    setState(() {
      data=responsedata;
    });

  }


}