import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Home/Home.dart';

class SignInDone extends StatefulWidget {
  @override
  _SignInDoneState createState() => _SignInDoneState();
}

class _SignInDoneState extends State<SignInDone> {
  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6453F6),

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/BG.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topLeft,
              ),
              Container(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height + 20,
                      ),
                      Text(
                        "Tebrikler!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                      ),
                      Image.asset(
                        "assets/images/signIn.png",
                        scale: 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Text(
                        "İşlem Tamam!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal:MediaQuery.of(context).size.height / 15),
                        child: Text(
                          "Hoşgeldin,\nSoru defterim ile beraber senin sınavlara hazırlık sürecini, beraber en iyi şekilde kurgulayacağız. Yapamadıklarını kaydettiğinde biz senin için hatırlatacağız. Soruları neden yanlış yaptığını inceleyip, sana destek vereceğiz. Aynı zamanda en iyi soruları senin için seçip göstereceğiz.",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 17),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 18,
                      ),
                      Container(
                        height: 100.0,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          onPressed: () {
                            FirebaseMessaging().subscribeToTopic("all");
                            Navigator.popUntil(context, (route) => route.isFirst);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) => HomePage()));
                          },
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: 100, minHeight: 100),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF00AE87),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
