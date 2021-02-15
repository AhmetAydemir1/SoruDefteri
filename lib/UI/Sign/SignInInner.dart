import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Home/Home.dart';

import 'GizlilikP.dart';
import 'KullanimK.dart';

class SignInInner extends StatefulWidget {
  @override
  _SignInInnerState createState() => _SignInInnerState();
}

class _SignInInnerState extends State<SignInInner> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<String> chooseClassList = [
    "9. Sınıf",
    "10. Sınıf",
    "11. Sınıf",
    "12. Sınıf",
    "Mezun"
  ];
  String choosedClass;
  List<String> chooseAlanList = [
    "Sayısal (MF)",
    "Eşit Ağırlık (TM)",
    "Sözel (TS)",
    "Dil"
  ];
  String choosedAlan;
  bool load = true;

  TextEditingController adSoyadEdit = TextEditingController();
  TextEditingController emailEdit = TextEditingController();
  TextEditingController userNameEdit = TextEditingController();
  TextEditingController passwordEdit = TextEditingController();
  TextEditingController passwordVerifyEdit = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    precacheImage(Image.asset("assets/images/BG.png").image, context);
    precacheImage(Image.asset("assets/images/signIn.png").image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6453F6),

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          key: _scaffoldKey,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Image.asset(
              "assets/images/justLabel.png",
              scale: 5,
            ),
            centerTitle: true,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/BG.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topRight,
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
                        "Hesap Oluştur",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
//AD SOYAD-----------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "İsim & Soyisim",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextField(
                                controller: adSoyadEdit,
                                decoration: InputDecoration(
                                  counterText: "",
                                ),
                                maxLength: 20,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
