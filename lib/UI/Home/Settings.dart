
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:soru_defteri/UI/Home/MyProfile.dart';
import 'package:soru_defteri/UI/Settings/DavetEt.dart';
import 'package:soru_defteri/UI/Settings/KodGenerate.dart';
import 'package:soru_defteri/UI/Settings/Kredi.dart';
import 'package:soru_defteri/UI/Settings/PremiumOldu%C4%B1.dart';
import 'package:soru_defteri/UI/Settings/hakkimizda.dart';
import 'package:soru_defteri/UI/Sign/GizlilikP.dart';
import 'package:soru_defteri/UI/Sign/KullanimK.dart';
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
  bool premium=false;



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
        premium=doc.data().containsKey("premium") ? doc["premium"] : false;
      });
    });
    setState(() {
      allLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6453F6),
            title: Text("Ayarlar"),
          ),
          body: allLoaded
              ? Center(
                  child: Column(
                    children: [
                      Expanded(
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
                                              color: Color(0xFF6453F6)),
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
                              SizedBox(height: 20,),
                          StreamBuilder(stream: FirebaseFirestore.instance.collection("Users").doc(user.uid).snapshots(),builder: (context,AsyncSnapshot<DocumentSnapshot> snapshot){
                            if(snapshot.hasData){
                              return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width / 15),
                                    child: Text(snapshot.data["adsoyad"],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600)),
                                  ));
                            }else{
                              return Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: MediaQuery.of(context).size.width / 15),
                                        child: JumpingDotsProgressIndicator(fontSize: 20,color: Colors.white,numberOfDots: 10,),
                                      )),
                                ],
                              );

                            }
                          },),
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
                                        ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfile())),title: Text("Profilim",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                        ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>premium ? PremiumOldu() : Kredi())),title: Text("Krediler",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                        ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Hakkimizda())),title: Text("Hakkımızda",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                        ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>KullanimK())),title: Text("Kullanım Koşulları",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                        ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>GizlilikP())),title: Text("Gizlilik Politikası",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                        ListTile(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DavetEt())),title: Text("Davet Et & Kazan",style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w300)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                        ListTile(onTap: ()=>cikis(),title: Text("Çıkış",style: TextStyle(color: Color(0xFFFF0000),fontSize: 16,fontWeight: FontWeight.bold)),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),),
                                      ]).toList(),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(onLongPress: ()async{
                        await FirebaseFirestore.instance.collection("Editor").doc("Editor").get().then((doc){
                          if(doc["editor"].contains(user.uid)){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>KodGenerate()));
                          }
                        });
                      },child: Image.asset("assets/images/justLabel.png",scale: 4,)),
                      SizedBox(height: 20,)
                    ],
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
