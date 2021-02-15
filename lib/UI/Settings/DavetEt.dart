import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';

class DavetEt extends StatefulWidget {
  @override
  _DavetEtState createState() => _DavetEtState();
}

class _DavetEtState extends State<DavetEt> {
  TextEditingController textEditingController = TextEditingController();
  User user =FirebaseAuth.instance.currentUser;
  String davetKodu;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync()async{
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
      setState(() {
        davetKodu=doc["davetKodu"];
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
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(
              "Davet Et & Kazan",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Arkadaşını Davet Et, 5 Kredi Kazan!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 36,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Arkadaşlarını soru defterine davet edersen, hem davet ettiğin arkadaşın kredi kazanır, hem de sen kredi kazanırsın! Arkadaşın, senin kodunu krediler alanında kullanarak, 3 kredi kazanır. Kodun kullanılırsa hesabına otomatik\n5 kredi tanımlanır.",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Arkadaşlarına davet kodu gönder,\nhediyeni hemen kap!!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      )),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Image.asset(
                    "assets/images/davetEt.png",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 70,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("DAVET KODUN",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 300,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(13))),
                      child: Container(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(davetKodu,style: TextStyle(fontSize: 20)),
                              ),
                              IconButton(splashRadius: 24,icon: Icon(Icons.copy),onPressed: ()=>FlutterClipboard.copy(davetKodu).then((value) => Fluttertoast.showToast(msg:"Davet kodunuz kopyalandı.")),)
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(height: MediaQuery.of(context).size.height/300,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: FlatButton(
                    onPressed: ()=>share(),
                    height: 60,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Color(0xFF00AE87),
                          borderRadius: BorderRadius.circular(13.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1,
                            minHeight: 60.0),
                        alignment: Alignment.center,
                        child: Text(
                          "Arkadaşlarını Davet Et",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18,fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  )
                  ,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  share()async{
    Share.share("http://onelink.to/sorudefteri indir ve \"$davetKodu\" kodunu kullanarak 3 kredi kazan!");
  }
}
