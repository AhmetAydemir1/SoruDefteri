import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/AddQuest/BottomNav.dart';
import 'package:soru_defteri/UI/AddQuest/FirstAdd.dart';
import 'package:soru_defteri/UI/AddQuest/QuestDiff.dart';
import 'package:soru_defteri/UI/Home/Bildirimler.dart';
import 'package:soru_defteri/UI/Home/EditorHome.dart';
import 'package:soru_defteri/UI/Home/Settings.dart' as MySettings;
import 'package:soru_defteri/UI/Settings/YetersizKredi.dart';
import 'package:soru_defteri/flutter_local_notifications.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool firstAdd = false;
  User user = FirebaseAuth.instance.currentUser;
  String realName;
  String ppURL;
  bool allLoaded = false;
  int kredi;
  int tekrarlanacakSoru;
  int toplamSoru;
  bool admin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    print(user.providerData);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("FirstAdd") == null) {
      setState(() {
        firstAdd = false;
      });
      prefs.setBool("FirstAdd", false);
    } else {
      setState(() {
        firstAdd = prefs.getBool("FirstAdd");
      });
    }

    bool premium;
    bool premiumByCode;
    String myDavetKod;
    await FirebaseFirestore.instance.collection("Users").doc(user.uid)
        .get()
        .then((doc) {
      setState(() {
        realName = doc.data().containsKey("adsoyad") ? doc["adsoyad"] : "";
        ppURL = doc.data().containsKey("pp") ? doc["pp"] : null;
        premiumByCode=doc.data().containsKey("premiumByCode") ? doc["premiumByCode"] : null;
        premium=doc.data().containsKey("premium") ? doc["premium"] : null;
        myDavetKod=doc.data().containsKey("davetKodu") ? doc["davetKodu"] : null;
      });
    });
    await FirebaseFirestore.instance.collection("Editor").doc("Editor")
        .get()
        .then((doc) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      if (doc["editor"].contains(user.uid)) {
        prefs.setBool("admin", true);
        setState(() {
          admin = true;
          allLoaded = true;
        });
      } else {
        prefs.setBool("admin", false);
        admin = false;
        bool tempPremium = await subscriptionStatus("premium_subs",Duration(days: 31));
        if(!tempPremium){
          print("premium değil");
          if(!(premiumByCode==true)){
            await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
                {"premium":false},SetOptions(merge:true));
            gunlukKredi();
          }else{
            setState(() {
              allLoaded = true;
            });
          }
        }else{
          print("premium");
          setState(() {
            allLoaded = true;
          });
        }
      }
    });
    if(myDavetKod==null){
      String davetKodum=realName.trim()+"-"+user.uid.substring(0,5);
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
          {"davetKodu":davetKodum},SetOptions(merge: true));
    }
  }

  static Future<bool> subscriptionStatus(
      String sku,
      [Duration duration = const Duration(days: 30),
        Duration grace = const Duration(days: 0)]) async {
    var result = await FlutterInappPurchase.instance.initConnection;

    if (Platform.isIOS) {
      var history = await FlutterInappPurchase.instance.getPurchaseHistory();

      for (var purchase in history) {
        Duration difference =
        DateTime.now().difference(purchase.transactionDate);
        if (difference.inMinutes <= (duration + grace).inMinutes &&
            purchase.productId == sku) return true;
      }
      return false;
    } else if (Platform.isAndroid) {
      var purchases = await FlutterInappPurchase.instance.getAvailablePurchases();

      for (var purchase in purchases) {
        if (purchase.productId == sku) return true;
      }
      return false;
    }
    throw PlatformException(
        code: Platform.operatingSystem, message: "platform not supported");
  }


  gunlukKredi() async {
    await FirebaseFirestore.instance.collection("Users").doc(user.uid)
        .get()
        .then((doc) async {
      if (!doc.data().containsKey("krediTime")) {
        await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
            {"krediTime": DateTime.now(), "kredi": 3}, SetOptions(merge: true));
        setState(() {
          kredi = 3;
        });

      } else {
        if (DateTime.now().subtract(Duration(days: 1)).isAfter(
            doc["krediTime"].toDate())) {
          await FirebaseFirestore.instance.collection("Users")
              .doc(user.uid)
              .get()
              .then((doc) {
            if (doc.data().containsKey("kredi")) {
              setState(() {
                kredi = doc["kredi"];
              });
            } else {
              setState(() {
                kredi = 2;
              });
            }
          });
          setState(() {
            kredi = kredi + 2;
          });
          await FirebaseFirestore.instance.collection("Users")
              .doc(user.uid)
              .set({"krediTime": DateTime.now(), "kredi": kredi},
              SetOptions(merge: true));
        } else {
          if (doc.data().containsKey("kredi")) {
            setState(() {
              kredi = doc["kredi"];
            });
          } else {
            setState(() {
              kredi = 2;
            });
          }
        }
      }
    });
    print(kredi);
    setState(() {
      allLoaded = true;
    });
    LocalNotification().scheduledNotify(
        2, "Ücretsiz Kredi", "Ücretsiz 2 kredin hazır gel ve al!", day: 1);
  }

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    await FirebaseFirestore.instance.collection("Users").doc(user.uid)
        .get()
        .then((doc) {
      setState(() {
        realName = doc.data().containsKey("adsoyad") ? doc["adsoyad"] : "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (admin) {
      return EditorHome(user: user, realName: realName,);
    }
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Image.asset(
              "assets/images/justLabel.png",
              scale: 5,
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                color: Colors.white,
                splashRadius: 25,
                onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>Bildirimler())),
              )
            ],
            centerTitle: true,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50.0),
                child: Image.asset(
                  "assets/images/BG.png",
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topRight,
                ),
              ),
              allLoaded ? Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height + 20,
                    ),
                    Expanded(
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: MediaQuery
                                .of(context)
                                .size
                                .height / 13.5),
                            child: ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(
                                  MediaQuery
                                      .of(context)
                                      .size
                                      .width / 13)),
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color(0xFF4F44DB),
                                          Color(0xFF14198E),
                                          Color(0xFF14198E),
                                          Color(0xFF6453F6)
                                        ],
                                        stops: [
                                          0.1,
                                          0.5,
                                          0.7,
                                          1
                                        ])),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 40 + MediaQuery
                                          .of(context)
                                          .size
                                          .height / 13.5,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 60),
                                      child: StreamBuilder(
                                        stream: FirebaseFirestore.instance
                                            .collection("Users")
                                            .doc(user.uid)
                                            .snapshots(),
                                        builder: (context, AsyncSnapshot<
                                            DocumentSnapshot> snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              "Merhaba ${snapshot
                                                  .data["adsoyad"]}!",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: MediaQuery
                                                      .of(context)
                                                      .size
                                                      .height / 32),
                                            );
                                          } else {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Merhaba ",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .height / 32),
                                                ),
                                                JumpingDotsProgressIndicator(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  milliseconds: 100,
                                                )
                                              ],
                                            );
                                          }
                                        },),
                                    ),
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 300,
                                    ),
                                    Text(
                                      "Tekrar hoşgeldin.",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 45),
                                    ),
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 60,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                40),
                                        child: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                style: TextStyle(
                                                    fontSize: MediaQuery
                                                        .of(context)
                                                        .size
                                                        .height /
                                                        40),
                                                children: [
                                                  TextSpan(
                                                    text: "Toplam ",
                                                  ),
                                                  WidgetSpan(
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            "Sorular")
                                                            .where(
                                                            "paylasanID",
                                                            isEqualTo: user
                                                                .uid)
                                                            .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                QuerySnapshot> snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return SizedBox(
                                                              height: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  30,
                                                              width: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  40,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    bottom: 2.0),
                                                                child: JumpingDotsProgressIndicator(
                                                                  fontSize: 20.0,
                                                                  color: Colors
                                                                      .white,
                                                                  milliseconds: 100,
                                                                ),
                                                              ),);
                                                          } else {
                                                            return Text(
                                                              snapshot.data
                                                                  .docs.length
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color:
                                                                  Color(
                                                                      0xFF00AE87),
                                                                  fontSize: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      35),
                                                            );
                                                          }
                                                        },)),
                                                  TextSpan(
                                                    text:
                                                    " soru sordun ve tekrarlanacak ",
                                                  ),
                                                  WidgetSpan(
                                                      child: StreamBuilder(
                                                        stream: FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            "Sorular")
                                                            .where(
                                                            "paylasanID",
                                                            isEqualTo: user
                                                                .uid)
                                                            .snapshots(),
                                                        builder: (context,
                                                            AsyncSnapshot<
                                                                QuerySnapshot> snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return SizedBox(
                                                              height: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  30,
                                                              width: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  40,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    bottom: 2.0),
                                                                child: JumpingDotsProgressIndicator(
                                                                  fontSize: 20.0,
                                                                  color: Colors
                                                                      .white,
                                                                  milliseconds: 100,
                                                                ),
                                                              ),);
                                                          } else {
                                                            int sayi = 0;
                                                            for (int i = 0; i <
                                                                snapshot.data
                                                                    .docs
                                                                    .length; i++) {
                                                              if ((snapshot
                                                                  .data
                                                                  .docs[i]
                                                                  .data()
                                                                  .containsKey(
                                                                  "tekrarNum") &&
                                                                  snapshot
                                                                      .data
                                                                      .docs[i]["tekrarNum"] !=
                                                                      3) ||
                                                                  !snapshot
                                                                      .data
                                                                      .docs[i]["tekrar"]) {
                                                                if (snapshot
                                                                    .data
                                                                    .docs[i]
                                                                    .data()
                                                                    .containsKey(
                                                                    "tekrarNum") &&
                                                                    snapshot
                                                                        .data
                                                                        .docs[i]["tekrarNum"] !=
                                                                        3) {
                                                                  if (snapshot
                                                                      .data
                                                                      .docs[i]["tekrarNum"] ==
                                                                      0 &&
                                                                      snapshot
                                                                          .data
                                                                          .docs[i]["tekrarTime"]
                                                                          .toDate()
                                                                          .isBefore(
                                                                          DateTime
                                                                              .now()
                                                                              .subtract(
                                                                              Duration(
                                                                                  days: 1)))) {
                                                                    sayi =
                                                                        sayi +
                                                                            1;
                                                                  } else
                                                                  if (snapshot
                                                                      .data
                                                                      .docs[i]["tekrarNum"] ==
                                                                      1 &&
                                                                      snapshot
                                                                          .data
                                                                          .docs[i]["tekrarTime"]
                                                                          .toDate()
                                                                          .isBefore(
                                                                          DateTime
                                                                              .now()
                                                                              .subtract(
                                                                              Duration(
                                                                                  days: 6)))) {
                                                                    sayi =
                                                                        sayi +
                                                                            1;
                                                                  } else
                                                                  if (snapshot
                                                                      .data
                                                                      .docs[i]["tekrarNum"] ==
                                                                      2 &&
                                                                      snapshot
                                                                          .data
                                                                          .docs[i]["tekrarTime"]
                                                                          .toDate()
                                                                          .isBefore(
                                                                          DateTime
                                                                              .now()
                                                                              .subtract(
                                                                              Duration(
                                                                                  days: 22)))) {
                                                                    sayi =
                                                                        sayi +
                                                                            1;
                                                                  }
                                                                }
                                                              }
                                                            }
                                                            return Text(
                                                              sayi.toString(),
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  color:
                                                                  Color(
                                                                      0xFFFF9600),
                                                                  fontSize: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      35),
                                                            );
                                                          }
                                                        },)),
                                                  TextSpan(
                                                    text: " sorun daha var", //0xFFFF9600
                                                  )
                                                ])),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 40,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                15),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () async {
                                                  await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
                                                    setState(() {
                                                      kredi=doc.data().containsKey("kredi")?doc["kredi"]:null;
                                                    });
                                                  });
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (
                                                              context) =>
                                                          kredi != null &&
                                                              kredi != 0
                                                              ? firstAdd
                                                              ? SoruZorluk()
                                                              : FirstAdd()
                                                              : YetersizKredi()));
                                                },
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                        topLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 7),
                                                        topRight: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        bottomLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        bottomRight:
                                                        Radius.circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFF5068EE),),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceEvenly,
                                                          mainAxisSize: MainAxisSize
                                                              .max,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  right: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20),
                                                              child: Image
                                                                  .asset(
                                                                "assets/images/camIcon.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    15,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      200,
                                                                  bottom: 1),
                                                              child: Text(
                                                                "Soru Yükle",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 30,),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                BottomNav(
                                                                  currentIndex: 2,))),

                                                child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                        topLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        topRight: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 7),
                                                        bottomLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        bottomRight:
                                                        Radius.circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFF41C6FF),),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceEvenly,
                                                          mainAxisSize: MainAxisSize
                                                              .max,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  right: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20),
                                                              child: Image
                                                                  .asset(
                                                                "assets/images/repeatIcon.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    15,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      200,
                                                                  bottom: 1),
                                                              child: Text(
                                                                "Tekrar Yap",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 30,),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal:
                                            MediaQuery
                                                .of(context)
                                                .size
                                                .width /
                                                15),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                BottomNav(
                                                                  currentIndex: 1,))),

                                                child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                        topLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        topRight: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        bottomLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 7),
                                                        bottomRight:
                                                        Radius.circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFF00AE87),),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceEvenly,
                                                          mainAxisSize: MainAxisSize
                                                              .max,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  right: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20),
                                                              child: Image
                                                                  .asset(
                                                                "assets/images/questionWallIcon.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    15,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      200,
                                                                  bottom: 1),
                                                              child: Text(
                                                                "Soru Duvarı",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            SizedBox(width: MediaQuery
                                                .of(context)
                                                .size
                                                .width / 30,),
                                            Expanded(
                                              child: GestureDetector(
                                                onTap: () =>
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>MySettings.Settings())),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                        topLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        topRight: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        bottomLeft: Radius
                                                            .circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 13),
                                                        bottomRight:
                                                        Radius.circular(
                                                            MediaQuery
                                                                .of(context)
                                                                .size
                                                                .width / 7)),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                            0xFFFF4800),),
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceEvenly,
                                                          mainAxisSize: MainAxisSize
                                                              .max,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  left: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  right: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20,
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .width /
                                                                      20),
                                                              child: Image
                                                                  .asset(
                                                                "assets/images/settingsIcon.png",
                                                                height: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    16,
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                  top: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      200,
                                                                  bottom: 1),
                                                              child: Text(
                                                                "Ayarlar",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 40,
                                    ),
                                  ],
                                ),
                              ),),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 13.5 * 2,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 13.5 * 2,
                              ),
                              StreamBuilder(stream: FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(user.uid)
                                  .snapshots(),
                                  builder: (context, AsyncSnapshot<
                                      DocumentSnapshot>snapshot) {
                                    if (snapshot.hasData) {
                                      if (snapshot.data.data().containsKey(
                                          "pp")) {
                                        return CircleAvatar(
                                          radius: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 15,
                                          backgroundImage: CachedNetworkImageProvider(
                                              snapshot.data["pp"]),
                                        );
                                      } else {
                                        return Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 7.5,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 7.5,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Color(0xFF6453F6)),
                                          child: FittedBox(child: Padding(
                                            padding: const EdgeInsets.all(
                                                10.0),
                                            child: Text(realName[0],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 100),),
                                          )),);
                                      }
                                    } else {
                                      return Container(height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 7.5,
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .height / 7.5,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF6453F6)),
                                        child: FittedBox(child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Text(realName[0],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 100),),
                                        )),);
                                    }
                                    /*ppURL!=null?CircleAvatar(
                                  radius: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 15,
                                  backgroundImage: CachedNetworkImageProvider(
                                      ppURL),
                                ):Container(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 7.5,width: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 7.5,decoration: BoxDecoration(shape:BoxShape.circle,color: Color(0xFF6453F6)),child: FittedBox(child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(realName[0],style: TextStyle(color:Colors.white,fontSize: 100),),
                                )),)
*/
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ) : Container(
                child: Center(child: CircularProgressIndicator(),),),
            ],
          ),
        ),
      ),
    );
  }
}
