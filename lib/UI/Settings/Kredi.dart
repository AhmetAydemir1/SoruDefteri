import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Settings/YetersizKredi.dart';

class Kredi extends StatefulWidget {
  @override
  _KrediState createState() => _KrediState();
}

class _KrediState extends State<Kredi> {
  User user = FirebaseAuth.instance.currentUser;
  String realName;
  int kredi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get()
        .then((doc) {
      setState(() {
        realName = doc["adsoyad"];
        kredi = doc.data().containsKey("kredi") ? doc["kredi"] : 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            title: Text("Krediler"),
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6E719B),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Kredinizi Yükseltin",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "$realName, Soru Defteri’nde Kullanabileceğin ${kredi.toString()} kredin kaldı.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    fit: StackFit.loose,
                    children: [
                      Image.asset(
                        "assets/images/kredi.png",
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:MediaQuery.of(context).size.width/2.93),
                        child: Align(
                            alignment: Alignment(0.57, 0),
                            child: Container(
                              height: MediaQuery.of(context).size.width/3.5,
                              width: MediaQuery.of(context).size.width/3.5,
                              child: Center(
                                child: FittedBox(
                                  child: Center(
                                    child: Text(
                                      kredi.toString(),
                                      style: TextStyle(color: Colors.white, fontSize: 1000),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Unutmayın!",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Premium Üyelik",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                " satın alarakkesintisiz Soru Defteri deneyimi yaşayabilirsiniz."),
                      ], style: TextStyle(fontSize: 25, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 45.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => YetersizKredi()));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            color: Color(0xFFC4B74D),
                            borderRadius: BorderRadius.circular(45.0)),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2,
                              minHeight: 45.0),
                          alignment: Alignment.center,
                          child: Text(
                            "Premium Üye Ol",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
