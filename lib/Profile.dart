import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata/Aboutus.dart';
import 'package:khata/Alluserdata.dart';
import 'package:khata/Home.dart';
import 'package:khata/PrivacyPolicy.dart';
import 'package:khata/Reset.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/helper.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int selectedIndex=2;
  @override
  void initState() {
     getuserinfo();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          backgroundColor: Colors.black,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(70),
                    image: DecorationImage(
                      image: AssetImage('images/icon.jpeg'),
                      fit: BoxFit.cover,
                    )
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Text('Welcome',style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontFamily: 'GreatVibes',
                fontSize: 40,
              ),),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(Constants.myName+"!",style: TextStyle(
                color: Colors.cyan,
                fontWeight: FontWeight.bold,
                fontFamily: 'GreatVibes',
                fontSize: 40,
              ),),
            ),
            cardbutton('Reset Password',context, MaterialPageRoute(builder: (context) => ResetScreen())),
            cardbutton('About Us',context, MaterialPageRoute(builder: (context) => Aboutus())),
            cardbutton('Privacy Policy',context, MaterialPageRoute(builder: (context) => PrivacyPolicy())),
          ],
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

  void getuserinfo() async{
    Constants.myName=await HelperFunctions.getUserNameSharedPreference();
  }

}
Widget cardbutton( String title, BuildContext context, MaterialPageRoute materialPageRoute )
{
  return Padding(
    padding: EdgeInsets.only(left: 10,top:20,right: 10),
    child: FlatButton(
      onPressed: (){
        Navigator.push(context, materialPageRoute );
      },
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        elevation: 5.0,
        child: Container(
          height: 60,
          width: 450,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            color: Colors.white24,
          ),
          child: Center(
            child: Text(title,style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'serif',
            ),),
          ),
        ),
      ),
    ),
  );
}

