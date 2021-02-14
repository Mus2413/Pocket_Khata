import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
class Aboutus extends StatefulWidget {
  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
  String data = "";

  @override
  void initState() {
    fetchfiledata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('About Us'),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                child: Text(
                  data, style: TextStyle(
                  fontSize: 20,
                ),
                ),
              ),
            )
          ],
        )
    );
  }

  void fetchfiledata() async {
    String responsedata;
    responsedata = await rootBundle.loadString('txtfile/aboutus.txt');
    setState(() {
      data = responsedata;
    });
  }
}