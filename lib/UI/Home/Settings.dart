import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Sign/SignIn.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6E719B),

      child: SafeArea(
        bottom: false,
        child: Scaffold(appBar: AppBar(title: Text("Ayarlar"),),body: FlatButton(child: Text("Çıkış"),onPressed: (){
          FirebaseAuth.instance.signOut();
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));
        },),),
      ),
    );
  }
}