//KULLANICI ADI-------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "Kullanıcı Adı",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextField(
                                controller: userNameEdit,
                                decoration: InputDecoration(
                                  counterText: "",
                                ),
                                maxLength: 20,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      //EPOSTA-------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "E-Posta",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextField(
                                controller: emailEdit,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            )),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),

                      //ŞİFRE-------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "Şifre",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextField(
                                obscureText: true,
                                controller: passwordEdit,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      //ŞİFRE ONAY-------------------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "Şifre (Tekrar)",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextField(
                                obscureText: true,
                                controller: passwordVerifyEdit,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      //SINIF SEÇİMİ---
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "Sınıf Seçimi",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Color(0xFF6453F6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: DropdownButton<String>(
                                dropdownColor: Color(0xFF6453F6),
                                focusColor: Color(0xFF6453F6),
                                iconEnabledColor: Colors.white,
                                hint: Text(
                                  "Sınıf Seçin",
                                  style: TextStyle(color: Colors.white),
                                ),
                                isExpanded: true,
                                value: choosedClass,
                                items: chooseClassList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (s) {
                                  setState(() {
                                    choosedClass = s;
                                    print(choosedClass);
                                  });
                                },
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 60,
                      ),
                      //ALAN SEÇİMİ-------
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "Alan Seçimi",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Color(0xFF6453F6),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: DropdownButton<String>(
                                dropdownColor: Color(0xFF6453F6),
                                focusColor: Color(0xFF6453F6),
                                iconEnabledColor: Colors.white,
                                hint: Text(
                                  "Alan Seçin",
                                  style: TextStyle(color: Colors.white),
                                ),
                                isExpanded: true,
                                value: choosedAlan,
                                items: chooseAlanList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (s) {
                                  setState(() {
                                    choosedAlan = s;
                                    print(choosedAlan);
                                  });
                                },
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                height: 45,
                                color: Colors.white,
                                minWidth: MediaQuery.of(context).size.width / 2.3,
                                onPressed: () {
                                  setState(() {
                                    choosedAlan = null;
                                    choosedClass = null;
                                    emailEdit.clear();
                                    adSoyadEdit.clear();
                                    userNameEdit.clear();
                                    passwordEdit.clear();
                                    passwordVerifyEdit.clear();
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "TEMİZLE",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ),
                                )),
                            Container(
                              height: 45.0,
                              child: FlatButton(
                                onPressed: () => kaydol(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF00AE87),
                                          Color(0xFF00AE87)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(45.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width / 2.3,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "KAYDOL",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 40,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: 'Devam ederek ',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "Kullanım Koşulları",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => KullanimK())),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 12)),
                              TextSpan(
                                  text: " 'nı ve ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  )),
                              TextSpan(
                                  text: "Gizlilik Politikası",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GizlilikP())),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 12)),
                              TextSpan(
                                  text: " 'nı kabul etmiş olursunuz. ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                    ],
                  ),
                ),
              ),
              load
                  ? Container()
                  : Container(
                      color: Colors.black12,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }

  kaydol() async {
    String errorString;
    if (adSoyadEdit.text.isNotEmpty &&
        emailEdit.text.isNotEmpty &&
        userNameEdit.text.isNotEmpty &&
        choosedClass != null &&
        choosedAlan != null &&
        passwordEdit.text.isNotEmpty &&
        passwordVerifyEdit.text.isNotEmpty) {
      if (passwordVerifyEdit.text == passwordEdit.text) {
        try {
          setState(() {
            load = false;
          });

          FirebaseAuth _auth = FirebaseAuth.instance;
          final User user = (await _auth.createUserWithEmailAndPassword(
            email: emailEdit.text.trim().replaceAll(" ", ""),
            password: passwordEdit.text,
          ))
              .user;
          if (user != null) {
            assert(!user.isAnonymous);
            assert(await user.getIdToken() != null);

            final User currentUser = _auth.currentUser;
            assert(user.uid == currentUser.uid);

            print('signInWithGoogle succeeded: $user');

            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString("userName", userNameEdit.text);
            prefs.setString("ppURL", user.photoURL);
            prefs.setString("alan", choosedAlan);
            prefs.setString("sinif", choosedClass);

            Map<String, dynamic> userData = Map();
            userData["userName"] = userNameEdit.text;
            userData["email"] = user.email;
            userData["alan"] = choosedAlan;
            userData["sinif"] = choosedClass;
            userData["adsoyad"] = adSoyadEdit.text;

            passwordEdit.text.isNotEmpty
                ? userData["pass"] = passwordEdit.text
                : userData["pass"] = "google";
            user.updateProfile(displayName: userNameEdit.text);
            user.reload();

            if (!kIsWeb) {
              String fcmToken = await FirebaseMessaging().getToken();
              userData["fcmToken"] = fcmToken;
            }

            await FirebaseFirestore.instance
                .collection("Users")
                .doc(user.uid)
                .set(userData, SetOptions(merge: true));

            setState(() {
              load = true;
            });

            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));

            return '$user';
          }
        } on FirebaseException catch (a) {
          String e = a.message;
          print(e.toString());
          if (e.toString() == "The email address is badly formatted.") {
            errorString =
                "Lütfen emailinizi kontrol ediniz. (Boşluk bırakmamaya dikkat ediniz)";
          } else if (e.toString() ==
              "There is no user record corresponding to this identifier. The user may have been deleted.") {
            errorString = "Böyle bir kullanıcı bulunamadı.";
          } else if (e.toString() ==
              "The password is invalid or the user does not have a password.") {
            errorString = "Parola hatalı.";
          } else if (e.toString() ==
              "The password is invalid or the user does not have a password.") {
            errorString = "Parola hatalı.";
          } else if (e.toString() ==
              "Password should be at least 6 characters") {
            errorString = "Şifre en az 6 karakter olmalı.";
          } else if (e.toString() ==
              "The email address is already in use by another account.") {
            errorString = "Bu email adresi zaten kayıtlı.";
          }
        }
      } else {
        errorString = "Şifreler uyuşmuyor.";
      }
    } else {
      errorString = "Boşlukları doldurunuz.";
    }
    setState(() {
      load = true;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        errorString,
        textAlign: TextAlign.center,
      ),
    ));
    print(errorString);
  }
}
