import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/AddQuest/BottomNav.dart';
import 'package:soru_defteri/UI/AddQuest/QuestDiff.dart';
import 'package:soru_defteri/UI/SoruKategori/Dersler.dart';

class EditorHome extends StatefulWidget {
  String realName;
  User user;
  EditorHome({@required this.realName,@required this.user,});
  @override
  _EditorHomeState createState() => _EditorHomeState();
}

class _EditorHomeState extends State<EditorHome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("editor");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Image.asset(
              "assets/images/justLabel.png",
              scale: 5,
            ),
            actions: [
              IconButton(
                  icon: Icon(Icons.notifications),
                  color: Colors.white,
                  onPressed: () {

                  })
            ],
            centerTitle: true,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Image.asset(
                  "assets/images/BG.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topRight,
                ),
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height + 20,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery
                                .of(context)
                                .size
                                .width / 30),
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 13.5),
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
                                            Color(0xFF565D93),
                                            Color(0xFF8181A2)
                                          ],
                                          stops: [
                                            0.7,
                                            1
                                          ])),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 40 + MediaQuery
                                            .of(context)
                                            .size
                                            .height / 13.5,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 60),
                                        child: Text(
                                          widget.realName,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height / 32),
                                        ),
                                      ),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 300,
                                      ),
                                      Text(
                                        "Editor",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 45),
                                      ),
                                      SizedBox(
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 60,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        15),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  SoruZorluk())),
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
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            children: [
                                                              SizedBox(width: MediaQuery.of(context).size.width/8,),
                                                              Image
                                                                  .asset(
                                                                "assets/images/camIcon.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    10,
                                                              ),
                                                              SizedBox(width: MediaQuery.of(context).size.width/12,),
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
                                                                  "Şimdi\nSoru Yükle",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,fontSize: MediaQuery.of(context).size.height/35,fontWeight: FontWeight.w600),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 30,),
                                            //2.-----------------------------------------------------------------------
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        15),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  DerslerKategori())),

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
                                                              0xFF41C6FF),),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            children: [
                                                              SizedBox(width: MediaQuery.of(context).size.width/8,),
                                                              Image
                                                                  .asset(
                                                                "assets/images/allQuests.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    10,
                                                              ),
                                                              SizedBox(width: MediaQuery.of(context).size.width/12,),
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
                                                                  "Yüklenen\nSoruları Gör",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,fontSize: MediaQuery.of(context).size.height/35,fontWeight: FontWeight.w600),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 30,),
                                            //3.----------------------------------------------------------------------
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        15),
                                                child: GestureDetector(
                                                  onTap: () =>
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (
                                                                  context) =>
                                                                  BottomNav(
                                                                    currentIndex: 1,))),

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
                                                              0xFFFF4800),),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisSize: MainAxisSize
                                                                .max,
                                                            children: [
                                                              SizedBox(width: MediaQuery.of(context).size.width/8,),
                                                              Image
                                                                  .asset(
                                                                "assets/images/settingsIcon.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    10,
                                                              ),
                                                              SizedBox(width: MediaQuery.of(context).size.width/12,),
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
                                                                  "Editör\nAyarları",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,fontSize: MediaQuery.of(context).size.height/35,fontWeight: FontWeight.w600),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 30,),

                                    ],
                                  ),
                                ),),
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white),
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 13.5 * 2,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 13.5 * 2,
                                ),
                                StreamBuilder(stream: FirebaseFirestore.instance
                                    .collection("Users")
                                    .doc(widget.user.uid)
                                    .snapshots(),
                                    builder: (context, AsyncSnapshot<
                                        DocumentSnapshot>snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.data().containsKey(
                                            "pp")) {
                                          return CircleAvatar(
                                            radius: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 15,
                                            backgroundImage: CachedNetworkImageProvider(
                                                snapshot.data["pp"]),
                                          );
                                        } else {
                                          return Container(
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 7.5,
                                            width: MediaQuery
                                                .of(context)
                                                .size
                                                .height / 7.5,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Color(0xFF6E719B)),
                                            child: FittedBox(child: Padding(
                                              padding: const EdgeInsets.all(
                                                  10.0),
                                              child: Text(widget.realName[0],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 100),),
                                            )),);
                                        }
                                      } else {
                                        return Container(height: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 7.5,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 7.5,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF6E719B)),
                                          child: FittedBox(child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(widget.realName[0],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 100),),
                                          )),);
                                      }
                                      /*ppURL!=null?CircleAvatar(
                                    radius: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 15,
                                    backgroundImage: CachedNetworkImageProvider(
                                        ppURL),
                                  ):Container(height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 7.5,width: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 7.5,decoration: BoxDecoration(shape:BoxShape.circle,color: Color(0xFF6E719B)),child: FittedBox(child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(realName[0],style: TextStyle(color:Colors.white,fontSize: 100),),
                                  )),)
*/
                                    }),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
