import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soru_defteri/UI/FullImage.dart';

class SoruCoz extends StatefulWidget {
  DocumentSnapshot doc;
  List<DocumentSnapshot> docList;
  bool shuffle;

  SoruCoz({Key key, @required this.doc, @required this.docList, this.shuffle})
      : super(key: key);

  @override
  _SoruCozState createState() => _SoruCozState();
}

class _SoruCozState extends State<SoruCoz> {
  DocumentSnapshot currentDoc;
  bool cozumGoster = false;
  bool ipucuGoster = false;
  int initialIndex;
  final ImagePicker _picker = ImagePicker();
  User user = FirebaseAuth.instance.currentUser;
  List mottos=["Bugün içinde bulunduğunuz mücadele, yarın ihtiyacınız olan gücü geliştiriyor."

  ,"Zor Sınavlar güçlü insanlar yetiştirir."

  ,"Her şey sizin aksinize ilerliyor gibi geldiğinde uçakların rüzgarla birlikte değil rüzgara karşı uçtuğunu hatırlayın."

  ,"Bugün sahip oldukların için teşekkür et ve yarın sahip olacakların için savaşmaya başla."

  ,"Hayat her ne kadar zor görünse de, yapabileceğiniz ve başarabileceğiniz bir şey her zaman vardır."

  ,"Dünyayı değiştirebilen insanlar buna inanacak kadar deli olanlardır."

  ,"Kendini fetheden bir adam, savaşta bin kişiyi fetheden birinden daha büyüktür"

  ,"Coşku, zekadan daha önemlidir."

  ,"İş etiği ve tutku ikilisinin, yapamayacağı hiçbir şey yoktur."

  ,"Yedi kez düş, sekiz kez ayağa kalk."

  ,"Unutma: Her şampiyon bir zamanlar pes etmeyi reddeden bir yarışmacıydı."

  ,"Geçmiş ne kadar zor olursa olsun, her zaman yeniden başlayabilirsiniz."

  ,"Kendinizi kıyaslamak zorunda olduğunuz tek kişi geçmişteki sizsiniz."
  ];

