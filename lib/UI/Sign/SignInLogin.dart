import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'ForgotPass.dart';
import 'Izinler.dart';

class SignInLogin extends StatefulWidget {
  @override
  _SignInLoginState createState() => _SignInLoginState();
}

class _SignInLoginState extends State<SignInLogin> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController emailEdit = TextEditingController();
  TextEditingController passwordEdit = TextEditingController();

  bool load = true;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(Image.asset("assets/images/BG.png").image, context);
    precacheImage(Image.asset("assets/images/signIn.png").image, context);
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
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/BG.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topRight,
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height + 20,
                      ),
                      Text(
                        "Giriş Yap",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Image.asset(
                        "assets/images/signIn.png",
                        scale: 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Text(
                        "HOŞ GELDİNİZ!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
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
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPass())),child: Container(child: Text("Şifremi Unuttum",style: TextStyle(color: Colors.white,decoration: TextDecoration.underline),))),
                            Container(
                              height: 45.0,
                              child: FlatButton(
                                onPressed: () => signInWithMail(),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Color(0xFF00AE87), Color(0xFF00AE87)],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                      ),
                                      borderRadius: BorderRadius.circular(45.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width / 2.3,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "GİRİŞ YAP",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Text(
                        "Artık",
                        style: TextStyle(
                            color: Color(0xFF41C6FF), fontSize: 20),
                      ),
                      Text(
                        "Sınavdan",
                        style: TextStyle(color: Colors.white, fontSize: 35),
                      ),
                      Text(
                        "Korkmak yok!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
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

  signInWithMail() async {
    String errorString;
    if (emailEdit.text.isNotEmpty && passwordEdit.text.isNotEmpty) {
      try {
        setState(() {
          load = false;
        });
        FirebaseAuth _auth = FirebaseAuth.instance;
        final User user = (await _auth.signInWithEmailAndPassword(
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

          Map<String, dynamic> userData = Map();

          if (!kIsWeb) {
            String fcmToken = await FirebaseMessaging().getToken();
            print("4");
            userData["fcmToken"] = fcmToken;
            FirebaseMessaging().subscribeToTopic("all");
          }

          await FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .set(userData, SetOptions(merge: true));

          setState(() {
            load = true;
          });
          bool firstSign;
          SharedPreferences prefs=await SharedPreferences.getInstance();
          if(prefs.getBool("firstSign")==null){
            firstSign=true;
          }else{
            firstSign=false;
          }
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => firstSign?Izinler(): HomePage()));

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
        }
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
