import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/Models/Strings.dart';
import 'package:soru_defteri/UI/SoruIci.dart';

class TumSoruKonular extends StatefulWidget {
  String sinav,ders;
  TumSoruKonular({@required this.ders,@required this.sinav,});
  @override
  _TumSoruKonularState createState() => _TumSoruKonularState();
}

class _TumSoruKonularState extends State<TumSoruKonular> {
  List konular=[];
  String ders,sinav;
  User user=FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    ders=widget.ders;
    sinav=widget.sinav;
    if (sinav == "TYT") {
      if (ders == "Türkçe") {
        konular = MyStrings().turkceTYT;
      } else if (ders == "Biyoloji") {
        konular = MyStrings().biyolojiTYT;
      } else if (ders == "Coğrafya") {
        konular = MyStrings().cografyaTYT;
      } else if (ders == "Din") {
        konular = MyStrings().dinTYT;
      } else if (ders == "Felsefe") {
        konular = MyStrings().felsefeTYT;
      } else if (ders == "Fizik") {
        konular = MyStrings().fizikTYT;
      } else if (ders == "Geometri") {
        konular = MyStrings().geoTYT;
      } else if (ders == "Kimya") {
        konular = MyStrings().kimyaTYT;
      } else if (ders == "Matematik") {
        konular = MyStrings().matematikTYT;
      } else if (ders == "Tarih") {
        konular = MyStrings().tarihTYT;
      }
    } else {
      if (ders == "Biyoloji") {
        konular = MyStrings().bioAYT;
      } else if (ders == "Coğrafya") {
        konular = MyStrings().cografyaAYT;
      } else if (ders == "Fizik") {
        konular = MyStrings().fizikAYT;
      } else if (ders == "Geometri") {
        konular = MyStrings().geoAYT;
      } else if (ders == "Kimya") {
        konular = MyStrings().kimyaAYT;
      } else if (ders == "Matematik") {
        konular = MyStrings().matematikAYT;
      } else if (ders == "Tarih") {
        konular = MyStrings().tarihAYT;
      }
    }
    print(konular);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
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
                                    Color(0xFF4C5590),
                                    Color(0xFF8181A2)
                                  ],
                                  stops: [
                                    0.6,
                                    1
                                  ])),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Expanded(
                                child: ListView(
                                  padding: EdgeInsets.zero,
                                  children: konular.map((e) {
                                    return StreamBuilder(stream: FirebaseFirestore.instance.collection("Sorular").where("paylasanID",isEqualTo: user.uid).where("ders",isEqualTo: ders).where("konu",isEqualTo: e).where("sinav",isEqualTo: sinav).snapshots(),builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                                      if(!snapshot.hasData){
                                        return Container(
                                          decoration: BoxDecoration(gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Color(0xFF4E5691),
                                              Color(0xFF5C6291)
                                            ],
                                          )),
                                          child: ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            leading: Container(height: 50,width: 50,child: Align(child: Container(
                                              height: 30,width: 30,
                                              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xff5E6290)),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(4.0),
                                                  child: FittedBox(child: Text("..",style: TextStyle(fontWeight: FontWeight.w200,color: Colors.white,fontSize: 100),)),
                                                ),
                                              ),
                                            ))),
                                            title: Container(height: 50,child: Align(alignment: Alignment.centerLeft,child: Text(e,style: TextStyle(color: Colors.white),))),
                                            trailing: Container(decoration: BoxDecoration(gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xFF4F5791),
                                                Color(0xFF666991)
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
                                              Color(0xFF4E5691),
                                              Color(0xFF5C6291)
                                            ],
                                          )),
                                          child: ListTile(
                                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: snapshot.data.docs[0],docList: snapshot.data.docs,shuffle: true,))),
                                            contentPadding: EdgeInsets.zero,
                                            leading: Container(height: 50,width: 50,child: Align(child: Container(
                                              height: 30,width: 30,
                                              decoration: BoxDecoration(shape: BoxShape.circle,color: Color(0xff5E6290)),
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
                                                Color(0xFF4F5791),
                                                Color(0xFF666991)
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
