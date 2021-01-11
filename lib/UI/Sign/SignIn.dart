import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInLogin.dart';
import 'package:soru_defteri/UI/Sign/SignInWithPhone.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/BG.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.topRight,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Image.asset(
                    "assets/images/logoWhiteLabel.png",
                    scale: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 35.0, bottom: 15),
                  child: Text(
                    "HOŞ GELDİNİZ!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 35.0),
                  child: Text(
                    "Sorularını biriktir, sınavlardan korkma!",
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        color: Colors.white,
                        fontSize: 20),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width / 9,
                        vertical: 5),
                    child: FlatButton(
                      height: 44,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45)),
                      color: Color(0xFF272063),
                      onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInExtraInfo())),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 13.0),
                            child: Container(
                              width: 25 * (25 / 31),
                              height: 25,
                              child: CustomPaint(
                                painter: AppleLogoPainter(color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Apple ile Oturum Aç",
                            style: TextStyle(
                                fontSize: 44 * 0.43,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    )
                    /*SignInWithAppleButton(
                    style: SignInWithAppleButtonStyle.black,
                    text: "Apple ile Oturum Aç",
                    onPressed: () {

                    },
                  ),*/
                    ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9,
                      vertical: 5),
                  child: FlatButton(
                    color: Color(0xFF3966B8),
                    height: 44,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Image.asset(
                            "assets/images/facebookLogo.png",
                            scale: 11,
                          ),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          "Facebook ile Oturum Aç",
                          style: TextStyle(
                              fontSize: 44 * 0.43,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInExtraInfo())),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9,
                      vertical: 5),
                  child: FlatButton(
                    color: Colors.white,
                    height: 44,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Image.asset(
                            "assets/images/googleLogo.png",
                            scale: 11,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Google ile Oturum Aç",
                          style: TextStyle(
                              fontSize: 44 * 0.43,
                              color: Colors.black,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInExtraInfo())),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9,
                      vertical: 5),
                  child: FlatButton(
                    height: 44,
                    color: Color(0xFFFF007F),
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(45)),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.smartphone,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Telefon ile Oturum Aç",
                          style: TextStyle(
                              fontSize: 44 * 0.43,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInWithPhone())),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9,
                      vertical: 5),
                  child: FlatButton(
                    color: Colors.transparent,
                    height: 44,
                    minWidth: double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45),
                      side: BorderSide(
                          color: Colors.white,
                          width: 1,
                          style: BorderStyle.solid),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Icon(
                            Icons.mail_outline,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "E-Posta ile Oturum Aç",
                          style: TextStyle(
                              fontSize: 44 * 0.43,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInInner())),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 9),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlatButton(
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Text(
                          "Zaten hesabım var.",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w300),
                        ),
                        onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInLogin())),
                      ),
                      FlatButton(
                        highlightColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        child: Text("Giriş Yap",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300)),
                        onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInLogin())),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/justLabel.png",
                  scale: 3,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
