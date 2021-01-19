import 'dart:io';

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign.dart';
import 'package:soru_defteri/UI/Sign/SignInInner.dart';
import 'package:soru_defteri/UI/Sign/SignInLogin.dart';
import 'package:soru_defteri/UI/Sign/SignInWithPhone.dart';

import 'Izinler.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset("assets/images/BG.png").image, context);
    precacheImage(Image.asset("assets/images/signIn.png").image, context);
    precacheImage(Image.asset("assets/images/facebookLogo.png").image, context);
    precacheImage(Image.asset("assets/images/googleLogo.png").image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6E719B),

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height/20,),
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Image.asset(
                          "assets/images/signIn.png",
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
                      Platform.isIOS
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width / 9,
                                  vertical: 5),
                              child: FlatButton(
                                height: 44,
                                minWidth: double.infinity,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                color: Color(0xFF272063),
                                onPressed: () => appleSignIn(),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 13.0),
                                      child: Container(
                                        width: 25 * (25 / 31),
                                        height: 25,
                                        child: CustomPaint(
                                          painter:
                                              AppleLogoPainter(color: Colors.white),
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
                              )
                          : Container(),
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
                          onPressed: () => facebookSignIn(),
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
                          onPressed: () {
                            googleSign();
                          },
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
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignInWithPhone())),
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
                          onPressed: () => Navigator.push(context,
                              MaterialPageRoute(builder: (context) => SignInInner())),
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
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInLogin())),
                            ),
                            FlatButton(
                              highlightColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              child: Text("Giriş Yap",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300)),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInLogin())),
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  googleSign() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      Map<String, dynamic> userData = Map();
      if (authResult.additionalUserInfo.isNewUser) {
        userData["email"] = user.email;
      }

      if (!kIsWeb) {
        String fcmToken = await FirebaseMessaging().getToken();
        userData["fcmToken"] = fcmToken;
      }

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .set(userData, SetOptions(merge: true));

      bool bilgiVar;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.data().containsKey("alan")) {
          bilgiVar = true;
        } else {
          bilgiVar = false;
        }
      });

      if (authResult.additionalUserInfo.isNewUser || !bilgiVar) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignInExtraInfo()));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("firstSign") == null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Izinler()));
        } else {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      }

      return '$user';
    }
  }

  appleSignIn() async {
    final result = await AppleSignIn.performRequests([
      AppleIdRequest(
        requestedScopes: [Scope.email, Scope.fullName],
      )
    ]);
    final oAuthProvider = OAuthProvider('apple.com');
    print(result.error.toString());
    final appleIdCredential = result.credential;
    final credential = oAuthProvider.credential(
      idToken: String.fromCharCodes(appleIdCredential.identityToken),
      accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
    );
    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      Map<String, dynamic> userData = Map();
      if (authResult.additionalUserInfo.isNewUser) {
        userData["email"] = user.email;
      }

      if (!kIsWeb) {
        String fcmToken = await FirebaseMessaging().getToken();
        userData["fcmToken"] = fcmToken;
      }

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .set(userData, SetOptions(merge: true));
      bool bilgiVar;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.data().containsKey("alan")) {
          bilgiVar = true;
        } else {
          bilgiVar = false;
        }
      });

      if (authResult.additionalUserInfo.isNewUser || !bilgiVar) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignInExtraInfo()));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("firstSign") == null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Izinler()));
        } else {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      }

      return '$user';
    }
  }

  facebookSignIn() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult = await facebookLogin.logIn(['email']);

    final AuthCredential credential =
        FacebookAuthProvider.credential(facebookLoginResult.accessToken.token);

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);

      print('signInWithGoogle succeeded: $user');

      Map<String, dynamic> userData = Map();
      if (authResult.additionalUserInfo.isNewUser) {
        userData["email"] = user.email;
      }

      if (!kIsWeb) {
        String fcmToken = await FirebaseMessaging().getToken();
        userData["fcmToken"] = fcmToken;
      }

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .set(userData, SetOptions(merge: true));

      bool bilgiVar;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get()
          .then((doc) {
        if (doc.data().containsKey("alan")) {
          bilgiVar = true;
        } else {
          bilgiVar = false;
        }
      });

      if (authResult.additionalUserInfo.isNewUser || !bilgiVar) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SignInExtraInfo()));
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("firstSign") == null) {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Izinler()));
        } else {
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      }

      return '$user';
    }
  }
}
