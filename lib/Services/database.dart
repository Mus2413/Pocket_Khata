import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata/Services/Constants.dart';

class DatabaseMethods {
  Future<void> addUserInfo(userData, String text) async {
    FirebaseFirestore.instance.collection("UserDetails").doc(text)
        .set(userData)
        .catchError((e) {
      print(e.toString());
    });
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance
        .collection("UserDetails")
        .where("Email", isEqualTo: email)
        .get()
        .catchError((e) {
      print(e.toString());
    });
  }
  // ignore: non_constant_identifier_names
  Future<void> addMessage(String uid,String uniqueid, CustomerDetails,int time){

     FirebaseFirestore.instance.collection("UserDetails").doc(uid).collection("CustomerDetails")
        .doc(uniqueid).collection("Information").doc(time.toString()).set(CustomerDetails).then((_){
      Fluttertoast.showToast(
          msg: 'Details saved successfully!!!',
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white30,
          textColor: Colors.black);
    }).catchError((e){
      Fluttertoast.showToast(
          msg: 'Unknown Error!!!',
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black);
    });
  }
  Future<void> addHistory(String uid,String uniqueid, Historydata, time){

    FirebaseFirestore.instance.collection("UserDetails").doc(uid).collection("CustomerDetails").doc(uniqueid).collection("Information").doc(time).collection("History").add(Historydata).then((_){
      Fluttertoast.showToast(
          msg: 'Payment updated successfully!!!',
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.white30,
          textColor: Colors.black);
    }).catchError((e){
      Fluttertoast.showToast(
          msg: 'Unknown Error!!!',
          toastLength: Toast.LENGTH_SHORT,
          //gravity: ToastGravity.SNACKBAR,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.black);
    });
  }

  getdata(String uid,String uniqueId) async{
    return FirebaseFirestore.instance.collection("UserDetails").doc(uid)
        .collection("CustomerDetails")
        .doc(uniqueId)
        .collection("Information")
        .orderBy('time',descending: true)
        .snapshots();
  }

  gethistorydata(String uid,String uniqueid,time) async{
    return FirebaseFirestore.instance.collection("UserDetails").doc(uid)
        .collection("CustomerDetails")
        .doc(uniqueid)
        .collection("Information")
        .doc(time).collection('History')
        .orderBy('time')
        .snapshots();
  }

  addcustomerdetails(String uid,int time, customerDetails,) async {
  FirebaseFirestore.instance.collection("UserDetails").doc(uid)
      .collection("AllCustomerDetails").doc(time.toString()).set(customerDetails).then((_){
  Fluttertoast.showToast(
  msg: 'Details saved successfully!!!',
  toastLength: Toast.LENGTH_SHORT,
  //gravity: ToastGravity.SNACKBAR,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.white30,
  textColor: Colors.black);
  }).catchError((e){
  Fluttertoast.showToast(
  msg: 'Unknown Error!!!',
  toastLength: Toast.LENGTH_SHORT,
  //gravity: ToastGravity.SNACKBAR,
  timeInSecForIosWeb: 1,
  backgroundColor: Colors.red,
  textColor: Colors.black);
  });
  }

   addcustomerHistory(String uid, historyData, String userid)async {
     FirebaseFirestore.instance.collection("UserDetails").doc(uid)
         .collection("AllCustomerDetails").
         doc(userid).collection("History").add(historyData).then((_){
       Fluttertoast.showToast(
           msg: 'Payment updated successfully!!!',
           toastLength: Toast.LENGTH_SHORT,
           //gravity: ToastGravity.SNACKBAR,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.white30,
           textColor: Colors.black);
     }).catchError((e){
       Fluttertoast.showToast(
           msg: 'Unknown Error!!!',
           toastLength: Toast.LENGTH_SHORT,
           //gravity: ToastGravity.SNACKBAR,
           timeInSecForIosWeb: 1,
           backgroundColor: Colors.red,
           textColor: Colors.black);
     });
   }

  getuserdata(String uid) async{
    return  FirebaseFirestore.instance.collection("UserDetails").doc(uid)
        .collection("AllCustomerDetails")
        .orderBy('time',descending: true)
        .snapshots();
  }

}