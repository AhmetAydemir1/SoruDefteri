import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:soru_defteri/UI/Home/TumSoruDers.dart';
import 'package:soru_defteri/UI/SoruIci.dart';
import 'package:soru_defteri/UI/Home/TodaysRepeat.dart';

class Repeat extends StatefulWidget {
  @override
  _RepeatState createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {

  User user = FirebaseAuth.instance.currentUser;

  List<DocumentSnapshot> favQuests=[];
  List<DocumentSnapshot> shuffleQuests=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync()async{
    await FirebaseFirestore.instance.collection("Sorular").where("paylasanID",isEqualTo: user.uid).where("liked",arrayContains: user.uid).get().then((docs) => favQuests=docs.docs);
    await FirebaseFirestore.instance.collection("Sorular").where("paylasanID",isEqualTo: user.uid).get().then((value) => shuffleQuests=value.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text("Tekrar Yap"),
          ),
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery
                            .of(context)
                            .size
                            .width / 30),
                    child: ClipRRect(
                      borderRadius:
                      BorderRadius.all(Radius.circular(
                          MediaQuery
                              .of(context)
                              .size
                              .width / 13)),
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF4F44DA),
                                  Color(0xFF8181A2)
                                ],
                                stops: [
                                  0.7,
                                  1
                                ])),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 30, right: 30, left: 30,),
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                      style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 32),
                                      children: [
                                        TextSpan(
                                          text: "Bugün tekrarlaman gereken toplam ",
                                        ),
                                        WidgetSpan(child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("Sorular")
                                              .where(
                                              "paylasanID", isEqualTo: user.uid)
                                              .snapshots(),
                                          builder: (context, AsyncSnapshot<
                                              QuerySnapshot> snapshot) {
                                            if (!snapshot.hasData) {
                                                return SizedBox(height: MediaQuery
                                                  .of(
                                                  context)
                                                  .size
                                                  .height /
                                                  30, width: MediaQuery
                                                  .of(
                                                  context)
                                                  .size
                                                  .height /
                                                  40, child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 2.0),
                                                child: JumpingDotsProgressIndicator(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  milliseconds: 100,
                                                ),
                                              ),);
                                            } else {
                                              int sayi=0;
                                              for(int i=0;i<snapshot.data.docs.length;i++){
                                                if((snapshot.data.docs[i].data().containsKey("tekrarNum")&&snapshot.data.docs[i]["tekrarNum"]!=3)||!snapshot.data.docs[i]["tekrar"]){
                                                  if(snapshot.data.docs[i].data().containsKey("tekrarNum")&&snapshot.data.docs[i]["tekrarNum"]!=3){
                                                    if(snapshot.data.docs[i]["tekrarNum"]==0&&snapshot.data.docs[i]["tekrarTime"].toDate().isBefore(DateTime.now().subtract(Duration(days: 1)))){
                                                      sayi=sayi+1;
                                                      print(snapshot.data.docs[i].id);

                                                    }else if(snapshot.data.docs[i]["tekrarNum"]==1&&snapshot.data.docs[i]["tekrarTime"].toDate().isBefore(DateTime.now().subtract(Duration(days: 6)))){
                                                      sayi=sayi+1;
                                                      print(snapshot.data.docs[i].id);

                                                    }else if(snapshot.data.docs[i]["tekrarNum"]==2&&snapshot.data.docs[i]["tekrarTime"].toDate().isBefore(DateTime.now().subtract(Duration(days: 22)))){
                                                      sayi=sayi+1;
                                                      print(snapshot.data.docs[i].id);

                                                    }
                                                  }
                                                }
                                              }
                                              return Text(
                                                sayi
                                                    .toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight
                                                        .bold,
                                                    color:
                                                    Color(
                                                        0xFF00AE87),
                                                    fontSize: MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .height /
                                                        35),
                                              );
                                            }
                                          },)),

                                        TextSpan(
                                          text: " sorun var.", //0xFFFF9600
                                        )
                                      ])),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 5,
                              height: 5,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Color(0xff00AE87)),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal:40.0),
                              child: RichText(
                                textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),
                                      children: [
                                        TextSpan(text: "Çözdüğün soruları "),
                                        TextSpan(text: "3 kez tekrar ederek\n",
                                            style: TextStyle(
                                                color: Color(0xff00AE87),fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: "tam olarak pekiştirebilirsin. Benzer tarzda karşına çıkan sorular için, hazır olmuş olursun. "),
                                      ]
                                  )),
                            ),
                            SizedBox(height: 30,),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        15),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>TodaysRepeat())),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 7),
                                                topRight: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                bottomLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                bottomRight:
                                                Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    0xFF5068EE),),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          right: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20),
                                                      child: Image
                                                          .asset(
                                                        "assets/images/repeatIcon.png",
                                                        height: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height /
                                                            10,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height /
                                                              200,
                                                          bottom: 1),
                                                      child: Text(
                                                        "Bugünkü\nTekrarların",
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 30,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          shuffle(shuffleQuests);
                                          if (shuffleQuests.isNotEmpty) {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: shuffleQuests[0], docList: shuffleQuests,shuffle: true,)));
                                          }else{
                                            Fluttertoast.showToast(msg: "Daha önce hiç soru yüklememişsiniz.");
                                          }
                                        },

                                        child: ClipRRect(
                                            borderRadius: BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                topRight: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 7),
                                                bottomLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                bottomRight:
                                                Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    0xFF41C6FF),),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          right: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20),
                                                      child: Image
                                                          .asset(
                                                        "assets/images/rastgele.png",
                                                        height: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height /
                                                            10,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height /
                                                              200,
                                                          bottom: 1),
                                                      child: Text(
                                                        "Rastgele\nSoru Çöz",
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .width / 30,),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width /
                                        15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (favQuests.isNotEmpty) {
                                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: favQuests[0], docList: favQuests,shuffle: true,)));
                                          }else{
                                            Fluttertoast.showToast(msg: "Daha önce hiç soru yüklememişsiniz.");
                                          }
                                        },
                                        child: ClipRRect(
                                            borderRadius: BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                topRight: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                bottomLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 7),
                                                bottomRight:
                                                Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    0xFF00AE87),),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          right: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20),
                                                      child: Image
                                                          .asset(
                                                        "assets/images/favoriler.png",
                                                        height: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height /
                                                            10,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height /
                                                              200,
                                                          bottom: 1),
                                                      child: Text(
                                                        "Favori\nSoruların",
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                    SizedBox(width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 30,),
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TumSoruDersler())),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                topRight: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                bottomLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 13),
                                                bottomRight:
                                                Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width / 7)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(
                                                    0xFFFF4800),),
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceEvenly,
                                                  mainAxisSize: MainAxisSize
                                                      .max,
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          left: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          right: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20,
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .width /
                                                              20),
                                                      child: Image
                                                          .asset(
                                                        "assets/images/allQuests.png",
                                                        height: MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .height /
                                                            10,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets
                                                          .only(
                                                          top: MediaQuery
                                                              .of(
                                                              context)
                                                              .size
                                                              .height /
                                                              200,
                                                          bottom: 1),
                                                      child: Text(
                                                        "Tüm\nSoruların",
                                                        textAlign: TextAlign
                                                            .center,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).padding.bottom+10,
                            ),
                          ],
                        ),
                      ),),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List shuffle(List items) {
    var random = new Random();

    // Go through all elements.
    for (var i = items.length - 1; i > 0; i--) {

      // Pick a pseudorandom number according to the list length
      var n = random.nextInt(i + 1);

      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }

    return items;
  }

}
