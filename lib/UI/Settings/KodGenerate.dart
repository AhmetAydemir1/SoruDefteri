import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class KodGenerate extends StatefulWidget {
  @override
  _KodGenerateState createState() => _KodGenerateState();
}

class _KodGenerateState extends State<KodGenerate> {

  TextEditingController kodEdit =TextEditingController();
  TextEditingController sayiEdit =TextEditingController();

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
            title: Text("Kod Üret"),
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
                        "Premium Üyelik için kod üretin.",
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
                                decoration: InputDecoration(hintText: "Kod",border: InputBorder.none),
                                controller: kodEdit,
                              ),
                            )),
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
                                decoration: InputDecoration(hintText: "Kod Kullanım Kapasitesi",border: InputBorder.none),
                                controller: sayiEdit,
                                keyboardType: TextInputType.number,
                              ),
                            )),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        height: 45.0,
                        child: FlatButton(
                          onPressed: () =>generate(),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45.0)),
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                                color: Color(0xFFC4B74D),
                                borderRadius: BorderRadius.circular(45.0)),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width / 3,
                                  minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text(
                                "Kodu Üret",
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

  generate()async{
    await FirebaseFirestore.instance.collection("Kodlar").doc(kodEdit.text.trim()).set({"kod":kodEdit.text.trim(),"kapasite":int.parse(sayiEdit.text),"kullananlar":[]});
    Fluttertoast.showToast(msg: "Kod başarıyla üretildi.", gravity: ToastGravity.CENTER,backgroundColor: Colors.yellow,textColor: Colors.black);
  }
}
