import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Sign/SignIn.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  PageController pageController = PageController();
  int splashIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      if (pageController.page.round() != splashIndex) {
        setState(() {
          splashIndex = pageController.page.round();
        });
      }
    });
    startSync();
  }
  startSync()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool("splash", true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/splashBG.png",
            fit: BoxFit.fitHeight,
            alignment: splashIndex == 0
                ? Alignment.centerLeft
                : splashIndex == 1
                    ? Alignment.center
                    : Alignment.centerRight,
          ),
          PageView(
            controller: pageController,
            children: [
              GestureDetector(
                onTap: () => pageController.jumpToPage(1),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            bottom: 20),
                        child: Image.asset(
                          "assets/images/orangeHorizontal.png",
                          scale: MediaQuery.of(context).size.width / 160,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10),
                        child: Text(
                          "Bütün",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 126, 0, 1),
                              fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10),
                        child: Text(
                          "Soruları",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            bottom: MediaQuery.of(context).size.height / 10),
                        child: Text(
                          "Biriktir...",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => pageController.jumpToPage(2),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            bottom: 20),
                        child: Image.asset(
                          "assets/images/purpleHorizontal.png",
                          scale: MediaQuery.of(context).size.width / 160,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10),
                        child: Text(
                          "Tümünü",
                          style: TextStyle(
                              color: Color.fromRGBO(0, 174, 135, 1),
                              fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10),
                        child: Text(
                          "Defalarca",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            bottom: MediaQuery.of(context).size.height / 10),
                        child: Text(
                          "Çöz...",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn())),
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            bottom: 20),
                        child: Image.asset(
                          "assets/images/redHorizontal.png",
                          scale: MediaQuery.of(context).size.width / 160,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10),
                        child: Text(
                          "Artık",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 0, 127, 1),
                              fontSize: 25),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10),
                        child: Text(
                          "Sınavdan",
                          style: TextStyle(color: Colors.white, fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 10,
                            bottom: MediaQuery.of(context).size.height / 10),
                        child: Text(
                          "Korkmak yok!",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 40),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      dots(),
                      FlatButton(
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {
                            splashIndex!=2? pageController.jumpToPage(splashIndex+1):Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                splashIndex == 2 ? "Hazırım" : "Atla",
                                style: TextStyle(
                                    color: splashIndex == 2
                                        ? Colors.white
                                        : Colors.white70),
                              ),
                              splashIndex == 2
                                  ? Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  : Container(
                                      height: 0,
                                      width: 0,
                                    )
                            ],
                          )),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  dots() {
    if (splashIndex == 0) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white,
              height: 8,
              width: 35,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white70,
              height: 8,
              width: 13,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white70,
              height: 8,
              width: 13,
            ),
          )
        ],
      );
    } else if (splashIndex == 1) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white70,
              height: 8,
              width: 13,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white,
              height: 8,
              width: 35,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white70,
              height: 8,
              width: 13,
            ),
          )
        ],
      );
    } else if (splashIndex == 2) {
      return Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white70,
              height: 8,
              width: 13,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white70,
              height: 8,
              width: 13,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              color: Colors.white,
              height: 8,
              width: 35,
            ),
          )
        ],
      );
    }
  }
}