  ScrollController scrollController = ScrollController();
  String myMotto;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentDoc = widget.doc;
      initialIndex =
          widget.docList.indexWhere((element) => element.id == widget.doc.id)
              .toInt();
      myMotto=mottos[Random().nextInt(mottos.length)];
      //widget.docList.removeAt(initialIndex);
      //widget.docList.insert(0, currentDoc);
    });
    startSync();
  }

  startSync() async {
    tekrarYap();
  }

  tekrarYap() async {
    if (widget.shuffle!=true) {
    int tekrarNum;
    await FirebaseFirestore.instance.collection("Sorular")
        .doc(currentDoc.id)
        .get()
        .then((doc) {
      if (doc.data().containsKey("tekrarNum")) {
        tekrarNum = doc["tekrarNum"];
      } else {
        tekrarNum = 0;
      }
    });
    print(widget.shuffle);

      if (tekrarNum == 0) {
        print("tkrar 1 oldu");
        await FirebaseFirestore.instance.collection("Sorular").doc(
            currentDoc.id).set({
          "tekrar": true,
          "tekrarTime": DateTime.now(),
          "tekrarYapilacak": DateTime.now().add(Duration(days: 1)),
          "tekrarNum": tekrarNum + 1
        }, SetOptions(merge: true));
      } else if (tekrarNum == 1) {
        print("tkrar 2 oldu");
        await FirebaseFirestore.instance.collection("Sorular").doc(
            currentDoc.id).set({
          "tekrar": true,
          "tekrarTime": DateTime.now(),
          "tekrarYapilacak": DateTime.now().add(Duration(days: 6)),
          "tekrarNum": tekrarNum + 1
        }, SetOptions(merge: true));
      } else if (tekrarNum == 2) {
        print("tkrar 3 oldu");
        await FirebaseFirestore.instance.collection("Sorular").doc(
            currentDoc.id).set({
          "tekrar": true,
          "tekrarTime": DateTime.now(),
          "tekrarYapilacak": DateTime.now().add(Duration(days: 22)),
          "tekrarNum": tekrarNum + 1
        }, SetOptions(merge: true));
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    precacheImage(Image
        .asset("assets/images/camIcon.png")
        .image, context);
    precacheImage(Image
        .asset("assets/images/chooseClass.png")
        .image, context);
    precacheImage(Image
        .asset("assets/images/chooseMatter.png")
        .image, context);
    precacheImage(Image
        .asset("assets/images/chooseQuestion.png")
        .image, context);
    precacheImage(Image
        .asset("assets/images/chooseSolution.png")
        .image, context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Color(0xFF6453F6),
            title: Text("Soru Çözümü"),
          ),
          body: Container(
            decoration: BoxDecoration(
                color: Color(0xFF616798),
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(
                        MediaQuery
                            .of(context)
                            .size
                            .width / 10))),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 10)),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF4F44DA), Color(0xFF8181A2)],
                            stops: [0.5, 1])),
                    child: Center(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("Sorular")
                            .doc(currentDoc.id)
                            .snapshots(),
                        builder: (context, AsyncSnapshot<
                            DocumentSnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator(),);
                          } else {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(snapshot.data["ders"]
                                    .toString()
                                    .toUpperCase(),
                                    style: TextStyle(
                                      color: Color(0xFF41C6FF),
                                      fontSize: 20,
                                    )),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  snapshot.data["konu"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  width: 50,
                                  height: 3,
                                  color: Color(0xFF41C6FF),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 10),
                                  child: Text(
                                    myMotto,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          snapshot.data.data().containsKey(
                                              "liked") &&
                                              snapshot.data["liked"].contains(
                                                  user.uid)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          color: Color(0xFFFF007F),
                                          size: 30,
                                        ),
                                        onPressed: () async {
                                          if (snapshot.data.data().containsKey(
                                              "liked") &&
                                              snapshot.data["liked"].contains(
                                                  user.uid)) {
                                            List newLiked = [];
                                            newLiked = snapshot.data["liked"];
                                            newLiked.remove(user.uid);
                                            await FirebaseFirestore.instance
                                                .collection("Sorular").doc(
                                                snapshot.data.id).set(
                                                {"liked": newLiked},
                                                SetOptions(merge: true));
                                            print("ok");
                                          } else {
                                            List newLiked = [];
                                            if (snapshot.data.data()
                                                .containsKey(
                                                "liked")) {
                                              newLiked = snapshot.data["liked"];
                                            }
                                            newLiked.add(user.uid);
                                            await FirebaseFirestore.instance
                                                .collection("Sorular").doc(
                                                snapshot.data.id).set(
                                                {"liked": newLiked},
                                                SetOptions(merge: true));
                                            print("okk");
                                          }
                                        },
                                      ),
                                      Text(DateFormat.MMMd('tr_TR').format(
                                          snapshot.data["date"].toDate()),
                                        style: TextStyle(color: Colors.white,
                                            fontWeight: FontWeight.bold),),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 3,),
                                CarouselSlider(
                                    options: CarouselOptions(
                                      initialPage: initialIndex,
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 2,
                                      enlargeCenterPage: true,
                                      enableInfiniteScroll: false,
                                      onPageChanged: (index, reason) async {
                                        setState(() {
                                          currentDoc = widget.docList[index];
                                          cozumGoster = false;
                                          ipucuGoster = false;
                                          tekrarYap();
                                        });
                                        if (widget.shuffle!=true) {
                                          await FirebaseFirestore.instance
                                              .collection("Sorular").doc(
                                              currentDoc.id).set({
                                            "tekrarTime": DateTime.now(),
                                            "tekrar": true
                                          }, SetOptions(merge: true));
                                        }
                                      },),
                                    items: widget.docList.map((e) {
                                      return e.id == currentDoc.id
                                          ? !ipucuGoster
                                          ? Container(
                                          child: Stack(
                                            fit: StackFit.expand,
                                            alignment: Alignment.bottomLeft,
                                            children: [
                                              Hero(
                                                tag: e.id == currentDoc.id
                                                    ? cozumGoster
                                                    ? e["cozumFotos"][0]
                                                    : e["soruFotos"][0]
                                                    : e["soruFotos"][0],
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(15)),
                                                    child: CachedNetworkImage(
                                                      imageUrl: e.id ==
                                                          currentDoc.id
                                                          ? cozumGoster
                                                          ? e["cozumFotos"][0]
                                                          : e["soruFotos"][0]
                                                          : e["soruFotos"][0],
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: IconButton(icon: Icon(
                                                    Icons.zoom_in,
                                                    color: Color(0xFF6453F6),
                                                    size: 40,), onPressed: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (
                                                                context) =>
                                                                ImageFull(
                                                                    e.id ==
                                                                        currentDoc
                                                                            .id
                                                                        ? cozumGoster
                                                                        ? e["cozumFotos"][0]
                                                                        : e["soruFotos"][0]
                                                                        : e["soruFotos"][0])));
                                                  },),
                                                ),
                                              )

                                            ],
                                          ))
                                          :

                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Container(
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.white,
                                                  Color(0xFFCDCEDC)
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter),
                                          ),
                                          child: Scrollbar(
                                            isAlwaysShown: true,
                                            controller: scrollController,
                                            child: SingleChildScrollView(
                                              controller: scrollController,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .all(
                                                        8.0),
                                                    child: Text(snapshot
                                                        .data["ipucu"]),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                          :

                                      ClipRRect(borderRadius: BorderRadius.all(
                                          Radius.circular(15)),
                                          child: CachedNetworkImage(
                                            imageUrl: e["soruFotos"][0],
                                            fit: BoxFit.cover,));
                                    }).toList()
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  mainAxisSize: MainAxisSize
                                      .min,
                                  children: [
                                    !cozumGoster ?
                                    GestureDetector(
                                      onTap: snapshot.data.data().containsKey(
                                          "cozumFotos") &&
                                          snapshot.data["cozumFotos"] is List &&
                                          snapshot.data["cozumFotos"] != null &&
                                          snapshot.data["cozumFotos"][0] != null
                                          ? () {
                                        setState(() {
                                          cozumGoster = !cozumGoster;
                                          ipucuGoster = false;
                                        });
                                      }
                                          : () {
                                        solutChoose(snapshot.data.id);
                                      },
                                      child: Container(
                                          width: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .width /
                                              2.5,
                                          height: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .height /
                                              10,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color(
                                                        0xFF6E719A),
                                                    Color(
                                                        0xFF5F6397)
                                                  ],
                                                  begin: Alignment
                                                      .topCenter,
                                                  end: Alignment
                                                      .bottomCenter),
                                              borderRadius: BorderRadius
                                                  .only(
                                                  topLeft: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  topRight: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  bottomLeft: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  bottomRight: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          40))),
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize
                                                  .min,
                                              children: [
                                                Image
                                                    .asset(
                                                    "assets/images/chooseSolution.png",
                                                    scale: 10),
                                                Text(
                                                    "Çözümü\nGöster",
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white))

                                              ],),
                                          )),
                                    ) :
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          cozumGoster = !cozumGoster;
                                          ipucuGoster = false;
                                        });
                                      },
                                      child: Container(
                                          width: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .width /
                                              2.5,
                                          height: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .height /
                                              10,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color(
                                                        0xFF6E709B),
                                                    Color(
                                                        0xFF6E6BC4)
                                                  ],
                                                  begin: Alignment
                                                      .topCenter,
                                                  end: Alignment
                                                      .bottomCenter),
                                              borderRadius: BorderRadius
                                                  .only(
                                                  topLeft: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  topRight: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  bottomLeft: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  bottomRight: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          40))),
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize
                                                  .min,
                                              children: [
                                                Image
                                                    .asset(
                                                    "assets/images/chooseQuestion.png",
                                                    scale: 10),
                                                Text(
                                                    "Soruyu\nGöster",
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white))

                                              ],),
                                          )),
                                    ),

                                    SizedBox(
                                        width: MediaQuery
                                            .of(
                                            context)
                                            .size
                                            .width /
                                            90),

                                    !ipucuGoster ?
                                    GestureDetector(
                                      onTap: snapshot.data.data().containsKey(
                                          "ipucu") &&
                                          snapshot.data["ipucu"] is String &&
                                          snapshot.data["ipucu"] != null &&
                                          snapshot.data["ipucu"] != "" ? () {
                                        setState(() {
                                          ipucuGoster = !ipucuGoster;
                                          cozumGoster = false;
                                        });
                                      } : () {
                                        solutTipType(snapshot.data);
                                      },
                                      child: Container(
                                          width: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .width /
                                              2.5,
                                          height: MediaQuery
                                              .of(
                                              context)
                                              .size
                                              .height /
                                              10,
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Color(
                                                        0xFF00AD88),
                                                    Color(
                                                        0xFF6453F6)
                                                  ],
                                                  begin: Alignment
                                                      .topCenter,
                                                  end: Alignment
                                                      .bottomCenter),
                                              borderRadius: BorderRadius
                                                  .only(
                                                  topLeft: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  topRight: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20),
                                                  bottomLeft: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          40),
                                                  bottomRight: Radius
                                                      .circular(
                                                      MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .width /
                                                          20))),
                                          child: Center(
                                            child: Column(
                                              mainAxisSize: MainAxisSize
                                                  .min,
                                              children: [
                                                Image
                                                    .asset(
                                                    "assets/images/cozumYukle.png",
                                                    scale: 10),
                                                Text(
                                                    "İpucunu\nGöster",
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white))
                                              ],),
                                          )),
                                    ) :
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          ipucuGoster = !ipucuGoster;
                                          cozumGoster = false;
                                        });
                                      },
                                      child: Container(
                                        width: MediaQuery
                                            .of(
                                            context)
                                            .size
                                            .width /
                                            2.5,
                                        height: MediaQuery
                                            .of(
                                            context)
                                            .size
                                            .height /
                                            10,
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                                colors: [
                                                  Color(
                                                      0xFF6E709B),
                                                  Color(
                                                      0xFF6E6BC4)
                                                ],
                                                begin: Alignment
                                                    .topCenter,
                                                end: Alignment
                                                    .bottomCenter),
                                            borderRadius: BorderRadius
                                                .only(
                                                topLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width /
                                                        20),
                                                topRight: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width /
                                                        20),
                                                bottomLeft: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width /
                                                        40),
                                                bottomRight: Radius
                                                    .circular(
                                                    MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .width /
                                                        20))),
                                        child: Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize
                                                .min,
                                            children: [
                                              Image
                                                  .asset(
                                                  "assets/images/chooseQuestion.png",
                                                  scale: 10),
                                              Text(
                                                  "Soruyu\nGöster",
                                                  textAlign: TextAlign
                                                      .center,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .white))

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  solutChoose(String id) async {
    bool load = false;
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) {
                return Container(
                  color: Color(0xFF6453F6),
                  child: Stack(
                    children: [
                      Scaffold(
                        extendBodyBehindAppBar: true,
                        backgroundColor: Color(0xFF6453F6),
                        appBar: AppBar(
                          title: Text("Çözüm Yükle"),
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        body: Center(
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 16),
                                  child: Container(height: MediaQuery
                                      .of(context)
                                      .size
                                      .height / 3.5,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width / 1.6,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15)),
                                          color: Colors.white),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(height: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 16,),
                                          Text("Çözüm Fotoğrafını Çek",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF6453F6))),
                                          SizedBox(height: MediaQuery
                                              .of(context)
                                              .size
                                              .height / 60),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Text(
                                              "Bulanık çözümleri daha sonra okuyamayacağını unutmamalısın.",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xFF999CB9)),
                                              textAlign: TextAlign.center,),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: FlatButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(10))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                                minWidth: MediaQuery
                                                    .of(context)
                                                    .size
                                                    .height / 30,
                                                color: Color(0xFF00AE87),
                                                child: Text(
                                                    "BAŞLA"),
                                                onPressed: () async {
                                                  //TODO CAMERA OLARAK DEĞİŞTİR SOURCE

                                                  if (await Permission.camera
                                                      .isGranted) {} else {
                                                    await Permission.camera
                                                        .request();
                                                  }
                                                  final pickedFile =
                                                  await _picker.getImage(
                                                      source: ImageSource
                                                          .camera);
                                                  File finalImage = await ImageCropper
                                                      .cropImage(
                                                      sourcePath: File(
                                                          pickedFile.path)
                                                          .path,
                                                      aspectRatioPresets: Platform
                                                          .isAndroid
                                                          ? [
                                                        CropAspectRatioPreset
                                                            .square,
                                                        CropAspectRatioPreset
                                                            .ratio3x2,
                                                        CropAspectRatioPreset
                                                            .original,
                                                        CropAspectRatioPreset
                                                            .ratio4x3,
                                                        CropAspectRatioPreset
                                                            .ratio16x9
                                                      ]
                                                          : [
                                                        CropAspectRatioPreset
                                                            .original,
                                                        CropAspectRatioPreset
                                                            .square,
                                                        CropAspectRatioPreset
                                                            .ratio3x2,
                                                        CropAspectRatioPreset
                                                            .ratio4x3,
                                                        CropAspectRatioPreset
                                                            .ratio5x3,
                                                        CropAspectRatioPreset
                                                            .ratio5x4,
                                                        CropAspectRatioPreset
                                                            .ratio7x5,
                                                        CropAspectRatioPreset
                                                            .ratio16x9
                                                      ],
                                                      androidUiSettings: AndroidUiSettings(
                                                          toolbarTitle: 'Görseli Kırp',
                                                          toolbarColor: Colors
                                                              .black,
                                                          toolbarWidgetColor: Colors
                                                              .white,
                                                          initAspectRatio: CropAspectRatioPreset
                                                              .original,
                                                          lockAspectRatio: false),
                                                      iosUiSettings: IOSUiSettings(
                                                        title: 'Görseli Kırp',
                                                      ));
                                                  setState(() {
                                                    load = true;
                                                  });
                                                  String downloadURL;
                                                  try {
                                                    File pimage = finalImage !=
                                                        null
                                                        ? finalImage
                                                        : File(pickedFile.path);
                                                    UploadTask uploadTask = FirebaseStorage
                                                        .instance
                                                        .ref()
                                                        .child("Sorular")
                                                        .child(id)
                                                        .child("cozumFoto")
                                                        .child("foto")
                                                        .putFile(pimage);
                                                    final StreamSubscription streamSubscription =
                                                    uploadTask.snapshotEvents
                                                        .listen((event) {
                                                      print(
                                                          "stream subs çalışıyor.");
                                                    });
                                                    streamSubscription.cancel();
                                                    String docUrl = await (await uploadTask)
                                                        .ref.getDownloadURL();
                                                    downloadURL = docUrl;
                                                    //firestorea yazdır
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("Sorular")
                                                        .doc(
                                                        id)
                                                        .set(
                                                        {
                                                          "cozumFotos": [
                                                            downloadURL
                                                          ]
                                                        },
                                                        SetOptions(
                                                            merge: true));
                                                    setState(() {});
                                                    await Future.delayed(
                                                        Duration(
                                                            milliseconds: 200));
                                                    Navigator.pop(context);
                                                  } on Exception catch (e) {
                                                    print(e.toString());
                                                  }
                                                  setState(() {
                                                    load = false;
                                                  });
                                                },),
                                            ),
                                          )
                                        ],)),
                                ),
                                Container(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 8,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width / 4,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle, color: Color(
                                            0xFF6453F6),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Image.asset(
                                              "assets/images/camIcon.png"),
                                        ),),
                                    )),
                              ],
                            )
                        ),
                      ),
                      load
                          ? Container(color: Colors.black12,
                        child: Center(child: CircularProgressIndicator(),),)
                          : Container()
                    ],
                  ),
                );
              }
          );
        });
  }

  solutTipType(DocumentSnapshot doc) async {
    TextEditingController ipucuEdit = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            title: Text("İpucu Yaz"),
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          body: StatefulBuilder(
            builder: (context, setState) {
              return Padding(
                padding: EdgeInsets.only(
                    top: AppBar().preferredSize.height + 20),
                child: Container(width: double.maxFinite,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(MediaQuery
                        .of(context)
                        .size
                        .width / 10)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF302DB2),
                        Color(0xFF6453F6)
                      ],
                      stops: [
                        0.2,
                        0.7
                      ],),),
                  child: SingleChildScrollView(
                    child: Column(children: [
                      SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 50),
                      Text("İpucu Önemlidir.", textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF00AE87),
                              fontSize: 20)),
                      SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 60),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            "Eklediğin ipucu soruyu çözerken size büyük\nkolaylık sağlayacak..",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(
                                MediaQuery
                                    .of(context)
                                    .size
                                    .width / 30)), color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: TextField(minLines: 10,
                                    maxLines: 10,
                                    maxLength: 200,
                                    controller: ipucuEdit,
                                    onChanged: (s) {
                                      setState(() {

                                      });
                                    },
                                    decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,)),
                              ),
                            )),
                      ),
                      SizedBox(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height / 40),
                      Container(
                        height: 45.0,
                        child: FlatButton(
                          onPressed: () async {
                            await FirebaseFirestore.instance.collection(
                                "Sorular").doc(doc.id).set(
                                {"ipucu": ipucuEdit.text.trim()},
                                SetOptions(merge: true));
                            Navigator.pop(context);
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
                                  maxWidth: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2.3,
                                  minHeight: 45.0),
                              alignment: Alignment.center,
                              child: Text(
                                "KAYDET",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: MediaQuery
                          .of(context)
                          .size
                          .height / 50,),
                      Text(doc.data().containsKey("ipucu") &&
                          doc["ipucu"] == ipucuEdit.text
                          ? "Kaydedildi"
                          : "Kaydedilmedi",style: TextStyle(color: Colors.white),),
                    ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

}
