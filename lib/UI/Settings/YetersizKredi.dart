import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Settings/PremiumAvantaj.dart';

class YetersizKredi extends StatefulWidget {
  @override
  _YetersizKrediState createState() => _YetersizKrediState();
}

class _YetersizKrediState extends State<YetersizKredi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            title: Text("Krediler"),
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6E719B),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Ops...\nSanırım Krediniz\nBitmiş",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Image.asset(
                    "assets/images/krediBitik.png",
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text:
                                "Sorularınızı yükleyebilmek için reklamlarımızı izleyebilir veya "),
                        TextSpan(
                            text: "Premium Üyelik",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(
                            text:
                                " satın alarak kesintisiz Soru Defteri deneyimi yaşayabilirsiniz."),
                      ], style: TextStyle(fontSize: 17, color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 45.0,
                              child: FlatButton(
                                onPressed: () {},
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
                                            MediaQuery.of(context).size.width / 2.4,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Reklam İzle",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text("1 reklam izleyerek\n2 kredi kazanabilirsiniz.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12),)
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 45.0,
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PremiumOl()));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45.0)),
                                padding: EdgeInsets.all(0.0),
                                child: Ink(
                                  decoration: BoxDecoration(
                                      color: Color(0xFFC4B74D),
                                      borderRadius: BorderRadius.circular(45.0)),
                                  child: Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width / 2.4,
                                        minHeight: 45.0),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Premium Üye Ol",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 3,),
                            Text("Kesintisiz Soru Defteri\nDeneyimi yaşayabilirsiniz.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 12),)

                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
