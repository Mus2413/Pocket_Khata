import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata/Alluserdata.dart';
import 'package:khata/NewUserRegister.dart';
import 'package:khata/Profile.dart';
import 'package:khata/SearchExistingUser.dart';
import 'package:khata/Services/Authentication.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/auth.dart';
import 'package:khata/Services/helper.dart';
import 'package:khata/khata.dart';
import 'package:khata/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();

}
class _HomeState extends State<Home>{
  int selectedIndex=0;
  @override
  void initState() {
    getuserinfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                  height: 250.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image:DecorationImage(
                      image:AssetImage('images/img1.jpg'),
                      fit: BoxFit.fill,
                    ),
                  color: Colors.black,),
                   child: Column(
                     children:<Widget>[
                       Align(
                          alignment: Alignment.topRight,
                         child: IconButton(
                          icon: Icon(Icons.exit_to_app),
                          color: Colors.black,
                          onPressed: () async{
                            HelperFunctions.saveUserLoggedInSharedPreference(false);
                            AuthService().signOut();
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => khata()));
                          },
                      ),
                       ),
                     ]
                   ),
                ),
                   Padding(
                     padding: const EdgeInsets.only(top: 50.0),
                     child: Container(
                      height: 120.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        color: Colors.black,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 25.0,
                            ),
                            TextUsername(name: Constants.myName), Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ],
                            ),
                          ]
                      ),
                  ),
                   ),
                  Padding(
                 padding: EdgeInsets.only(left: 20.0 ,top: 10,bottom: 10),
                     child: Text(
                 'Explore -',
                  style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                  fontFamily: 'SourceRegular'
              ),
            ),
          ),
                SizedBox(height: 10.0,),
                Row(
                 children: <Widget>[
                 cardbutton('New', 'images/newuser.png' ,context, MaterialPageRoute(builder: (context) => NewUserRegister())),
                 cardbutton('Existing', 'images/existinguser.png',context, MaterialPageRoute(builder: (context) => SearchExistingUser()) ),
            ],
                ),
                  SizedBox(height: 30.0,),
           ],
          ),
              Positioned(
                top: 185,
                left: (MediaQuery.of(context).size.width /2 - 65.0),
                child: Container(
                  height: 130.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(65.0),
                      image: DecorationImage(
                        image: AssetImage('images/icon.jpeg'),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ),
        ],
      ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
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
    await HelperFunctions.getUserNameSharedPreference().then((value){
      setState(() {
        Constants.myName  = value as String;
        //print(userIsLoggedIn);
      });
    });

  }
}


class TextUsername extends StatelessWidget {
  TextUsername({this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
       '$name',
      style: TextStyle(
          fontFamily: 'GreatVibes',
          fontSize: 40.0,
          color: Colors.white,
          fontWeight: FontWeight.bold
      ),
    );
  }
}

Widget cardbutton( String title,String imgaddress, BuildContext context, MaterialPageRoute materialPageRoute )
{
  return Padding(
    padding: EdgeInsets.only(left: 10),
    child: FlatButton(
      onPressed: (){
        Navigator.pushReplacement(context, materialPageRoute);
      },
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
        child: Container(
          height: 180.0,
          width: 150.0,          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.teal[100],
          ),
          child: Column(
            children: <Widget>[
              SizedBox(height:20.0,),
              Container(
                height: 80.0,
                width: 80.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: AssetImage(imgaddress),
                      fit: BoxFit.cover,
                    )
                ),
              ),
              SizedBox(width: 20.0,),
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'serif',
                    color: Colors.black
                ),
              ),
              Text(
                'User',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                    fontFamily: 'serif',
                    color: Colors.black
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}

