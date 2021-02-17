import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata/ExistingUserData.dart';
import 'package:khata/Home.dart';
import 'package:khata/NewUserRegister.dart';
import 'package:khata/Profile.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/customer.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';

class PayScreen extends StatefulWidget {
  final String phone,userid;
  PayScreen(this.phone,this.userid);
  @override
  PayScreenState createState() => PayScreenState();
}

class PayScreenState extends State<PayScreen> {

  int selectedIndex=0;
  String uniqueid="";
  String amount="",date="",interest="",paidamount="",additionalinfo="";
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController currentdateEditingController = new TextEditingController();
  TextEditingController currentamountEditingController = new TextEditingController();
  TextEditingController noteEditingController = new TextEditingController();
  @override
  void initState()  {
    getuserinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          color: Colors.black,
          child:Column(
            children: <Widget>[
              Container(
                height: 250.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage('images/pay.jpg'),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.black,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,bottom: 10.0),
                child: Text('Update the payment ',style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,left: 20.0,right: 20.0,bottom: 15.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 10.0,
                  child: Container(

                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 25.0,right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Date :\t",
                                overflow: TextOverflow.ellipsis,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                date,style: TextStyle(
                                fontSize: 18.0,
                              ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Amount :\t",
                                overflow: TextOverflow.ellipsis,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                amount,style: TextStyle(
                                fontSize: 18.0,
                              ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Paid Amount:\t",
                                overflow: TextOverflow.ellipsis,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                paidamount,style: TextStyle(
                                fontSize: 18.0,
                              ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Interest :\t",
                                overflow: TextOverflow.ellipsis,style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                interest,style: TextStyle(
                                fontSize: 18.0,
                              ),
                              ),
                            ],
                          ),
                        ),
                        Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                  child: TextFormField(
                                    decoration: textFieldInputDecoration('Enter today\'s date.'),
                                    keyboardType: TextInputType.datetime,
                                    controller: currentdateEditingController,
                                    validator:  (val){
                                      return val.length <= 4 ? "Please enter the date" : null;
                                    },
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                  child: TextFormField(
                                    decoration: textFieldInputDecoration('Enter the amount'),
                                    keyboardType: TextInputType.number,
                                    controller: currentamountEditingController,
                                    validator:  (val){
                                      return val.length >0 ? null:"Please enter a valid amount [0-9]";
                                    },

                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                  child: TextFormField(
                                    decoration: textFieldInputDecoration('Add a Note'),
                                    controller: noteEditingController,

                                  ),
                                ),
                                new Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0,left: 60.0),
                                        child: GestureDetector(
                                          onTap:() {
                                            canceldataitems();
                                          },
                                          child: new Container(
                                            alignment: Alignment.center,
                                            height: 50.0,
                                            width: 30.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: new BorderRadius.circular(40.0),
                                            ),
                                            child: new Text("Cancel ",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                                          ),

                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0,right: 60.0),
                                        child: GestureDetector(
                                          onTap:() {
                                            FocusScopeNode currentFocus = FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            if(formKey.currentState.validate()) {
                                              setState(() {
                                                isLoading = true;
                                              });
                                              savedata(amount);
                                            }

                                          },

                                          child: new Container(
                                            alignment: Alignment.center,
                                            height: 50.0,
                                            width: 30.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: new BorderRadius.circular(40.0),
                                            ),
                                            child: new Text("Save ",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 350.0,
                                )

                              ],
                            ),
                          ),

                        )
                      ],
                    ),
                  ),
                ),
              )

            ],
          )

      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.add), title: Text('New User')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profiles')),
        ],
        currentIndex: selectedIndex,
        fixedColor: Colors.black,
        onTap: onItemTapped,
      ),

    );
  }
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    if(selectedIndex==0)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home()));
    }
    else if(selectedIndex==1)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NewUserRegister()));
    }
    else if(selectedIndex==2)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  void getuserinfo() async{
    Constants.myemail=await HelperFunctions.getUserEmailSharedPreference();
    uniqueid=Constants.myemail+widget.phone;
    return FirebaseFirestore.instance.collection("UserDetails").doc(Constants.myemail)
        .collection("CustomerDetails")
        .doc(uniqueid)
        .collection("Information")
        .doc(widget.userid.toString())
        .get()
        .then((doc) {
         if (doc.exists) {
           setState(() {
             amount=doc.data()['Amount'];
             date=doc.data()['Date'];
             interest=doc.data()['Interest'];
             paidamount=doc.data()['PaidAmount'];
             additionalinfo=doc.data()['AdditionalInfo'];
           });

        }
         else
           {
             setState(() {
               isLoading = false;
               //print("INvalid");
               Fluttertoast.showToast(
                   msg: 'Loading Error',
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

  void canceldataitems() {
    setState(() {
      currentamountEditingController.text="";
      currentdateEditingController.text="";
      noteEditingController.text="";
    });
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ExistingUserData(
                    uniqueid)));

  }

  void savedata(String amount) {
    Map<String, dynamic> HistoryData = {
      "Date": currentdateEditingController.text,
      "Note": noteEditingController.text,
      "PaidAmount":currentamountEditingController.text,
      "ActualAmount":amount,
      'time': DateTime
          .now()
          .millisecondsSinceEpoch,
    };
    DatabaseMethods().addHistory(Constants.myemail,uniqueid, HistoryData,widget.userid);
    DatabaseMethods().addcustomerHistory(Constants.myemail, HistoryData,widget.userid);
    int amountpaid=(int.parse(paidamount) + int.parse(currentamountEditingController.text));
    FirebaseFirestore.instance.collection("UserDetails").doc(Constants.myemail)
        .collection("CustomerDetails")
        .doc(uniqueid).collection("Information").doc(widget.userid).update(
        {
          "PaidAmount": amountpaid.toString(),
          "AdditionalInfo":additionalinfo+noteEditingController.text,
        });
    FirebaseFirestore.instance.collection("UserDetails").doc(Constants.myemail)
        .collection("AllCustomerDetails")
        .doc(widget.userid).update(
        {
          "PaidAmount": amountpaid.toString(),
          "AdditionalInfo":additionalinfo+noteEditingController.text,
        });
    setState(() {
      paidamount=amountpaid.toString();
      currentamountEditingController.text="";
      currentdateEditingController.text="";
      noteEditingController.text="";
    });

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

