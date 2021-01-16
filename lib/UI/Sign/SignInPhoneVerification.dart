import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/Sign/ExtraInfoSign.dart';
import 'package:soru_defteri/UI/Sign/SignInDone.dart';

class SignInPhoneVerification extends StatefulWidget {
  String phoneNum;

  SignInPhoneVerification({Key key, this.phoneNum}) : super(key: key);

  @override
  _SignInPhoneVerificationState createState() =>
      _SignInPhoneVerificationState();
}

class _SignInPhoneVerificationState extends State<SignInPhoneVerification> {
  TextEditingController first = TextEditingController();
  TextEditingController second = TextEditingController();
  TextEditingController third = TextEditingController();
  TextEditingController fourth = TextEditingController();
  TextEditingController fifth = TextEditingController();
  TextEditingController sixth = TextEditingController();
  int smsCode;
  var verificationCode;
  FirebaseAuth _auth = FirebaseAuth.instance;
  int cntDwn = 120;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startSync();
  }

  startSync() async {
    Timer _timer = new Timer.periodic(
      Duration(seconds: 1),
      (Timer timer) {
        if (cntDwn == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            cntDwn--;
          });
        }
      },
    );
    phoneSignIn();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
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
                    "Telefon ile Oturum Aç",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 10,
                  ),
                  Text(
                    "MOBİL DOĞRULAMA",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color(0XFFFF7E00),
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 60,
                  ),
                  Text(
                    "SMS ile gelen kodu gir",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text(
                      "Sana gönderdiğimiz 6 haneli kodu gir ${widget.phoneNum}. Lütfen doğru numarayı girdiğinizden emin olun.",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                14),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                    ),
                                    onChanged: (s) {
                                      if (s.length >= 1) {
                                        node.nextFocus();
                                      }
                                    },
                                    onSubmitted: (s) => node.nextFocus(),
                                    textInputAction: TextInputAction.next,
                                    controller: first,
                                    maxLengthEnforced: true,
                                    keyboardType: TextInputType.number)),
                          )),
                      Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                14),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                    ),
                                    onChanged: (s) {
                                      if (s.length >= 1) {
                                        node.nextFocus();
                                      } else if (s.length == 0) {
                                        node.previousFocus();
                                      }
                                    },
                                    onSubmitted: (s) => node.nextFocus(),
                                    textInputAction: TextInputAction.next,
                                    controller: second,
                                    keyboardType: TextInputType.number)),
                          )),
                      Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                14),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                    ),
                                    onChanged: (s) {
                                      if (s.length >= 1) {
                                        node.nextFocus();
                                      } else if (s.length == 0) {
                                        node.previousFocus();
                                      }
                                    },
                                    onSubmitted: (s) => node.nextFocus(),
                                    textInputAction: TextInputAction.next,
                                    controller: third,
                                    keyboardType: TextInputType.number)),
                          )),
                      Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                14),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                    ),
                                    onChanged: (s) {
                                      if (s.length >= 1) {
                                        node.nextFocus();
                                      } else if (s.length == 0) {
                                        node.previousFocus();
                                      }
                                    },
                                    onSubmitted: (s) => node.nextFocus(),
                                    textInputAction: TextInputAction.next,
                                    controller: fourth,
                                    keyboardType: TextInputType.number)),
                          )),
                      Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                                    textAlignVertical: TextAlignVertical.top,
                                    textAlign: TextAlign.center,
                                    maxLength: 1,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                14),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                      counterStyle: TextStyle(
                                        height: double.minPositive,
                                      ),
                                      counterText: "",
                                    ),
                                    onChanged: (s) {
                                      if (s.length >= 1) {
                                        node.nextFocus();
                                      } else if (s.length == 0) {
                                        node.previousFocus();
                                      }
                                    },
                                    onSubmitted: (s) => node.nextFocus(),
                                    textInputAction: TextInputAction.next,
                                    controller: fifth,
                                    keyboardType: TextInputType.number)),
                          )),
                      Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6.5,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                                child: TextField(
                              textAlignVertical: TextAlignVertical.top,
                              textAlign: TextAlign.center,
                              maxLength: 1,
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.width / 14),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                                counterStyle: TextStyle(
                                  height: double.minPositive,
                                ),
                                counterText: "",
                              ),
                              onChanged: (s) {
                                if (s.length == 0) {
                                  node.previousFocus();
                                }
                                if (s.length >= 1) {
                                  node.unfocus();
                                }
                              },
                              onSubmitted: (s) => node.nextFocus(),
                              textInputAction: TextInputAction.next,
                              controller: sixth,
                              keyboardType: TextInputType.number,
                            )),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  cntDwn != 0
                      ? Text(
                          "${cntDwn.toString()} saniye içinde kodu yeniden al.",
                          style: TextStyle(color: Colors.white),
                        )
                      : Container(
                          height: 45.0,
                          child: FlatButton(
                            onPressed: () => resendCode(),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45.0)),
                            padding: EdgeInsets.all(0.0),
                            child: Ink(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF00AD88),
                                      Color(0xFF6D5EFF)
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: BorderRadius.circular(45.0)),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width / 2.3,
                                    minHeight: 45.0),
                                alignment: Alignment.center,
                                child: Text(
                                  "YENİDEN GÖNDER",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ),
                          ),
                        ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Container(
                    height: 45.0,
                    child: FlatButton(
                      onPressed: smsCode != null
                          ? () {
                              AuthCredential _credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: verificationCode,
                                      smsCode: first.text +
                                          second.text +
                                          third.text +
                                          fourth.text);
                              _auth
                                  .signInWithCredential(_credential)
                                  .then((UserCredential result) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignInExtraInfo()));
                              }).catchError((e) {
                                print(e);
                              });
                            }
                          : () => null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(45.0)),
                      padding: EdgeInsets.all(0.0),
                      child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF00AD88), Color(0xFF6D5EFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(45.0)),
                        child: Container(
                          constraints: BoxConstraints(
                              maxWidth: MediaQuery.of(context).size.width / 2.3,
                              minHeight: 45.0),
                          alignment: Alignment.center,
                          child: Text(
                            "DOĞRULA",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ),
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

  phoneSignIn() async {
    setState(() {
      cntDwn=120;
    });
    _auth.verifyPhoneNumber(
        phoneNumber: widget.phoneNum,
        timeout: Duration(seconds: 120),
        verificationCompleted: (credential) {
          setState(() {
            first.text = credential.smsCode.substring(0).toString();
            second.text = credential.smsCode.substring(1).toString();
            third.text = credential.smsCode.substring(2).toString();
            fourth.text = credential.smsCode.substring(3).toString();
            fifth.text = credential.smsCode.substring(4).toString();
            sixth.text = credential.smsCode.substring(5).toString();
          });
          _auth
              .signInWithCredential(credential)
              .then((UserCredential result) async {
            final User user = _auth.currentUser;
            if (user != null) {
              assert(!user.isAnonymous);
              assert(await user.getIdToken() != null);

              final User currentUser = _auth.currentUser;
              assert(user.uid == currentUser.uid);

              print('signInWithGoogle succeeded: $user');

              Map<String, dynamic> userData = Map();
              if (result.additionalUserInfo.isNewUser) {
                userData["phone"] = user.phoneNumber;
              }

              if (!kIsWeb) {
                String fcmToken = await FirebaseMessaging().getToken();
                userData["fcmToken"] = fcmToken;
              }

              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(user.uid)
                  .set(userData, SetOptions(merge: true));

              bool bilgiVar;
              await FirebaseFirestore.instance
                  .collection("Users")
                  .doc(user.uid)
                  .get()
                  .then((doc) {
                if (doc.data().containsKey("alan")) {
                  bilgiVar = true;
                } else {
                  bilgiVar = false;
                }
              });

              if (result.additionalUserInfo.isNewUser || !bilgiVar) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInExtraInfo()));
              } else {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => SignInDone()));
              }
            }

            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => SignInExtraInfo()));
          }).catchError((e) {
            print(e);
          });
        },
        verificationFailed: (FirebaseAuthException authException) {
          print(authException);

        },
        codeSent: (verificationID, [int forceResendingToken]) {
          setState(() {
            smsCode = int.parse(first.text +
                second.text +
                third.text +
                fourth.text +
                fifth.text +
                sixth.text);
            verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) {
          print("timeout");
        });
  }

  resendCode() {
    phoneSignIn();
  }
}
