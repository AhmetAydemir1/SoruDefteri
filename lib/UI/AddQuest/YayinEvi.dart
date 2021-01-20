import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/AddQuest/BottomNav.dart';

class YayinEvi extends StatefulWidget {
  int zorluk;
  YayinEvi({Key key,@required this.zorluk}):super(key:key);
  @override
  _YayinEviState createState() => _YayinEviState();
}

class _YayinEviState extends State<YayinEvi> {
  List<String> yayinEvleri = [
    "a yayınları",
    "b yayınları",
    "c yayınları",
    "a yayınları",
    "b yayınları",
    "c yayınları",
    "a yayınları",
    "b yayınları",
    "a yayınları",
  ];
  List<bool> boolList;
  String yayinEvi;
  ScrollController _scrollController=ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      boolList = List.filled(yayinEvleri.length, false);
      boolList[0] = true;
      yayinEvi=yayinEvleri[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                "assets/images/splashBG1.png",
                fit: BoxFit.fitHeight,
                alignment: Alignment.centerLeft,
              ),
              Opacity(
                  opacity: 0.6,
                  child: Container(
                    color: Color(0xFF6E719B),
                  )),
              SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: AppBar().preferredSize.height,
                    ),
                    Image.asset(
                      "assets/images/signIn.png",
                      scale: 5,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Yüklemeden önce bir sorumuz daha var.",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 70,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Ekleyeceğin soru hangi yayın evine ait",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 40,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/2.2,
                      child: Scrollbar(
                        controller: _scrollController,
                        isAlwaysShown: true,
                        child: ListView.builder(
                          controller: _scrollController,
                          padding: EdgeInsets.zero,
                          itemCount: yayinEvleri.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                setState(() {
                                  boolList.fillRange(0, yayinEvleri.length, false);
                                  boolList[index] = !boolList[index];
                                  yayinEvi=yayinEvleri[index];
                                  print(yayinEvi);
                                });
                              },
                              title: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(yayinEvleri[index],
                                    style: TextStyle(
                                      color: Colors.white,
                                    )),
                              ),
                              trailing: Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: boolList[index]
                                        ? Colors.white
                                        : Color(0xFF9699B6)),
                                child: boolList[index]
                                    ? Container(
                                        child: Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: Color(0xFF00AE87),
                                      ))
                                    : Container(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    Container(
                      height: 45.0,
                      child: FlatButton(
                        onPressed: () {
                          Navigator.pop(context );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNav(currentIndex: 3,yayinEvi: yayinEvi,zorluk: widget.zorluk,)));
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
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2.3,
                                minHeight: 45.0),
                            alignment: Alignment.center,
                            child: Text(
                              "Sonraki",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
