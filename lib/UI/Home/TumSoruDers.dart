import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/Models/Strings.dart';
import 'package:soru_defteri/UI/Home/TumSoruKonular.dart';

class TumSoruDersler extends StatefulWidget {
  @override
  _TumSoruDerslerState createState() => _TumSoruDerslerState();
}

class _TumSoruDerslerState extends State<TumSoruDersler>
    with SingleTickerProviderStateMixin {

  List dersler=MyStrings().classesTYT;
  int tabIndex=0;

  User user=FirebaseAuth.instance.currentUser;

  TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    startSync();
  }

  startSync() async {

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
                                        // Tab index when user select it, it start from zero
                                        setState(() {
                                          if(index==0){
                                            dersler=MyStrings().classesTYT;
                                          }else{
                                            dersler=MyStrings().classesAYT;
                                          }
                                          tabIndex=index;
                                        });
                                      },
                                      tabs: [
                                        Tab(
                                            icon: Text(
                                              "TYT",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                      25),
                                            )),
                                        Tab(
                                            icon: Text(
                                              "AYT",
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
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children: dersler.map((e) {
                                    return StreamBuilder(stream: FirebaseFirestore.instance.collection("Sorular").where("paylasanID",isEqualTo: user.uid).where("ders",isEqualTo: e).where("sinav",isEqualTo: tabIndex==0?"TYT":"AYT").snapshots(),builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      if(!snapshot.hasData){
                                        return Container(
                                          decoration: BoxDecoration(gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF4843CA),
                                              Color(0xFF5958B0)
                                            ],
                                          )),
                                          child: ListTile(
                                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TumSoruKonular(ders: e, sinav: tabIndex==0?"TYT":"AYT"))),
                                            contentPadding: EdgeInsets.zero,
                                            leading: Container(height: 50,width: 50,child: Align(child: Container(
                                              height: 30,width: 30,
                                              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xff5652B5)),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: FittedBox(child: Text("...",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white,fontSize: 100),)),
                                                ),
                                              ),
                                            ))),
                                            title: Container(height: 50,child: Align(alignment: Alignment.centerLeft,child: Text(e,style: TextStyle(color: Colors.white),))),
                                            trailing: Container(decoration: BoxDecoration(gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xFF4F44DA),
                                                Color(0xFF8181A2)
                                              ],
                                            )),height: double.maxFinite,width: 40,child: Icon(Icons.arrow_forward,color: Colors.white,),),
                                          ),
                                        );
                                      }else{
                                        print(snapshot.data.docs.length);
                                        return Container(
                                          decoration: BoxDecoration(gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF4843CA),
                                              Color(0xFF5958B0)
                                            ],
                                          )),
                                          child: ListTile(
                                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>TumSoruKonular(ders: e, sinav: tabIndex==0?"TYT":"AYT"))),
                                            contentPadding: EdgeInsets.zero,
                                            leading: Container(height: 50,width: 50,child: Align(child: Container(
                                              height: 30,width: 30,
                                              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xff5652B5)),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: FittedBox(child: Text(snapshot.data.docs.length.toString(),style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white,fontSize: 100),)),
                                                ),
                                              ),
                                            ))),
                                            title: Container(height: 50,child: Align(alignment: Alignment.centerLeft,child: Text(e,style: TextStyle(color: Colors.white),))),
                                            trailing: Container(decoration: BoxDecoration(gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xFF4F44DA),
                                                Color(0xFF8181A2)
                                              ],
                                            )),height: double.maxFinite,width: 40,child: Icon(Icons.arrow_forward,color: Colors.white,),),
                                          ),
                                        );}
                                    },);
                                  }).toList(),
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
}
