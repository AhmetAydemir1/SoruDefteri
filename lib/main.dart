import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'package:soru_defteri/UI/Sign/Izinler.dart';
import 'package:soru_defteri/UI/Sign/SignIn.dart';
import 'package:soru_defteri/flutter_local_notifications.dart';

import 'UI/Sign/ExtraInfoSign.dart';
import 'UI/Splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //SharedPreferences.setMockInitialValues({});
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User user = FirebaseAuth.instance.currentUser;
  bool splash;
  bool login;
  bool bilgiVar;
  bool firstSign;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset("assets/images/splashBG1.png").image, context);
    super.didChangeDependencies();
  }

  startSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.clear();
    print(prefs.getBool("splash"));
    if(user!=null){
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
        if(!doc.data().containsKey("alan")||!doc.data().containsKey("sinif")||!doc.data().containsKey("email")||!doc.data().containsKey("userName")||!doc.data().containsKey("adsoyad")){
          bilgiVar=false;
        }else{
          bilgiVar=true;
        }
      });
      login=true;
      if(prefs.getBool("firstSign")==null){
        firstSign=true;
      }else{
        firstSign=false;
      }
    }else{
      login = false;

    }

    setState(() {
      if (prefs.getBool("splash") == null) {
        splash = false;
      } else {
        splash = true;
      }
      if(user==null){
        login = false;
      }else{
        login=true;
        if(prefs.getBool("firstSign")==null){
          firstSign=true;
        }else{
          firstSign=false;
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Soru Defteri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: splash != null && login != null
          ? !splash
          ? SplashScreen()
          : !login
          ? SignIn()
          : bilgiVar ? firstSign?Izinler(): HomePage():SignInExtraInfo()
          : Scaffold(
        backgroundColor: Color(0xFF6E719B),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              "assets/images/splashBG1.png",
              fit: BoxFit.fitHeight,
            ),
            Center(
              child: CircularProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}

