import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/AddQuest/AddQuest.dart';
import 'package:soru_defteri/UI/AddQuest/FirstAdd.dart';
import 'package:soru_defteri/UI/Home/QuestionWall.dart';
import 'package:soru_defteri/UI/Home/Repeat.dart';
import 'package:soru_defteri/UI/Home/Settings.dart' as settings;
import 'package:soru_defteri/UI/Settings/YetersizKredi.dart';

import 'QuestDiff.dart';

class BottomNav extends StatefulWidget {
  int currentIndex;
  String yayinEvi;
  int zorluk;

  BottomNav({Key key, @required this.currentIndex, this.yayinEvi, this.zorluk})
      : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List childs;
  bool firstAdd = true;
  User user=FirebaseAuth.instance.currentUser;
  int kredi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.currentIndex == null) {
      setState(() {
        widget.currentIndex = 0;
      });
    }
    setState(() {
      childs = [
        Container(),
        QuestionWall(),
        Repeat(),
        AddQuestion(
          yayinEvi: widget.yayinEvi,
          zorluk: widget.zorluk,
        )
      ];
    });
    gunlukKredi();
  }

  gunlukKredi() async {
    await FirebaseFirestore.instance.collection("Users").doc(user.uid)
        .get()
        .then((doc) async {
          setState(() {
            kredi=doc["kredi"];
          });
    });
    print(kredi);
    print("krediiii");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: kredi!=null ? childs[widget.currentIndex]:Center(child: CircularProgressIndicator(),),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  bottomNavigationBar() {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFF4C5490),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            fixedColor: Color(0xFF4C5490),
            backgroundColor: Color(0xFF4C5490),
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if(index!=0) {
                if (index == 3) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                          kredi!=0 ? SoruZorluk() : YetersizKredi()));
                }
                setState(() {
                  widget.currentIndex = index;
                });
              }else if(index==0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>settings.Settings()));
              }
            },
            currentIndex: widget.currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/settingsBottom.png",
                          scale: 3,
                        ),
                        Text(
                          "Ayarlar",
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFFF9A00)),
                          height: 8,
                          width: 8,
                        )
                      ],
                    ),
                  ),
                  icon: Image.asset(
                    "assets/images/settingsBottom.png",
                    scale: 3,
                  ),
                  title: Container(
                    height: 0,
                  )),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/questionWallBottom.png",
                          scale: 3,
                        ),
                        Text(
                          "Soru Duvarı",
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFFF9A00)),
                          height: 8,
                          width: 8,
                        )
                      ],
                    ),
                  ),
                  icon: Image.asset(
                    "assets/images/questionWallBottom.png",
                    scale: 3,
                  ),
                  title: Container(
                    height: 0,
                  )),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/images/repeatBottom.png",
                          scale: 3,
                        ),
                        Text(
                          "Tekrar Yap",
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xFFFF9A00)),
                          height: 8,
                          width: 8,
                        )
                      ],
                    ),
                  ),
                  icon: Image.asset(
                    "assets/images/repeatBottom.png",
                    scale: 3,
                  ),
                  title: Container(
                    height: 0,
                  )),
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(top: 3.0),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/camBottom.png",
                        scale: 3,
                      ),
                      Text(
                        "Soru Yükle",
                        style: TextStyle(color: Colors.white),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xFFFF9A00)),
                        height: 8,
                        width: 8,
                      )
                    ],
                  ),
                ),
                icon: Image.asset(
                  "assets/images/camBottom.png",
                  scale: 3,
                ),
                title: Container(
                  height: 0,
                ),
              ),
            ],
          ),
        ));
  }
}
