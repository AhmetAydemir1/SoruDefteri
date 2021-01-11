import 'package:flutter/material.dart';

class SignInPhoneVerification extends StatefulWidget {
  @override
  _SignInPhoneVerificationState createState() =>
      _SignInPhoneVerificationState();
}

class _SignInPhoneVerificationState extends State<SignInPhoneVerification> {
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
                Text("MOBİL DOĞRULAMA",textAlign: TextAlign.center,style: TextStyle(color: Color(0XFFFF7E00),fontSize: 20,fontWeight: FontWeight.w600),),
                SizedBox(
                  height: MediaQuery.of(context).size.height/60,
                ),
                Text("SMS ile gelen kodu gir",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:30.0),
                  child: Text("Sana gönderdiğimiz 4 haneli kodu gir TELEFON NUMARASI. Lütfen doğru numarayı girdiğinizden emin olun.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white),),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(height: MediaQuery.of(context).size.width/6,width: MediaQuery.of(context).size.width/4.5,child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),child: Center(child: TextField(textAlignVertical: TextAlignVertical.top,textAlign: TextAlign.center,maxLength: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width/14),decoration: InputDecoration(border: InputBorder.none,disabledBorder: InputBorder.none,enabledBorder: InputBorder.none,errorBorder: InputBorder.none,focusedBorder: InputBorder.none,focusedErrorBorder: InputBorder.none,     counterStyle: TextStyle(height: double.minPositive,),counterText: "",),onChanged: (s){if(s.length>=1){node.nextFocus();}},onSubmitted: (s)=>node.nextFocus(),textInputAction: TextInputAction.next,)),)),
                    Container(height: MediaQuery.of(context).size.width/6,width: MediaQuery.of(context).size.width/4.5,child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),child: Center(child: TextField(textAlignVertical: TextAlignVertical.top,textAlign: TextAlign.center,maxLength: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width/14),decoration: InputDecoration(border: InputBorder.none,disabledBorder: InputBorder.none,enabledBorder: InputBorder.none,errorBorder: InputBorder.none,focusedBorder: InputBorder.none,focusedErrorBorder: InputBorder.none,     counterStyle: TextStyle(height: double.minPositive,),counterText: "",),onChanged: (s){if(s.length>=1){node.nextFocus();}else if(s.length==0){node.previousFocus();}},onSubmitted: (s)=>node.nextFocus(),textInputAction: TextInputAction.next,)),)),
                    Container(height: MediaQuery.of(context).size.width/6,width: MediaQuery.of(context).size.width/4.5,child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),child: Center(child: TextField(textAlignVertical: TextAlignVertical.top,textAlign: TextAlign.center,maxLength: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width/14),decoration: InputDecoration(border: InputBorder.none,disabledBorder: InputBorder.none,enabledBorder: InputBorder.none,errorBorder: InputBorder.none,focusedBorder: InputBorder.none,focusedErrorBorder: InputBorder.none,     counterStyle: TextStyle(height: double.minPositive,),counterText: "",),onChanged: (s){if(s.length>=1){node.nextFocus();}else if(s.length==0){node.previousFocus();}},onSubmitted: (s)=>node.nextFocus(),textInputAction: TextInputAction.next,)),)),
                    Container(height: MediaQuery.of(context).size.width/6,width: MediaQuery.of(context).size.width/4.5,child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),child: Center(child: TextField(textAlignVertical: TextAlignVertical.top,textAlign: TextAlign.center,maxLength: 1,style: TextStyle(fontSize: MediaQuery.of(context).size.width/14),decoration: InputDecoration(border: InputBorder.none,disabledBorder: InputBorder.none,enabledBorder: InputBorder.none,errorBorder: InputBorder.none,focusedBorder: InputBorder.none,focusedErrorBorder: InputBorder.none,     counterStyle: TextStyle(height: double.minPositive,),counterText: "",),onChanged: (s){if(s.length==0){node.previousFocus();}},onSubmitted: (s)=>node.nextFocus(),textInputAction: TextInputAction.next,)),)),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Text("10 saniye içinde kodu yeniden al.",style: TextStyle(color: Colors.white),),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 20,
                ),
                Container(
                  height: 45.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPhoneVerification()));
                    },
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
        ],
      ),
    );
  }
}
