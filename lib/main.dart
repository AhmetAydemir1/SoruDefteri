import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/testing.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'package:soru_defteri/UI/Sign/Izinler.dart';
import 'package:soru_defteri/UI/Sign/SignIn.dart';

import 'UI/Sign/ExtraInfoSign.dart';
import 'UI/Splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Admob.initialize();
  print("main giriş");
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
  bool testing=false;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
    bildirimHandle();
  }

  bildirimHandle()async{
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        if (Platform.isAndroid) {
          message = new Map<String, dynamic>.from(message["data"]);
        }
        print(message);

        hepsiOrtak(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        if (Platform.isAndroid) {
          message = new Map<String, dynamic>.from(message["data"]);
        }
        print(message);

        hepsiOrtak(message);
      },
      onResume: (Map<String, dynamic> message) async {
        if (Platform.isAndroid) {
          message = new Map<String, dynamic>.from(message["data"]);
        }
        print(message);

        hepsiOrtak(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true));
    _firebaseMessaging.subscribeToTopic("all");
  }

  hepsiOrtak(Map<String, dynamic> message) async {
    if (message["userid"] != user.uid) {
      print(message["date"]);
      Map<String, dynamic> bildirimF = Map();
      bildirimF["title"] = message["title"];
      bildirimF["body"] = message["body"];
      bildirimF["docID"] = message["docID"];
      bildirimF["type"] = message["type"];
      bildirimF["date"] = message["date"];
      print(message["userid"]);
      bildirimF["userid"] = message["userid"];
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Bildirimler")
          .doc()
          .set(bildirimF);
    }
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('tr');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soru Defteri',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Color(0xff00AE87),
        primaryColor: Color(0xff6453F6),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: testing? Testing(): splash != null && login != null
          ? !splash
          ? SplashScreen()
          : !login
          ? SignIn()
          : bilgiVar ? firstSign?Izinler(): HomePage():SignInExtraInfo()
          : Scaffold(
        backgroundColor: Color(0xFF6453F6),
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


