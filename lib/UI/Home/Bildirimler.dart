import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Bildirimler extends StatefulWidget {
  @override
  _BildirimlerState createState() => _BildirimlerState();
}

class _BildirimlerState extends State<Bildirimler> {
  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shadowColor: Colors.transparent,
            title: Row(
              children: [
                Icon(Icons.notifications),
                SizedBox(width: 5,),
                Text(
                  "Bildirimler",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            backgroundColor: Colors.transparent,
            actions: [IconButton(icon: Icon(Icons.clear),onPressed: ()=>Navigator.pop(context),)],
          ),
          body: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Users").doc(user.uid).collection("Bildirimler").orderBy("date",descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                  if (snapshots.hasData) {
                    return Expanded(
                      child: ListView(
                        children: snapshots.data.docs.map((e) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal:8.0),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Color(0xff9093B3),width: 1),
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      gradient: LinearGradient(
                                          colors: [
                                            Color(0xFF228FB6),
                                            Color(0xFF6453F5),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter)),
                                  child: ListTile(
                                    title: Text(e["title"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                                    subtitle: Text(e["body"],style: TextStyle(color: Colors.white)),
                                    leading: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(100)),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(0xff4984C3),
                                                  Color(0xFF00AE88),
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter)),child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical:8.0,horizontal: 15),
                                                  child: Image.asset("assets/images/justLogo100x100.png",scale: 3,),
                                                ),),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.access_time_rounded,color: Colors.white,size: 15,),
                                        SizedBox(width: 2,),
                                        Text(gosterZaman(e["date"]),style: TextStyle(color: Colors.white),),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5  ,)
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
              SizedBox(height: 20,),
              Image.asset("assets/images/justLabel.png",scale: 4,),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  String gosterZaman(Timestamp timeStamp) {
    DateTime time = timeStamp.toDate();
    String bugunStr; /*DateFormat("dd:MM").format(time)*/
    if (time.isBefore(DateTime.now().subtract(Duration(days: 3)))) {
      bugunStr = DateFormat("dd/MM/yy").format(time);
    } else if (time.isBefore(DateTime.now().subtract(Duration(days: 2)))) {
      bugunStr = "2 Gün Önce";
    } else if (time.isBefore(DateTime.now().subtract(Duration(days: 1)))) {
      bugunStr = "Dün";
    } else {
      bugunStr = DateFormat("HH:mm").format(time);
    }

    return bugunStr;
  }
}
