import 'package:flutter/material.dart';

class SignInInner extends StatefulWidget {
  @override
  _SignInInnerState createState() => _SignInInnerState();
}

class _SignInInnerState extends State<SignInInner> {
  List<String> chooseClassList = ["9", "10", "11", "12", "Mezun"];
  String choosedClass;
  List<String> chooseAlanList = ["Sayısal", "Sözel", "Eşit Ağırlık", "Dil"];
  String choosedAlan;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          "assets/images/justLabel.png",
          scale: 5,
        ),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/BG.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.topRight,
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: AppBar().preferredSize.height + 20,
                  ),
                  Text(
                    "Hesap Oluştur",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),

                  //İSİM SOYİSİM-------------------
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 3),
                        child: Text(
                          "İsim & Soyisim",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextField(),
                        )),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  //KULLANICI ADI-------------------
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 3),
                        child: Text(
                          "Kullanıcı Adı",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextField(),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  //ŞİFRE-------------------
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 3),
                        child: Text(
                          "Şifre",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextField(obscureText: true,),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  //ŞİFRE ONAY-------------------
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 3),
                        child: Text(
                          "Şifre (Tekrar)",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: TextField(obscureText: true,),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  //SINIF SEÇİMİ---
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 3),
                        child: Text(
                          "Sınıf Seçimi",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                        color: Color(0xFFBA00FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: DropdownButton<String>(
                            dropdownColor: Color(0xFFBA00FF),
                            focusColor: Color(0xFFBA00FF),
                            iconEnabledColor: Colors.white,
                            hint: Text("Sınıf Seçin",style: TextStyle(color: Colors.white),),
                            isExpanded: true,
                            value: choosedClass,
                            items: chooseClassList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (s) {
                              setState(() {
                                choosedClass = s;
                                print(choosedClass);
                              });
                            },
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  //ALAN SEÇİMİ-------
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 15, bottom: 3),
                        child: Text(
                          "Alan Seçimi",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                        color: Color(0xFFBA00FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 2),
                          child: DropdownButton<String>(
                            dropdownColor: Color(0xFFBA00FF),
                            focusColor: Color(0xFFBA00FF),
                            iconEnabledColor: Colors.white,
                            hint: Text("Alan Seçin",style: TextStyle(color: Colors.white),),
                            isExpanded: true,
                            value: choosedAlan,
                            items: chooseAlanList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value,style: TextStyle(color: Colors.white),),
                              );
                            }).toList(),
                            onChanged: (s) {
                              setState(() {
                                choosedAlan = s;
                                print(choosedAlan);
                              });
                            },
                          ),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)),
                            height: 45,
                            color: Colors.white,
                            minWidth: MediaQuery.of(context).size.width/2.3,
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "TEMİZLE",
                                style: TextStyle(color: Colors.black,fontSize: 18),
                              ),
                            )),
                        Container(
                          height: 45.0,
                          child: FlatButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [Color(0xFF00AD88), Color(0xFF6D5EFF)],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(45.0)
                              ),
                              child: Container(
                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.3, minHeight: 45.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "KAYDOL",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,fontSize: 18
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal:40.0),
                    child: Text("Kaydola tıklayarak,\nKullanım Koşulları' nı kabul etmiş olursunuz.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
