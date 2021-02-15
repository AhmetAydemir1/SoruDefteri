import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:soru_defteri/Models/Messaging.dart';
import 'package:soru_defteri/UI/Settings/Kredi.dart';
import 'package:soru_defteri/UI/Settings/PremiumOldu%C4%B1.dart';
import 'package:toggle_switch/toggle_switch.dart';

class KodKullan extends StatefulWidget {
  @override
  _KodKullanState createState() => _KodKullanState();
}

class _KodKullanState extends State<KodKullan> {
  bool davetBu=true;
  TextEditingController kodEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6453F6),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text("Kodunu Gir Soru Hakkı Kazan"),
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/BG.png",
                fit: BoxFit.fitWidth,
                alignment: Alignment.topRight,
              ),
              SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: AppBar().preferredSize.height + 20,
                      ),
                      Image.asset(
                        "assets/images/signIn.png",
                        scale: 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Text(
                        "Hemen kodunu gir,\nücretsiz kredi kazan. ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff65BEAF),
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextField(
                                decoration: InputDecoration(border: InputBorder.none),
                                controller: kodEdit,
                              ),
                            )),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height/100,),
                      // Here, default theme colors are used for activeBgColor, activeFgColor, inactiveBgColor and inactiveFgColor
                      ToggleSwitch(
                        minWidth: MediaQuery.of(context).size.width/3,
                        cornerRadius: 20,
                        activeBgColor: Color(0xFF00AE87),
                        initialLabelIndex: 0,
                        inactiveFgColor: Colors.white,
                        labels: ['Davet Kodu', 'Kredi Kodu',],
                        onToggle: (index) {
                            if(index==0){
                              davetBu=true;
                            }else{
                              davetBu=false;
                            }
                          print('switched to: $davetBu');
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Container(
                        height: 50.0,
                        child: FlatButton(
                          onPressed: () =>davetBu? useDavetKod() :useCode(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Color(0xFFC4B74D),
                                borderRadius: BorderRadius.circular(50.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width / 1.8,
                                  minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Kodu Kullan",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  useDavetKod()async{
    User user=FirebaseAuth.instance.currentUser;
    if (kodEdit.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Users").where("davetKodu",isEqualTo: kodEdit.text.trim()).limit(1).get().then((docs)async{
        if (docs.docs.isNotEmpty) {
          DocumentSnapshot doc=docs.docs[0];
          int kredi;
          bool kodUsed;
          String userName;
          await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
            kredi = doc["kredi"];
            kodUsed=doc.data().containsKey("kodUsed")?true:false;
            userName=doc["userName"];
          });
          if (!kodUsed) {
            if (user.uid!=doc.id) {
              await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
                  {"davetBy":doc.id,"kredi":kredi+3,"kodUsed":true},SetOptions(merge: true));
              Fluttertoast.showToast(msg: "3 Krediniz hesabınıza başarıyla eklendi!");
              int otherKredi;
              String fcmToken;
              await FirebaseFirestore.instance.collection("Users").doc(doc.id).get().then((doc){
                otherKredi=doc["kredi"];
                fcmToken=doc["fcmToken"];
              });
              await FirebaseFirestore.instance.collection("Users").doc(doc.id).set({"koduKullananlar":FieldValue.arrayUnion([user.uid]),"kredi":otherKredi+5},SetOptions(merge:true));
              Messaging.sendTo(title: "5 Kredi Kazandın!", body: "$userName adlı kullanıcı davet kodunu kullandı.", fcmToken: fcmToken,userid: user.uid,date: DateTime.now(),userNickName: userName,notiType: "davetKod");
            }else{
              Fluttertoast.showToast(msg: "Kendi davet kodunuzu kullanamazsınız!");
            }
          }else{
            Fluttertoast.showToast(msg: "Zaten bir davet kodu kullanmışsınız.");
          }
        }else{
          Fluttertoast.showToast(msg: "Böyle bir kod bulunamadı.");
        }
      });
    }else{
      Fluttertoast.showToast(msg: "Lütfen bir kod giriniz.");
    }

  }


  useCode()async{
    User user=FirebaseAuth.instance.currentUser;
    if (kodEdit.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection("Kodlar").doc(kodEdit.text.trim()).get().then((doc)async{
        if (doc.exists) {
          if (doc["kullananlar"].length<doc["kapasite"]) {
            if(!doc["kullananlar"].contains(user.uid)){
              await FirebaseFirestore.instance.collection("Kodlar").doc(kodEdit.text.trim()).update(
                  {"kullananlar":FieldValue.arrayUnion([user.uid])});
              int kredi;
              await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
                kredi=doc["kredi"];
              });
              await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(
                  {"kredi":kredi+100,"100Kredi":kodEdit.text.trim()},SetOptions(merge:true));
              Fluttertoast.showToast(msg: "100 Kredi hesabınıza yüklendi!");
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Kredi()));
            }else{
              Fluttertoast.showToast(msg: "Bu kodu daha önce kullanmışsınız.");
            }
          }else{
            Fluttertoast.showToast(msg: "Bu kodun kapasitesi dolmuştur.");
            await FirebaseFirestore.instance.collection("Kodlar").doc(kodEdit.text.trim()).delete();
          }
        }else{
          Fluttertoast.showToast(msg: "Böyle bir kod bulunamadı.");
        }
      });
    }else{
      Fluttertoast.showToast(msg: "Lütfen bir kod giriniz.");
    }
  }
}
