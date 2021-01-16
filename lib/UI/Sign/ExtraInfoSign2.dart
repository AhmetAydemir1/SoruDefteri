import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Sign/Izinler.dart';
import 'package:soru_defteri/UI/Sign/SignInDone.dart';

class SignInExtraInfo2 extends StatefulWidget {
  String sinif;
  SignInExtraInfo2({Key key,@required this.sinif}):super(key: key);
  @override
  _SignInExtraInfo2State createState() => _SignInExtraInfo2State();
}

class _SignInExtraInfo2State extends State<SignInExtraInfo2> {
  List chooseAlanBoolList = List.generate(4, (index) => false);
  List<String> chooseAlanList = [
    "Sayısal (MF)",
    "Eşit Ağırlık (TM)",
    "Sözel (TS)",
    "Dil"
  ];
  String choosedAlan="Sayısal (MF)";
  User user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseAlanBoolList[0]=true;
  }

  @override
  void didChangeDependencies() {
    precacheImage(Image.asset("assets/images/justLabel.png").image, context);
    precacheImage(Image.asset("assets/images/splashBG1.png").image, context);
    precacheImage(Image.asset("assets/images/signIn.png").image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6E719B),
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
            "assets/images/splashBG1.png",
            fit: BoxFit.fitHeight,
            alignment: Alignment.topLeft,
          ),
          Opacity(
              opacity: 0.5,
              child: Container(
                color: Colors.black38,
              )),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: AppBar().preferredSize.height + 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Image.asset(
                    "assets/images/signIn.png",
                    scale: 5,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      right: 30.0, left: 30.0, top: 20, bottom: 10),
                  child: Text(
                    "Sona geldik, hangi sınava hazırlandığını seçmelisin",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: chooseAlanBoolList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          chooseAlanBoolList.fillRange(0, 4, false);
                          if (!chooseAlanBoolList[index]) {
                            chooseAlanBoolList[index] =
                                !chooseAlanBoolList[index];
                          }
                          choosedAlan=chooseAlanList[index];
                          print(chooseAlanList[index]);
                        });
                      },
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            chooseAlanList[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: chooseAlanBoolList[index]
                                  ? Colors.white
                                  : Color(0xFF9598B7)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: chooseAlanBoolList[index]
                                ? Icon(
                                    Icons.circle,
                                    size: 10,
                                    color: Colors.orange,
                                  )
                                : Container(
                                    height: 10,
                                    width: 10,
                                  ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Container(
                            height: 45.0,
                            child: FlatButton(
                              onPressed: () async {
                                SharedPreferences prefs=await SharedPreferences.getInstance();
                                if(prefs.getBool("firstSign")==null){
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Izinler()));

                                }else{
                                  prefs.setBool("firstSign",false);
                                  Navigator.popUntil(context, (route) => route.isFirst);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SignInDone()));
                                }
                                await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({"sinif":widget.sinif,"alan":choosedAlan},SetOptions(merge: true));
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
                                      maxWidth: MediaQuery.of(context).size.width / 2.3,
                                      minHeight: 45.0),
                                  alignment: Alignment.center,
                                  child: Text(
                                    "DEVAM ET",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                  height: 20,
                ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
