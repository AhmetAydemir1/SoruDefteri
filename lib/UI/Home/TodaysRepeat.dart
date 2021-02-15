import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:soru_defteri/Models/Strings.dart';
import 'package:soru_defteri/UI/SoruIci.dart';

class TodaysRepeat extends StatefulWidget {
  @override
  _TodaysRepeatState createState() => _TodaysRepeatState();
}

class _TodaysRepeatState extends State<TodaysRepeat>
    with SingleTickerProviderStateMixin {
  int tabIndex = 0;
  List dersler = [];

  User user = FirebaseAuth.instance.currentUser;

  TabController tabController;
  QuerySnapshot querySnapshot;
  List<DocumentSnapshot> myDocs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    startSync();
  }

  startSync() async {
    /*await FirebaseFirestore.instance
        .collection("Sorular").where("ders",isEqualTo:"Coğrafya").where("konu",isEqualTo: "Doğa ve İnsan")
        .where("paylasanID", isEqualTo: user.uid)
        .orderBy("date",
        descending:
        tabIndex == 0 ? true : false)
        .get()
        .then((value) async {
      *//*for(DocumentSnapshot ds in value.docs){
          await FirebaseFirestore.instance.collection("Sorular").doc(ds.id).set({"tekrarNum":0,"tekrarYapilacak":DateTime.now().add(Duration(days: 2)),"tekrarTime":DateTime.now(),"tekrar":true},SetOptions(merge: true));
          }*//*
    });*/
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            title: Text(
              "Tüm Sorular",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: AppBar().preferredSize.height),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF616798),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              MediaQuery.of(context).size.width / 10))),
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      MediaQuery.of(context).size.width / 10)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF4F44DA),
                                    Color(0xFF8181A2)
                                  ],
                                  stops: [
                                    0.6,
                                    1
                                  ])),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Color(0xff6453F6),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11.0),
                                    child: TabBar(
                                      labelPadding: EdgeInsets.zero,
                                      indicatorPadding: EdgeInsets.zero,
                                      indicatorColor: Colors.white,
                                      indicator: BubbleTabIndicator(
                                          indicatorRadius: 15,
                                          indicatorColor: Color(0xFF00AD89),
                                          indicatorHeight: 35),
                                      unselectedLabelColor: Color(0xFF4D4FBB),
                                      controller: tabController,
                                      onTap: (index) {
                                        setState(() {
                                          if (index == 0) {
                                            dersler = MyStrings().classesTYT;
                                          } else {
                                            dersler = MyStrings().classesAYT;
                                          }
                                          tabIndex = index;
                                        });
                                      },
                                      tabs: [
                                        Tab(
                                            icon: Text(
                                          "ESKİDEN YENİYE",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25),
                                        )),
                                        Tab(
                                            icon: Text(
                                          "YENİDEN ESKİYE",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  25),
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("Sorular")
                                      .where("paylasanID", isEqualTo: user.uid)
                                      .orderBy("date",
                                          descending:
                                              tabIndex == 0 ? false : true)
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      return ListView(
                                        padding: EdgeInsets.zero,
                                        children: snapshot.data.docs.map((doc) {
                                          if (doc["tekrarNum"] == 0 &&
                                              doc["tekrarTime"]
                                                  .toDate()
                                                  .isBefore(DateTime.now()
                                                      .subtract(
                                                          Duration(days: 1)))) {
                                            return myListTile(
                                                DateFormat.MMMMEEEEd('tr_TR')
                                                    .format(
                                                        doc["date"].toDate()),
                                                "${doc["ders"] + " - " + doc["konu"]} 1. Tekrar",
                                                doc,
                                                snapshot.data.docs);
                                            //return ListTile(title: Text("bi gün sonra tekrar"),onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: doc, docList: snapshot.data.docs))));
                                          } else if (doc["tekrarNum"] == 1 &&
                                              doc["tekrarTime"]
                                                  .toDate()
                                                  .isBefore(DateTime.now()
                                                      .subtract(
                                                          Duration(days: 6)))) {
                                            return myListTile(
                                                DateFormat.MMMMEEEEd('tr_TR')
                                                    .format(
                                                        doc["date"].toDate()),
                                                "${doc["ders"] + " - " + doc["konu"]} 2. Tekrar",
                                                doc,
                                                snapshot.data.docs);
                                            //return ListTile(title: Text("7 gün sonra"),onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: doc, docList: snapshot.data.docs))));
                                          } else if (doc["tekrarNum"] == 2 &&
                                              doc["tekrarTime"]
                                                  .toDate()
                                                  .isBefore(DateTime.now()
                                                      .subtract(Duration(
                                                          days: 22)))) {
                                            return myListTile(
                                                DateFormat.MMMMEEEEd('tr_TR')
                                                    .format(
                                                        doc["date"].toDate()),
                                                "${doc["ders"] + " - " + doc["konu"]} 3. Tekrar",
                                                doc,
                                                snapshot.data.docs);

                                            //return ListTile(title: Text("28 gün sonra"),onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: doc, docList: snapshot.data.docs))));
                                          } else {
                                            return Container();
                                            //return ListTile(title: Text("en els"),onTap:()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: doc, docList: snapshot.data.docs))));
                                          }
                                        }).toList(),
                                      );
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myListTile(String title, subtitle, DocumentSnapshot doc,
      List<DocumentSnapshot> docsList) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF4843CA),
            Color(0xFF5958B0)],
        ),
      ),
      child: ListTile(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SoruCoz(doc: doc, docList: docsList))),
        contentPadding: EdgeInsets.zero,

        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  height: 30,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        title,
                        style: TextStyle(color: Colors.white),
                      ))),
            ),Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Container(
                  height: 20,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        subtitle,
                        style: TextStyle(color: Colors.white,fontSize: 14),
                      ))),
            )
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4842CA),
              Color(0xFF6463A3)],
          )),
          height: 200,
          width: 40,
          child: Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
