import 'package:flutter/material.dart';

class PremiumOldu extends StatefulWidget {
  @override
  _PremiumOlduState createState() => _PremiumOlduState();
}

class _PremiumOlduState extends State<PremiumOldu> {
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
            title: Text("Krediler"),
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
                        "Tebrikler Premium Üyesiniz",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Image.asset(
                        "assets/images/signIn.png",
                        scale: 5,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Text(
                        "Premium Üyelik ile,\nistediğin kadar soruyu,\nreklamlar olmadan yükleyebilir,\nkesintisiz Soru Defteri deneyimi\nyaşayabilirsin!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xff65BEAF),
                            fontSize: 20),
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
}
