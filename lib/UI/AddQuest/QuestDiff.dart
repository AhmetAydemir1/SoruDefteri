import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/AddQuest/YayinEvi.dart';

class SoruZorluk extends StatefulWidget {
  @override
  _SoruZorlukState createState() => _SoruZorlukState();
}

class _SoruZorlukState extends State<SoruZorluk> {
  bool zor1 = false;
  bool zor2 = false;
  bool zor3 = false;
  bool zor4 = true;
  int zorluk=4;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/splashBG1.png",
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
              Opacity(
                  opacity: 0.6,
                  child: Container(
                    color: Color(0xFF6E719B),
                  )),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height,
                    ),
                    Image.asset(
                      "assets/images/signIn.png",
                      scale: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Veeee soru yükleme zamanı geldi. Sence yükleyeceğin sorune kadar zor görünüyor?",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Aşağıdaki emojilerden sana uygun olanı seç!",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          zor1 = false;
                          zor2 = false;
                          zor3 = false;
                          zor4 = true;
                          zorluk=4;
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                    opacity: zor4 ? 0.2 : 0,
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: MediaQuery.of(context).size.height /
                                          10,
                                      color: Colors.yellow,
                                    )),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                  size: MediaQuery.of(context).size.height / 15,
                                ),
                                Text(
                                  "4",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6E719B),
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              40),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Container(
                                decoration: zor4
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6E719B),
                                              Color(0xFF636798)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter))
                                    : BoxDecoration(color: Colors.transparent),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "Bu soru oldukça zor!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          zor1 = false;
                          zor2 = false;
                          zor3 = true;
                          zor4 = false;
                          zorluk=3;
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                    opacity: zor3 ? 0.2 : 0,
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: MediaQuery.of(context).size.height /
                                          10,
                                      color: Colors.yellow,
                                    )),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                  size: MediaQuery.of(context).size.height / 15,
                                ),
                                Text(
                                  "3",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6E719B),
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              40),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Container(
                                decoration: zor3
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6E719B),
                                              Color(0xFF636798)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter))
                                    : BoxDecoration(color: Colors.transparent),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "Bu soru sinirlerimi bozacak\nkadar zor!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          zor1 = false;
                          zor2 = true;
                          zor3 = false;
                          zor4 = false;
                          zorluk=2;
                        });
                      },
                      child: Container(
                        width: double.maxFinite,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                    opacity: zor2 ? 0.2 : 0,
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: MediaQuery.of(context).size.height /
                                          10,
                                      color: Colors.yellow,
                                    )),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                  size: MediaQuery.of(context).size.height / 15,
                                ),
                                Text(
                                  "2",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6E719B),
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              40),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Container(
                                decoration: zor2
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6E719B),
                                              Color(0xFF636798)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter))
                                    : BoxDecoration(color: Colors.transparent),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "Bu soru kolay ve\neğlenceli!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          zor1 = true;
                          zor2 = false;
                          zor3 = false;
                          zor4 = false;
                          zorluk=1;
                        });
                      },
                      child: Container(
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Opacity(
                                    opacity: zor1 ? 0.2 : 0,
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: MediaQuery.of(context).size.height /
                                          10,
                                      color: Colors.yellow,
                                    )),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.yellow,
                                  size: MediaQuery.of(context).size.height / 15,
                                ),
                                Text(
                                  "1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6E719B),
                                      fontSize:
                                          MediaQuery.of(context).size.height /
                                              40),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 20.0),
                              child: Container(
                                decoration: zor1
                                    ? BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF6E719B),
                                              Color(0xFF636798)
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter))
                                    : BoxDecoration(color: Colors.transparent),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: Text(
                                    "Bu soru çokkk kolay!",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      height: 45.0,
                      child: FlatButton(
                        onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>YayinEvi(zorluk: zorluk,))),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
                        padding: EdgeInsets.all(0.0),
                        child: Ink(
                          decoration: BoxDecoration(
                              color: Color(0xFF00AE87),
                              borderRadius: BorderRadius.circular(45.0)
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.3, minHeight: 45.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Sonraki",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,fontSize: 18
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
