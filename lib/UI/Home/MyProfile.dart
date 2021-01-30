import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool allLoaded = false;
  User user = FirebaseAuth.instance.currentUser;
  String realName;
  String userName;
  String sinif;
  String alan;
  String ppURL;

  List<String> chooseClassList = [
    "9. Sınıf",
    "11. Sınıf",
    "12. Sınıf",
    "Mezun"
  ];
  List<String> chooseAlanList = [
    "Sayısal (MF)",
    "Eşit Ağırlık (TM)",
    "Sözel (TS)",
    "Dil"
  ];

  TextEditingController realNameEdit = TextEditingController();
  TextEditingController userNameEdit = TextEditingController();

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
      if (doc.data().containsKey("sinif")) {
        sinif = doc["sinif"];
      }
      if (doc.data().containsKey("alan")) {
        alan = doc["alan"];
      }
      if (doc.data().containsKey("userName")) {
        userName = doc["userName"];
        userNameEdit.text = userName;
      }
      if (doc.data().containsKey("adsoyad")) {
        realName = doc["adsoyad"];
        realNameEdit.text = realName;
      }
      if (doc.data().containsKey("pp")) {
        ppURL = doc["pp"];
      }
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
            title: Text(
              "Profilim",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Center(
            child: allLoaded
                ? Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  ppURL != null
                                      ? Stack(
                                    alignment: Alignment.center,
                                        children: [
                                          Container(height: 80,width: 80,decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                          ),),
                                          CircleAvatar(
                                              radius: 35,
                                              child: Container(
                                                decoration: BoxDecoration(shape: BoxShape.circle),
                                                height: 70,width: 70,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.all(Radius.circular(100)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: ppURL,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      )
                                      : Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          height: 80,
                                          width: 80,
                                          child: Icon(
                                            Icons.person,
                                            size: 70,
                                            color: Color(0xff00AE87),
                                          ),
                                        ),
                                  Container(
                                      height: 80,
                                      width: 80,
                                      child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              height: 25,
                                              width: 25,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xff00AE87)),
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                                size: 24,
                                              )))),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Fotoğrafı Değiştir",
                                style: TextStyle(color: Color(0xff00AE87)),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Bilgileri Güncelle",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    )),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Adınız & Soyadınız",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20.0, right: 20),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        alignLabelWithHint: true,
                                        hintText: realName,
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                        border: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                        disabledBorder: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      controller: realNameEdit,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Kullanıcı Adı",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 20.0, right: 20),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        isDense: true,
                                        alignLabelWithHint: true,
                                        hintText: userName,
                                        fillColor: Colors.white,
                                        focusColor: Colors.white,
                                        border: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                        disabledBorder: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: new UnderlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      style: TextStyle(color: Colors.white),
                                      controller: userNameEdit,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Sınıfınız",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Container(
                                        color: Color(0xFF6E719B),
                                        child: DropdownButton<String>(
                                          dropdownColor: Color(0xFF6E719B),
                                          focusColor: Color(0xFF6E719B),
                                          iconEnabledColor: Colors.white,
                                          hint: Text(
                                            "Sınıf Seçin",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          isExpanded: true,
                                          value: sinif,
                                          items: chooseClassList.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (s) {
                                            setState(() {
                                              sinif = s;
                                              print(sinif);
                                            });
                                          },
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Alanınız",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w300,
                                              fontSize: 13),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20),
                                    child: Container(
                                        color: Color(0xFF6E719B),
                                        child: DropdownButton<String>(
                                          dropdownColor: Color(0xFF6E719B),
                                          focusColor: Color(0xFF6E719B),
                                          iconEnabledColor: Colors.white,
                                          hint: Text(
                                            "Alan Seçin",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          isExpanded: true,
                                          value: alan,
                                          items: chooseAlanList.map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (s) {
                                            setState(() {
                                              alan = s;
                                              print(alan);
                                            });
                                          },
                                        )),
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    height: 30.0,
                                    child: FlatButton(
                                      onPressed: () async {
                                        Map<String,dynamic> userInfo=Map();
                                        if(userNameEdit.text.isNotEmpty){
                                          userInfo["userName"]=userNameEdit.text;
                                        }
                                        if(realNameEdit.text.isNotEmpty){
                                          userInfo["adsoyad"]=realNameEdit.text;
                                        }
                                        userInfo["sinif"]=sinif;
                                        userInfo["alan"]=alan;
                                        Navigator.pop(context);
                                        await FirebaseFirestore.instance.collection("Users").doc(user.uid).set(userInfo,SetOptions(merge: true));
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
                                              maxWidth:
                                                  MediaQuery.of(context).size.width / 3,
                                              minHeight: 30.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Güncelle",
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
                            ],
                          ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Image.asset("assets/images/justLabel.png",scale: 4,),
                    SizedBox(height: 20,)
                  ],
                )
                : CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
