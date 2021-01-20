import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Sign/SignIn.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  User user = FirebaseAuth.instance.currentUser;
  String ppURL;
  String realName;
  bool allLoaded = false;
  String phoneNumber;

  cikis() {
    FirebaseAuth.instance.signOut();
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }

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
        realName = doc.data().containsKey("adsoyad") ? doc["adsoyad"] : "";
        ppURL = doc.data().containsKey("pp") ? doc["pp"] : null;
      });
    });
    setState(() {
      allLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6E719B),
            title: Text("Ayarlar"),
          ),
          body: allLoaded
              ? Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              height: MediaQuery.of(context).size.height / 18 * 2,
                              width: MediaQuery.of(context).size.height / 18 * 2,
                            ),
                            ppURL != null
                                ? CircleAvatar(
                                    radius:
                                        MediaQuery.of(context).size.height / 20,
                                    backgroundImage:
                                        CachedNetworkImageProvider(ppURL),
                                  )
                                : Container(
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    width:
                                        MediaQuery.of(context).size.height / 10,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFF6E719B)),
                                    child: FittedBox(
                                        child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        realName[0],
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 100),
                                      ),
                                    )),
                                  ),
                          ],
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 15),
                              child: Text(realName,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600)),
                            )),
                        SizedBox(
                          height: 3,
                        ),
                        user.phoneNumber != null
                            ? Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          MediaQuery.of(context).size.width / 15),
                                  child: Text(user.phoneNumber,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300)),
                                ))
                            : Container(),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: ListTile.divideTiles(
                                color: Colors.white,
                                context: context,
                                tiles: [
                                  ListTile(title: Text("Profilim",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(title: Text("Krediler",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(title: Text("Hakkımızda",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(title: Text("Kullanım Koşulları",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(title: Text("Gizlilik Politikası",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(title: Text("Davet Et & Kazan",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(onTap: ()=>cikis(),title: Text("Çıkış",style: TextStyle(color: Color(0xFFFF0000),fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                ]).toList(),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height /
                              8,
                        )
                      ],
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
