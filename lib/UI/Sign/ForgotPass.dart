import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  @override
  _ForgotPassState createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

  GlobalKey<ScaffoldState> _scaffoldKey=GlobalKey<ScaffoldState>();

  TextEditingController emailEdit=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6E719B),

      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Color(0xFF6E719B),
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
                      Text(
                        "Şifremi Unuttum",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Image.asset(
                        "assets/images/signIn.png",
                        scale: 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Text(
                        "ŞİFRENİZİ UNUTTUNUZ MU?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 50,
                      ),
                      Text(
                        "Panik yok, e-posta adresinize şifre sıfırlama\niletisi gönderelim",textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15, bottom: 3),
                            child: Text(
                              "E-Posta",
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
                              child: TextField(
                                controller: emailEdit,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            )),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right:15.0),
                          child: Container(
                            height: 45.0,
                            child: FlatButton(
                              onPressed: () => gonder(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45.0)),
                              padding: EdgeInsets.all(0.0),
                              child: Ink(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF00AE87), Color(0xFF00AE87)],
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
                                    "ŞİFREMİ SIFIRLA",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: Colors.white, fontSize: 18),
                                  ),
                                ),
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
        ),
      ),
    );
  }

  gonder()async{
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailEdit.text.trim());
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text("E-Postanıza şifre sıfırlama maili gönderildi.")));
    } on Exception catch (e) {
      print(e.toString());
      String error;
      if(e.toString()=="[firebase_auth/missing-email] An email address must be provided."){
        error="E-Postanızı giriniz.";
      }else if(e.toString()=="The email address is badly formatted."){
        error="E-Postanızı doğru girdiğinizden emin olunuz.(Boşluk bırakmamaya özen geösteriniz)";
      }else if(e.toString()=="[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted."){
        error="Böyle bir kullanıcı bulunamadı.";
      } else{
        error=e.toString();
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(error)));
    }
  }
}
