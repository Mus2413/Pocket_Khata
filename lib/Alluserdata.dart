import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata/HistoryScreen.dart';
import 'package:khata/Home.dart';
import 'package:khata/NewUserRegister.dart';
import 'package:khata/PayScreen.dart';
import 'package:khata/Profile.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/customer.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';

class AllUserData extends StatefulWidget {
  @override
  AllUserDataState createState() => AllUserDataState();
}

class AllUserDataState extends State<AllUserData> {
  int selectedIndex=0;

  Stream<QuerySnapshot>Information ;

  Widget chatMessages(){
    return StreamBuilder(
      stream: Information,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              return MessageTile(
                amount: snapshot.data.docs[index].data()["Amount"],
                date: snapshot.data.docs[index].data()["Date"],
                interest: snapshot.data.docs[index].data()["Interest"],
                duration: snapshot.data.docs[index].data()["Duration"],
                address: snapshot.data.docs[index].data()["Address"],
                itemdetail: snapshot.data.docs[index].data()["ItemDetails"],
                name: snapshot.data.docs[index].data()["Name"],
                paidamount: snapshot.data.docs[index].data()["PaidAmount"],
                additionalInfo: snapshot.data.docs[index].data()["AdditionalInfo"],
                time: snapshot.data.docs[index].data()["time"],
                phone: snapshot.data.docs[index].data()["PhoneNumber"],
              );
            }) : Container(
          child: Center(
            child: Text(
              "No Data",style: TextStyle(
                fontSize:40,
                color: Colors.white
            ),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState()  {

    getuserinfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body:ListView(
          children: <Widget>[
            Container(
              color: Colors.black,
              child:Column(
                children: <Widget>[
                  Container(
                    height: 250.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image:DecorationImage(
                        image:AssetImage('images/information.jpg'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.black,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:10.0,bottom: 5.0),
                    child: Text('All User Data :- ',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'serif',
                      color: Colors.white,
                    ),),
                  ),
                  Container(
                    height: 420,
                    child: Stack(
                      children: [
                        chatMessages(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ]),
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

  TextStyle simpleTextStyle() {
    return TextStyle(color: Colors.black, fontSize: 16);
  }

  void getuserinfo() async{
    Constants.myemail=await HelperFunctions.getUserEmailSharedPreference();
    DatabaseMethods().getuserdata(Constants.myemail).then((val) {
      setState(() {
        Information= val;
      });
    });
  }



}

class MessageTile extends StatelessWidget {
  final String amount,date,interest,address,itemdetail,duration,name,paidamount,additionalInfo,phone;
  final int time;

  MessageTile({@required this.amount, @required this.date,@required this.interest,@required this.address,
    @required this.itemdetail,@required this.duration, @required this.name,@required this.paidamount,@required this.additionalInfo,@required this.time
    ,@required this.phone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
              color: Colors.blueGrey[900]
          ),
          child: Column(
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    date,
                    overflow: TextOverflow.ellipsis,style: TextStyle(
                    color: Colors.deepOrangeAccent,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10.0,left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Item Details :\t",
                      overflow: TextOverflow.ellipsis,style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        itemdetail,style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children:<Widget> [

                    Text(
                      "Name :\t",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        name,
                        maxLines:3,
                        overflow: TextOverflow.ellipsis,style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
               Padding(
                    padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                   child: Row(
                    children:<Widget> [
                      Text(
              "Phone Number :\t",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white
              ),
            ),
                    SizedBox(
              width: 15,
            ),
                    Expanded(
                     child: Text(
                phone,
                maxLines:3,
                overflow: TextOverflow.ellipsis,style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              ),
            ),
          ],
        ),
        ),
              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Amount : \t",
                      overflow: TextOverflow.ellipsis,style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      amount ,style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Paid Amount : \t',style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      paidamount, overflow: TextOverflow.ellipsis,style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Interest : \t",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      interest, overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,

                    ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Duration : \t",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      duration, overflow: TextOverflow.ellipsis,style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Address : \t",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        address,
                        maxLines:10,style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Additional Info: \t",style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.white
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        additionalInfo==Null?"":additionalInfo,
                        maxLines:10,style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap:() {
                    Navigator.push(context, MaterialPageRoute(builder:  (context) =>HistoryScreen(phone,time.toString())));
                  },

                  child: new Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: 200.0,
                    decoration: new BoxDecoration(
                      color: Colors.black,
                      borderRadius: new BorderRadius.circular(40.0),
                    ),
                    child: new Text("History ",style: TextStyle(fontSize: 20.0,color: Colors.white)),
                  ),

                ),
              ),
              SizedBox(
                height: 20.0,
              ),
        ],
         ),
        ),
      ),
    );
  }
}

