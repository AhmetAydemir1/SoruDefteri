import 'package:flutter/material.dart';

class Kredi extends StatefulWidget {
  @override
  _KrediState createState() => _KrediState();
}

class _KrediState extends State<Kredi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text("Krediler"),),
        ),
      ),
    );
  }
}
