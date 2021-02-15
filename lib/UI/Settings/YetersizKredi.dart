import 'package:admob_flutter/admob_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soru_defteri/Models/ADS.dart';
import 'package:soru_defteri/UI/AddQuest/QuestDiff.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'package:soru_defteri/UI/Settings/PremiumAvantaj.dart';

class YetersizKredi extends StatefulWidget {
  @override
  _YetersizKrediState createState() => _YetersizKrediState();
}

class _YetersizKrediState extends State<YetersizKredi> {

  AdmobReward rewardedAd;
  bool rewardReady=false;
  User user=FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync()async{
    rewardedAd = AdmobReward(
      adUnitId: AdMob().odulluReklam(),
      listener: (AdmobAdEvent event, Map<String, dynamic> args) async {
        if (event == AdmobAdEvent.closed) {

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
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruZorluk()));
          Fluttertoast.showToast(msg: "2 Krediniz hesabınıza tanımlanmıştır.");
        }
      },
    );
    rewardedAd.load();
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
          body: rewardReady ? SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Ops...\nSanırım Krediniz\nBitmiş",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/images/krediBitik.png",
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Sorularınızı yükleyebilmek için reklamlarımızı izleyebilir veya "),
                        TextSpan(
                            text: "Premium Üyelik",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                " satın alarak kesintisiz Soru Defteri deneyimi yaşayabilirsiniz."),
                      ], style: TextStyle(fontSize: 17, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 50.0,
                          child: FlatButton(
                            onPressed: () =>rewardedAd.show(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: Color(0xFF00AE87),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                    MediaQuery.of(context).size.width / 2,
                                    minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Reklam İzle",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          height: 50.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumOl()));
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  color: Color(0xFFC4B74D),
                                  borderRadius: BorderRadius.circular(50.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                    MediaQuery.of(context).size.width / 2,
                                    minHeight: 50.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Premium Üye Ol",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        )                      ],
                    ),
                  )
                ],
              ),
            ),
          ):Center(child: CircularProgressIndicator(),),
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
