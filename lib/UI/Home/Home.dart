import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/AddQuest/AddQuest.dart';
import 'package:soru_defteri/UI/AddQuest/BottomNav.dart';
import 'package:soru_defteri/UI/AddQuest/FirstAdd.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstAdd = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("FirstAdd");
    if (prefs.getBool("FirstAdd") == null) {
      setState(() {
        firstAdd = false;
      });
      prefs.setBool("FirstAdd", false);
    } else {
      setState(() {
        firstAdd = prefs.getBool("FirstAdd");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onPressed: () {})
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
                                  Text(
                                    "Merhaba İSİM!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 28),
                                  ),
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 300,
                                  ),
                                  Text(
                                    "Tekrar hoşgeldin.",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 45),
                                  ),
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 40,
                                  ),
                                  SizedBox(
                                    height:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .height / 100,
                                  ),
                                  Container(
                                    width: double.maxFinite,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                          MediaQuery
                                              .of(context)
                                              .size
                                              .width /
                                              40),
                                      child: RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(
                                              style: TextStyle(
                                                  fontSize: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height /
                                                      35),
                                              children: [
                                                TextSpan(
                                                  text: "Toplam ",
                                                ),
                                                TextSpan(text: "92",
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
                                                    ),
                                                TextSpan(
                                                  text:
                                                  " soru sordun ve tekrarlanacak ",
                                                ),
                                                TextSpan(text:"27",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize:
                                                        MediaQuery
                                                            .of(context)
                                                            .size
                                                            .height /
                                                            35,
                                                        color: Color(
                                                            0xFFFF9600))),
                                                TextSpan(
                                                  text: " sorun daha var",
                                                )
                                              ])),
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 40,
                                  ),
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
                                              onTap: () =>
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                          firstAdd
                                                              ? BottomNav(
                                                            currentIndex: 0,)
                                                              : FirstAdd())),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .only(
                                                      topLeft: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 7),
                                                      topRight: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 13),
                                                      bottomLeft: Radius
                                                          .circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 13),
                                                      bottomRight:
                                                      Radius.circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 13)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF5068EE),),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                              "assets/images/camIcon.png",
                                                              height: MediaQuery.of(context).size.height/15,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height /
                                                                    200,bottom: 1),
                                                            child: Text(
                                                              "Soru Yükle",
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
                                          SizedBox(width: MediaQuery.of(context).size.width/30,),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BottomNav(
                                                                currentIndex: 1,))),

                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .only(
                                                      topLeft: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 13),
                                                      topRight: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 7),
                                                      bottomLeft: Radius
                                                          .circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 13),
                                                      bottomRight:
                                                      Radius.circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 13)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF41C6FF),),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                              height: MediaQuery.of(context).size.height/15,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height /
                                                                    200,bottom: 1),
                                                            child: Text(
                                                              "Tekrar Yap",
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
                                  SizedBox(height: MediaQuery.of(context).size.width/30,),
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
                                              onTap: () =>
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BottomNav(
                                                                currentIndex: 2,))),

                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .only(
                                                      topLeft: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 13),
                                                      topRight: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 13),
                                                      bottomLeft: Radius
                                                          .circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 7),
                                                      bottomRight:
                                                      Radius.circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 13)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFF00AE87),),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                              "assets/images/questionWallIcon.png",
                                                              height: MediaQuery.of(context).size.height/15,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height /
                                                                    200,bottom: 1),
                                                            child: Text(
                                                              "Soru Duvarı",
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
                                          SizedBox(width: MediaQuery.of(context).size.width/30,),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () =>
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              BottomNav(
                                                                currentIndex: 3,))),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius
                                                      .only(
                                                      topLeft: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 13),
                                                      topRight: Radius.circular(
                                                          MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 13),
                                                      bottomLeft: Radius
                                                          .circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 13),
                                                      bottomRight:
                                                      Radius.circular(MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 7)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: Color(0xFFFF4800),),
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                                              "assets/images/settingsIcon.png",
                                                              height: MediaQuery.of(context).size.height/16,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: EdgeInsets
                                                                .only(
                                                                top: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .height /
                                                                    200,bottom: 1),
                                                            child: Text(
                                                              "Ayarlar",
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
                                    height: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 40,
                                  ),
                                ],
                              ),
                            ),),
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 13.5 * 2,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 13.5 * 2,
                            ),
                            CircleAvatar(
                              radius: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 15,
                              backgroundImage: CachedNetworkImageProvider(
                                  "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1650&q=80"),
                            ),
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
    );
  }
}
