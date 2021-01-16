import 'package:flutter/material.dart';

class QuestionWall extends StatefulWidget {
  @override
  _QuestionWallState createState() => _QuestionWallState();
}

class _QuestionWallState extends State<QuestionWall> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Soru Duvarı"),),);
  }
}
