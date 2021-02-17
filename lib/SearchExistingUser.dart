import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:khata/ExistingUserData.dart';
import 'package:khata/Home.dart';
import 'package:khata/Loginpage.dart';
import 'package:khata/NewUserRegister.dart';
import 'package:khata/Profile.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';



class SearchExistingUser extends StatefulWidget{
  @override
  SearchExistingUserstate createState() => SearchExistingUserstate();

}
class SearchExistingUserstate extends State<SearchExistingUser> {
  TextEditingController nameEditingController = new TextEditingController();
  TextEditingController phoneEditingController = new TextEditingController();
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
                height: 280.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage('images/search.jpg'),
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
                    height: 430,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),

                    ),
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Text('Search User',style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,

                          ),

                          ),
                        ),
                        Form(
                          key:formKey,
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
                                    controller: phoneEditingController,
                                    validator:  (val){
                                      return val.length ==10? null:"Enter a valid Phone Number" ;
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
                                                    isLoading=true;
                                                  });

                                                  String uniqueid = Constants
                                                      .myemail +
                                                      phoneEditingController
                                                          .text;
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ExistingUserData(
                                                                  uniqueid)));
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
                                            child: new Text("Search User ",style: TextStyle(fontSize: 20.0,color: Colors.white)),
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

  void getuserinfo() async {
    Constants.myemail=await HelperFunctions.getUserEmailSharedPreference();
  }



}
InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.black),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan.shade700)),
      //UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan.shade700)),
      enabledBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.cyan.shade700)));
      //UnderlineInputBorder(borderSide: BorderSide(color: Colors.cyan.shade700)));
}

