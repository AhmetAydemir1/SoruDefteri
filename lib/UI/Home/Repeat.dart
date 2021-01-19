import 'package:flutter/material.dart';

class Repeat extends StatefulWidget {
  @override
  _RepeatState createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {
  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6E719B),
        child: SafeArea(bottom:false,child: Scaffold(appBar: AppBar(title: Text("Tekrar Yap"),),)));
  }
}
