import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign2.dart';
import 'package:soru_defteri/UI/Sign/GizlilikP.dart';
import 'package:soru_defteri/UI/Sign/KullanimK.dart';

class SignInExtraInfo extends StatefulWidget {
  @override
  _SignInExtraInfoState createState() => _SignInExtraInfoState();
}

class _SignInExtraInfoState extends State<SignInExtraInfo> {
  List chooseClassList = ["9. Sınıf", "11. Sınıf", "12. Sınıf", "Mezun"];
  List chooseClassBoolList = List.generate(4, (index) => false);
  String choosedClass = "9. Sınıf";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chooseClassBoolList[0]=true;
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
                    "Aşağıdaki listeden kaça gittiğini seçmelisin",
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
                  itemCount: chooseClassList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          chooseClassBoolList.fillRange(0, 4, false);
                          if (!chooseClassBoolList[index]) {
                            chooseClassBoolList[index] =
                                !chooseClassBoolList[index];
                          }
                          choosedClass=chooseClassList[index];
                          print(chooseClassList[index]);
                        });
                      },
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            chooseClassList[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        trailing: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: chooseClassBoolList[index]
                                  ? Colors.white
                                  : Color(0xFF9598B7)),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: chooseClassBoolList[index]
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

                        Container(
                          height: 45.0,
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInExtraInfo2(sinif: choosedClass,)));
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
                        ),SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40.0),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Devam ederek ',
                              style: TextStyle(fontSize: 12, color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: "Kullanım Koşulları",
                                    recognizer: TapGestureRecognizer()..onTap=()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>KullanimK())),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 12)),
                                TextSpan(
                                    text: " 'nı ve ",
                                    style: TextStyle(fontSize: 12)),
                                TextSpan(
                                    text: "Gizlilik Politikası",
                                    recognizer: TapGestureRecognizer()..onTap=()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>GizlilikP())),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue,
                                        fontSize: 12)),
                                TextSpan(
                                    text: " 'nı kabul etmiş olursunuz. ",
                                    style: TextStyle(fontSize: 12)),
                              ],
                            ),
                          ),
                        ),SizedBox(
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
