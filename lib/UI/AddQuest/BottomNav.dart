import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/AddQuest/AddQuest.dart';
import 'package:soru_defteri/UI/AddQuest/FirstAdd.dart';
import 'package:soru_defteri/UI/Home/QuestionWall.dart';
import 'package:soru_defteri/UI/Home/Repeat.dart';
import 'package:soru_defteri/UI/Home/Settings.dart';

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
        Settings(),
        QuestionWall(),
        Repeat(),
        AddQuestion(
          yayinEvi: widget.yayinEvi,
          zorluk: widget.zorluk,
        )
      ];
    });
  }

  startSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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
      extendBody: true,
      body: childs[widget.currentIndex],
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
              if (index == 3) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            firstAdd ? SoruZorluk() : FirstAdd()));
              }
              setState(() {
                widget.currentIndex = index;
              });
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
