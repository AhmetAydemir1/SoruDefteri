import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soru_defteri/UI/Settings/PremiumOldu%C4%B1.dart';

class PremiumOl extends StatefulWidget {
  @override
  _PremiumOlState createState() => _PremiumOlState();
}

class _PremiumOlState extends State<PremiumOl> {
  List<IAPItem> _items = [];
  User user = FirebaseAuth.instance.currentUser;
  StreamSubscription _purchaseUpdatedSubscription;
  bool premiumAlindi;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    var result = await FlutterInappPurchase.instance.initConnection;
    print('result: $result');
    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((event) async {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .set({"premium": true}, SetOptions(merge: true));
      setState(() {
        premiumAlindi = true;
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => PremiumOldu()));
      print(event);
      print("TOKENNN");
    });
    List<IAPItem> items =
        await FlutterInappPurchase.instance.getSubscriptions(["premium_subs"]);
    for (var item in items) {
      setState(() {
        _items.add(item);
      });

      print(await subscriptionStatus(item.productId));
      bool temp = await subscriptionStatus(item.productId);
      setState(() {
        premiumAlindi = temp;
      });
      print("ALINMIŞ MI");
    }
    iptalEt(_items[0].productId);
  }

  iptalEt(String sku) async {
    if (Platform.isIOS) {
      var history = await FlutterInappPurchase.instance.getPurchaseHistory();

      for (var purchase in history) {
        if (purchase.productId == sku) {
          print(purchase.purchaseToken);
        }
      }
    } else if (Platform.isAndroid) {
      var purchases =
          await FlutterInappPurchase.instance.getAvailablePurchases();

      for (var purchase in purchases) {
        if (purchase.productId == sku) {
          print(purchase.purchaseToken);
        }
      }
      print("token");
    }
  }

  static Future<bool> subscriptionStatus(String sku,
      [Duration duration = const Duration(days: 30),
      Duration grace = const Duration(days: 0)]) async {
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
      var purchases =
          await FlutterInappPurchase.instance.getAvailablePurchases();

      for (var purchase in purchases) {
        if (purchase.productId == sku) return true;
      }
      return false;
    }
    throw PlatformException(
        code: Platform.operatingSystem, message: "platform not supported");
  }

  void _requestPurchase(IAPItem item) async {
    print("enbas");
    try {
      print("enter");
      await FlutterInappPurchase.instance
          .requestSubscription(item.productId)
          .then((value) => print("a"));
      //TODO SATIN ALDIKTAN SONRA FONKSİYONLAR ÇALIŞMIYOR.
      print("almost");

      print("ok");
    } on Exception catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            title: Text("Premium Üyelik Avantajları"),
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6453F6),
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Premium Üyelik ile kesintisiz\nSoru Defteri deneyimi!",
                  style: TextStyle(
                      color: Color(0xFF00AE87),
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  "Premium üyelik ile, Soru Defterim’de istediğiniz kadar soruyu, reklamsız olarak yükleyebilirsiniz.\nPremium deneyimini, ayda sadece 10₺ karşılığında alabilirsiniz. ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 17),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    "Premium Üyeliğin Tadını Çıkar!",
                    style: TextStyle(
                        color: Color(0xFF00AE87),
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image.asset(
                  "assets/images/premiumOl.png",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Expanded(
                child: Center(
                  child: premiumAlindi != null
                      ? !premiumAlindi
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Align(
                                child: Container(
                                  height: 45.0,
                                  child: FlatButton(
                                    onPressed: () {
                                      _requestPurchase(_items[0]);
                                    },
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(45.0)),
                                    padding: EdgeInsets.all(0.0),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                          color: Color(0xFFC4B74D),
                                          borderRadius:
                                              BorderRadius.circular(45.0)),
                                      child: Container(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.5,
                                            minHeight: 45.0),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "Premium Üye Ol " +
                                              " ${_items.isNotEmpty ? "(" + _items[0].localizedPrice + "/Aylık)" : ""}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container()
                      : Center(child: CircularProgressIndicator()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _purchaseUpdatedSubscription.cancel();
  }
}
