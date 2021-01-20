import 'dart:async';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Settings/Kredi.dart';
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
  bool ppLoad=true;
  List<File> pimageList = [];
  File pimage;
  final picker = ImagePicker();


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
                            GestureDetector(
                              onTap: ()=>changeProfile(),
                              child: ppURL != null
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
                            ),
                            !ppLoad
                                ? Container(
                              height: (MediaQuery.of(context).size.height / 20)*2,
                              width: (MediaQuery.of(context).size.height / 20)*2,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white24,
                              ),
                              child: Center(
                                child:
                                CircularProgressIndicator(),
                              ),
                            )
                                : Container()
                          ],
                        ),
                        SizedBox(height: 20,),
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
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 0,horizontal: 20.0),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: ListTile.divideTiles(
                                color: Colors.white,
                                context: context,
                                tiles: [
                                  ListTile(title: Text("Profilim",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                  ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Kredi())),title: Text("Krediler",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
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
                        ),
                        
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

  changeProfile() async {
    setState(() {
      ppLoad = false;
    });
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile == null) {
        setState(() {
          ppLoad = true;
        });
        return null;
      }
      setState(() {
        pimage = File(pickedFile.path);
      });
      String kapakurlsial;
      //fotoyu upload et ve tokenini al
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child("Users")
          .child(user.uid)
          .child("ProfilePhoto")
          .child("pp${user.uid}")
          .putFile(pimage);
      final StreamSubscription streamSubscription =
      uploadTask.snapshotEvents.listen((event) {
        print("stream subs çalışıyor.");
      });
      streamSubscription.cancel();
      String docUrl = await (await uploadTask).ref.getDownloadURL();
      kapakurlsial = docUrl;
      //firestorea yazdır
      Map<String, dynamic> kullaniciPrefs = Map();
      kullaniciPrefs["pp"] = kapakurlsial;
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .update(kullaniciPrefs)
          .whenComplete(
            () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          setState(() {
            prefs.setString("ppURL", kapakurlsial);
          });
        },
      );

      await user.updateProfile(photoURL: kapakurlsial);
      setState(() {
        ppURL = kapakurlsial;
      });
    } on Exception catch (e) {
      print(e.toString());
    }

    setState(() {
      ppLoad = true;
    });
  }

}
