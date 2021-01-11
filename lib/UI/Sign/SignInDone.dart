import 'package:flutter/material.dart';

class SignInDone extends StatefulWidget {
  @override
  _SignInDoneState createState() => _SignInDoneState();
}

class _SignInDoneState extends State<SignInDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height + 20,
                ),
                Text(
                  "Tebrikler!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Image.asset("assets/images/logoPurple.png"),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
