import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/AddQuest/AddQuest.dart';
import 'package:soru_defteri/UI/Home/QuestionWall.dart';
import 'package:soru_defteri/UI/Home/Repeat.dart';
import 'package:soru_defteri/UI/Home/Settings.dart';

class BottomNav extends StatefulWidget {
  int currentIndex;

  BottomNav({Key key, this.currentIndex}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List childs = [AddQuestion(), QuestionWall(), Repeat(), Settings()];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.currentIndex == null) {
      setState(() {
        widget.currentIndex = 0;
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
          color: Color(0xFF201778),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            fixedColor:Color(0xFF281D87),
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                widget.currentIndex = index;
              });
            },
            currentIndex: widget.currentIndex,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                activeIcon: Padding(
                  padding: EdgeInsets.only(top:3.0),
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
                title:Container(height: 0,),
              ),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top:3.0),
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
                  title:Container(height: 0,)),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top:3.0),
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
                  title:Container(height: 0,)),
              BottomNavigationBarItem(
                  activeIcon: Padding(
                    padding: EdgeInsets.only(top:3.0),
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
                  title:Container(height: 0,)),
            ],
          ),
        ));
  }
}
