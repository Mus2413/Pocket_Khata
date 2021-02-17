import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khata/Home.dart';
import 'package:khata/NewUserRegister.dart';
import 'package:khata/PayScreen.dart';
import 'package:khata/Profile.dart';
import 'package:khata/Services/Constants.dart';
import 'package:khata/Services/customer.dart';
import 'package:khata/Services/database.dart';
import 'package:khata/Services/helper.dart';

class HistoryScreen extends StatefulWidget {
  final String time,phone;
  HistoryScreen(this.phone,this.time);
  @override
  HistoryScreenState createState() => HistoryScreenState();
}

class  HistoryScreenState extends State<HistoryScreen> {
  int selectedIndex=0;
  String Uniqueid="";
  Stream<QuerySnapshot>History ;

  Widget chatMessages(){
    return StreamBuilder(
      stream: History,
      builder: (context, snapshot){
        return snapshot.hasData ?  ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              return MessageTile(
                amount: snapshot.data.docs[index].data()["ActualAmount"],
                date: snapshot.data.docs[index].data()["Date"],
                additionalInfo: snapshot.data.docs[index].data()["Note"],
                paidamount: snapshot.data.docs[index].data()["PaidAmount"],
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
      backgroundColor: Colors.black,
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
                  image:AssetImage('images/history.jpg'),
                  fit: BoxFit.fill,
                ),
                color: Colors.black,),
            ),
            Text('History:-',style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),),
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

  void getuserinfo() async {
    Constants.myemail=await HelperFunctions.getUserEmailSharedPreference();
    Uniqueid=Constants.myemail+widget.phone;
    DatabaseMethods().gethistorydata(Constants.myemail,Uniqueid,widget.time).then((val) {
      setState(() {
        History = val;
      });
    });

  }



}
class MessageTile extends StatelessWidget {
  final String amount,date,paidamount,additionalInfo;
  final int time;

  MessageTile({@required this.amount, @required this.date,@required this.paidamount,
    @required this.additionalInfo,@required this.time
    });

   bool isleft=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Expanded(
        child: Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomRight: Radius.circular(23)),
            color: Colors.white
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:10.0,left:20.0 ,right:10,bottom: 5),
                child: Row(
                  children: <Widget>[
                    Text(
                      "Date :\t",
                      overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      date,style: TextStyle(

                      fontSize: 15.0,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                    ),
                    Text(
                      amount ,style: TextStyle(
                      fontSize: 15.0,
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
                      fontSize: 15.0,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      paidamount, overflow: TextOverflow.ellipsis,style: TextStyle(
                      fontSize: 15.0,
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
                      fontSize: 15.0,
                    ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        additionalInfo==Null?"":additionalInfo, overflow: TextOverflow.ellipsis,
                        maxLines:10,style: TextStyle(
                        fontSize: 15.0,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }


}

