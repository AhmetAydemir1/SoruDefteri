import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/UI/Home/Home.dart';
import 'package:soru_defteri/UI/Sign/SignInDone.dart';

class Izinler extends StatefulWidget {
  @override
  _IzinlerState createState() => _IzinlerState();
}

class _IzinlerState extends State<Izinler> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(Image.asset("assets/images/izinler.png").image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(title: Text("İletiyi Al"),backgroundColor: Colors.transparent,shadowColor: Colors.transparent,),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height/10,right: 30,left: 30),
                        child: Text(" Sana yapamadıklarını hatırlatmamız ve gelişmeleri haber verebilmemiz için bildirimlerimize izin vermelisin.",textAlign: TextAlign.center,style: TextStyle(color: Colors.white,),
                      ),),
                      Image.asset("assets/images/izinler.png",fit: BoxFit.fitWidth,)
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Container(
                  height: 45.0,
                  child: FlatButton(
                    onPressed: () async {
                      await Permission.photos.request();
                      await Permission.storage.request();
                      await Permission.camera.request();
                      await Permission.notification.request();
                      SharedPreferences prefs=await SharedPreferences.getInstance();
                      prefs.setBool("firstSign", true);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInDone()));
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Color(0xFF00AE87),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.5,
                            minHeight: 45.0),
                        alignment: Alignment.center,
                        child: Text(
                          "KABUL ET VE DEVAM ET",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
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
    );
  }
}
