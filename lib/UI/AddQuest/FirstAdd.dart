import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/AddQuest/BottomNav.dart';
import 'package:soru_defteri/UI/AddQuest/QuestDiff.dart';

class FirstAdd extends StatefulWidget {
  @override
  _FirstAddState createState() => _FirstAddState();
}

class _FirstAddState extends State<FirstAdd> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("FirstAdd", true);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
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
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 10,
                ),
                Image.asset(
                  "assets/images/addQuest.png",
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/20),
                  child: Text(
                    "Sorularınızı yüklemeye şimdi başlayın",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.width/15),textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width/4),
                  child: Text(
                      "Sorularınızı 3 aşamada yükleyebilirsiniz. Çekeceğiniz fotoğrafın kalitesine dikkat etmeyi unutmayın.",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),textAlign: TextAlign.center,),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 25,
                ),
                Container(
                  height: 45.0,
                  child: FlatButton(
                    onPressed: () =>Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SoruZorluk())),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                      color: Color(0xFF00AE87),
                          borderRadius: BorderRadius.circular(45.0)
                      ),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.3, minHeight: 45.0),
                        alignment: Alignment.center,
                        child: Text(
                          "BAŞLAYALIM!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,fontSize: 18
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
      ),
    );
  }
}
