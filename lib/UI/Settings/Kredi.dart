import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soru_defteri/Models/ADS.dart';
import 'package:soru_defteri/UI/Settings/KodKullan.dart';

import 'PremiumAvantaj.dart';

class Kredi extends StatefulWidget {
  @override
  _KrediState createState() => _KrediState();
}

class _KrediState extends State<Kredi> {
  User user = FirebaseAuth.instance.currentUser;
  String realName;
  String kredi;
  bool premium;
  AdmobReward rewardedAd;
  bool rewardReady=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    rewardedAd=AdmobReward(adUnitId: AdMob().odulluReklam(),listener:(AdmobAdEvent event, Map<String, dynamic> args) async {
      if (event == AdmobAdEvent.closed) {
        setState(() {
          rewardReady=false;
        });
        rewardedAd.load();
      }
      if (event == AdmobAdEvent.completed) {
        print("complete");
      }
      if (event == AdmobAdEvent.failedToLoad) {
        setState(() {
          rewardReady = true;
        });
      }
      if (event == AdmobAdEvent.loaded) {
        print("laoded");
        setState(() {
          rewardReady = true;
        });
      }
      if (event == AdmobAdEvent.rewarded) {
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({"kredi":2},SetOptions(merge: true));
        setState(() {
          int tempkredi=int.parse(kredi);
          tempkredi=tempkredi+2;
          kredi=tempkredi.toString();
          print("kredi= $kredi");
        });
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
            {"kredi":int.parse(kredi)},SetOptions(merge:true));
        Fluttertoast.showToast(msg: "2 Krediniz hesabınıza tanımlanmıştır.");
      }
    });
    rewardedAd.load();

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(user.uid)
        .get()
        .then((doc) {
      setState(() {
        realName = doc["adsoyad"];
        if(doc.data().containsKey("premium")){
          if(doc["premium"]){
            premium=true;
            kredi="∞";
          }else{
            premium=false;
            kredi = doc.data().containsKey("kredi") ? doc["kredi"].toString() : "0";
          }
        }else{
          premium=false;
          kredi = doc.data().containsKey("kredi") ? doc["kredi"].toString() : "0";
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            title: Text("Krediler"),
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6453F6),
          ),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 10),
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
                  height: MediaQuery.of(context).size.height/50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:10.0),
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      Image.asset(
                        "assets/images/kredi.png",
                        fit: BoxFit.fitWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top:MediaQuery.of(context).size.width/3.1),
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
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
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
                              " satın alarak kesintisiz Soru Defteri deneyimi yaşayabilirsiniz."),
                    ], style: TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/50,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            premium!=null&&!premium ? Container(
                              height: 45.0,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => KodKullan()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF00AE87),
                                      borderRadius: BorderRadius.circular(45.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width / 3,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Kod Kullan",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ):Container(),
                            SizedBox(width: MediaQuery.of(context).size.width/60,),
                            premium!=null&&!premium ? Container(
                              height: 45.0,
                              child: FlatButton(
                                onPressed: rewardReady ? () {
                                  rewardedAd.show();
                                }:()=>null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      color: Color(0xFF00AE87),
                                      borderRadius: BorderRadius.circular(45.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth: MediaQuery.of(context).size.width / 3,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      rewardReady ? "Reklam İzle & Kazan":"Reklam Yükleniyor...",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ):Container(),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        premium!=null&&!premium ? Container(
                          height: 45.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PremiumOl()));
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
                        ):Container(),
                        SizedBox(height: MediaQuery.of(context).size.height/50,),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    rewardedAd.dispose();
  }
}
