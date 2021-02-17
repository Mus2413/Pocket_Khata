import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata/Alluserdata.dart';
import 'package:khata/Home.dart';
import 'package:khata/Loginpage.dart';
import 'package:khata/Profile.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';

class NewUserRegister extends StatefulWidget{
  @override
  NewUserRegisterstate createState() => NewUserRegisterstate();

}
class NewUserRegisterstate extends State<NewUserRegister> {
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
  TextEditingController altphoneEditingController = new TextEditingController();
  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController addressEditingController = new TextEditingController();
  TextEditingController dateEditingController = new TextEditingController();
  TextEditingController itemdetailEditingController = new TextEditingController();
  TextEditingController amountEditingController = new TextEditingController();
  TextEditingController interestEditingController = new TextEditingController();
  TextEditingController durationEditingController = new TextEditingController();
  TextEditingController additionalEditingController = new TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int selectedIndex=1;
  @override
  void initState() {
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
                    image:AssetImage('images/Register.jpg'),
                    fit: BoxFit.fill,
                  ),
                  color: Colors.black,),
              ),
              Padding(
                padding: const EdgeInsets.only(top:15.0,left: 20.0,right: 20.0,bottom: 15.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  elevation: 10.0,
                  child: Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Text('Enter the details',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,

                          ),

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
                                      decoration: textFieldInputDecoration('Name'),
                                      controller: nameEditingController,
                                      validator:  (val){
                                        return val.length <= 4 ? "Enter Name 4+ characters" : null;
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Phone Number'),
                                      keyboardType: TextInputType.number,
                                      controller: phoneEditingController,
                                      validator:  (val){
                                        return val.length ==10 ? null:"Enter a valid Phone Number";
                                      },

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Alternative Phone Number'),
                                      keyboardType: TextInputType.number,
                                      controller: altphoneEditingController,
                                      validator:  (val){
                                        return val.length <0? "Enter a valid Phone Number" : null;
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
                                      decoration: textFieldInputDecoration('Address'),
                                      controller: addressEditingController,
                                      validator: (val){
                                        return val.length<5?"Enter a valid Address":null;
                                      },

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Date'),
                                      keyboardType: TextInputType.datetime,
                                      controller: dateEditingController,
                                      validator: (val){
                                        return val.length<5?"Please enter the date":null;
                                      },

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Item Details'),
                                      controller: itemdetailEditingController,
                                      validator: (val){
                                        return val.length<3?"Please enter the item details":null;
                                      },

                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Amount'),
                                      keyboardType: TextInputType.number,
                                      controller: amountEditingController,
                                      validator: (val){
                                        return val.length<=0?"Please enter the amount":null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Interest'),
                                      keyboardType: TextInputType.number,
                                      controller: interestEditingController,
                                      validator: (val){
                                        return val.length<=0?"Please enter the interest":null;
                                      },

                                    ),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Duration'),
                                      controller: durationEditingController,
                                      validator: (val){
                                        return val.length<=2?"Please enter the duration":null;
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top: 10, left: 25.0,right: 25.0),
                                    child: TextFormField(
                                      decoration: textFieldInputDecoration('Additional'),
                                      controller: additionalEditingController,
                                      validator: (val){
                                        return val.length<0?"Please enter the additional info":null;
                                      },
                                    ),
                                  ),
                                  new Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10.0,left: 60.0,right: 60.0),
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
                                                  adddetails();
                                                }
                                            },

                                            child: new Container(
                                              alignment: Alignment.center,
                                              height: 50.0,
                                              width: 30.0,
                                              decoration: new BoxDecoration(
                                                color: Colors.black,
                                                borderRadius: new BorderRadius.circular(20.0),
                                              ),
                                              child: new Text("Submit ",style: TextStyle(fontSize: 20.0,color: Colors.white)),
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
              icon: Icon(Icons.list), title: Text('All Users')),
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AllUserData()));
    }
    else if(selectedIndex==2)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Profile()));
    }
  }

  void getuserinfo() async {
    Constants.myemail=await HelperFunctions.getUserEmailSharedPreference();
  }

  void adddetails() async {
    String uniqueid=Constants.myemail+phoneEditingController.text;
    String paidamount="0";
    int time=DateTime.now().millisecondsSinceEpoch ;
    Map<String, dynamic> CustomerDetails = {
      "Name": nameEditingController.text,
      "Email": emailEditingController.text,
      "PhoneNumber":phoneEditingController.text,
      "AlternatePhoneNumber":altphoneEditingController.text,
      "Address":addressEditingController.text,
      "Date":dateEditingController.text,
      "ItemDetails":itemdetailEditingController.text,
      "Amount":amountEditingController.text,
      "Interest":interestEditingController.text,
      "Duration":durationEditingController.text,
      "AdditionalInfo": additionalEditingController.text,
      "PaidAmount":paidamount,
      'time': time,
    };

    DatabaseMethods().addMessage(Constants.myemail,uniqueid, CustomerDetails,time);
    DatabaseMethods().addcustomerdetails(Constants.myemail,time ,CustomerDetails);

    setState(() {


      nameEditingController.text="";
      phoneEditingController.text="";
      altphoneEditingController.text="";
      emailEditingController.text="";
      additionalEditingController.text="";
      itemdetailEditingController.text="";
      amountEditingController.text="";
      interestEditingController.text="";
      durationEditingController.text="";
      dateEditingController.text="";
      addressEditingController.text="";
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

