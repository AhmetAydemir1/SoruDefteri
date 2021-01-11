import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'package:soru_defteri/UI/Sign/SignIn.dart';

import 'UI/Splash/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (prefs.getBool("splash") == null) {
        splash = false;
      } else {
        splash = true;
      }
      if (user == null) {
        login = false;
      }else{
        login=true;
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
                  : HomePage()
          : Scaffold(
              body: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    "assets/images/splashBG.png",
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
