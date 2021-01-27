import 'package:flutter/material.dart';

class PremiumOl extends StatefulWidget {
  @override
  _PremiumOlState createState() => _PremiumOlState();
}

class _PremiumOlState extends State<PremiumOl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            title: Text("Premium Üyelik Avantajları"),
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6E719B),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Premium Üyelik ile kesintisiz\nSoru Defteri deneyimi!",
                        style:
                            TextStyle(color: Color(0xFF00AE87), fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "When one door of happiness closes, another opens, but often we look so long at the closed door that we do not see the one that has been opened for us.",
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
                          style:
                              TextStyle(color: Color(0xFF00AE87), fontSize: 22,fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "When one door of happiness closes, another opens, but often we look so long at the closed.",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w300,
                              fontSize: 17),
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:30.0),
                      child: Image.asset("assets/images/premiumOl.png",fit: BoxFit.fitWidth,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20.0),
                      child: Align(
                        child: Container(
                          height: 45.0,
                          child: FlatButton(
                            onPressed: () {

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
                                    maxWidth: MediaQuery.of(context).size.width / 2,
                                    minHeight: 45.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "Premium Üye Ol",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )

                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
