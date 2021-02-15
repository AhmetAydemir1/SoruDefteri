import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emoji.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class KategoriQuestWall extends StatefulWidget {
  String konu, sinav, ders;

  KategoriQuestWall({
    @required this.sinav,
    @required this.ders,
    @required this.konu,
  });

  @override
  _KategoriQuestWallState createState() => _KategoriQuestWallState();
}

class _KategoriQuestWallState extends State<KategoriQuestWall> {
  List cozumGosterList = [];

  Stream<QuerySnapshot> querySnapshot;

  List<DateTime> pickedDates = [
    DateTime.now().subtract(Duration(days: 10000)),
    DateTime.now()
  ];

  List<bool> boolList;
  ScrollController _scrollController = ScrollController();
  String siralamaString = "Varsayılan";
  List<String> siralamaList = [
    "Varsayılan",
    "Beğeniye Göre",
    "Eskiden Yeniye",
    "Yeniden Eskiye",
    "Zordan Kolaya",
    "Kolaydan Zora"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    boolList = List.filled(siralamaList.length, false);
    boolList[0] = true;
    startSync();
  }

  startSync() async {
    /*await FirebaseFirestore.instance.collection("Sorular").get().then((docs)async{
      for(DocumentSnapshot ds in docs.docs){
        await FirebaseFirestore.instance.collection("Sorular").doc(ds.id).set({"likeSayisi":0},SetOptions(merge:true));
      }
    });*/
    FirebaseFirestore.instance
        .collection("Sorular")
        .where("ders", isEqualTo: widget.ders)
        .where("konu", isEqualTo: widget.konu)
        .where("sinav", isEqualTo: widget.sinav)
        .orderBy("zorluk", descending: true)
        .get()
        .then((docs) {
      for (DocumentSnapshot ds in docs.docs) {
        print(ds.id + ds["likeSayisi"].toString());
      }
    });
    setState(() {
      querySnapshot = FirebaseFirestore.instance
          .collection("Sorular")
          .where("ders", isEqualTo: widget.ders)
          .where("konu", isEqualTo: widget.konu)
          .where("sinav", isEqualTo: widget.sinav)
          /*.where("date",isGreaterThanOrEqualTo: pickedDates[0],)
          .where("date",isLessThanOrEqualTo: pickedDates[1])
          */
          .orderBy("likeSayisi", descending: true)
          .snapshots();
    });
  }

  User user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF6453F6),
        child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: Color(0xFF6453F6),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                title: Text("Soru Duvarı"),
                //toolbarHeight: 80,
                actions: [
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: ImageIcon(
                              AssetImage("assets/images/sirala.png"),
                              size: 25,
                              color: Color(0xff01AA89)),
                          splashRadius: 25,
                          onPressed: () {
                            siralaUp();
                          },
                        ),
                        IconButton(
                          icon: ImageIcon(
                            AssetImage("assets/images/filtrele.png"),
                            size: 25,
                            color: Color(0xff01AA89),
                          ),
                          splashRadius: 25,
                          onPressed: () {
                            tarihSec();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              body: querySnapshot != null
                  ? StreamBuilder(
                      stream: querySnapshot,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView(
                            children: snapshot.data.docs.map((e) {
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Container(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    child: Container(
                                      decoration:
                                          BoxDecoration(gradient: myGradient()),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                GestureDetector(
                                                  onTap: () async {
                                                    await FirebaseFirestore
                                                        .instance
                                                        .collection("Sorular")
                                                        .doc(e.id)
                                                        .get()
                                                        .then((doc) async {
                                                      List liked = [];
                                                      if (doc
                                                          .data()
                                                          .containsKey(
                                                              "liked")) {
                                                        liked = doc["liked"];
                                                        if (doc["liked"]
                                                            .contains(
                                                                user.uid)) {
                                                          liked
                                                              .remove(user.uid);
                                                          int likeSayisi;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Sorular")
                                                              .doc(e.id)
                                                              .get()
                                                              .then((doc) {
                                                            if (doc
                                                                .data()
                                                                .containsKey(
                                                                    "likeSayisi")) {
                                                              likeSayisi = doc[
                                                                  "likeSayisi"];
                                                            } else {
                                                              likeSayisi = 0;
                                                            }
                                                          });
                                                          likeSayisi =
                                                              likeSayisi - 1;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Sorular")
                                                              .doc(e.id)
                                                              .set(
                                                                  {
                                                                "liked": liked,
                                                                "likeSayisi":
                                                                    likeSayisi
                                                              },
                                                                  SetOptions(
                                                                      merge:
                                                                          true));
                                                        } else {
                                                          liked.add(user.uid);
                                                          int likeSayisi;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Sorular")
                                                              .doc(e.id)
                                                              .get()
                                                              .then((doc) {
                                                            if (doc
                                                                .data()
                                                                .containsKey(
                                                                    "likeSayisi")) {
                                                              likeSayisi = doc[
                                                                  "likeSayisi"];
                                                            } else {
                                                              likeSayisi = 0;
                                                            }
                                                          });
                                                          likeSayisi =
                                                              likeSayisi + 1;
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  "Sorular")
                                                              .doc(e.id)
                                                              .set(
                                                                  {
                                                                "liked": liked,
                                                                "likeSayisi":
                                                                    likeSayisi
                                                              },
                                                                  SetOptions(
                                                                      merge:
                                                                          true));
                                                        }
                                                      } else {
                                                        liked.add(user.uid);
                                                        int likeSayisi;
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Sorular")
                                                            .doc(e.id)
                                                            .get()
                                                            .then((doc) {
                                                          if (doc
                                                              .data()
                                                              .containsKey(
                                                                  "likeSayisi")) {
                                                            likeSayisi = doc[
                                                                "likeSayisi"];
                                                          } else {
                                                            likeSayisi = 0;
                                                          }
                                                        });
                                                        likeSayisi =
                                                            likeSayisi + 1;
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                                "Sorular")
                                                            .doc(e.id)
                                                            .set(
                                                                {
                                                              "liked": liked,
                                                              "likeSayisi":
                                                                  likeSayisi
                                                            },
                                                                SetOptions(
                                                                    merge:
                                                                        true));
                                                      }
                                                    });
                                                  },
                                                  child: e.data().containsKey(
                                                              "liked") &&
                                                          e["liked"].contains(
                                                              user.uid)
                                                      ? Icon(
                                                          Icons.favorite,
                                                          color: Colors.white,
                                                          size: 35,
                                                        )
                                                      : Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.white,
                                                          size: 35,
                                                        ),
                                                ),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      e["ders"] +
                                                          " - " +
                                                          e["sinav"],
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF41C6FF)),
                                                    ),
                                                    Text(
                                                      e["konu"],
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 17),
                                                    ),
                                                    Text(
                                                      e["yayinEvi"],
                                                      style: TextStyle(
                                                          color: Color(
                                                              0xFF00AE87)),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 35,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 30.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                30)),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Color(0xFF6453F6),
                                                          Color(0xFF8082A7)
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 3),
                                                    child: Text(
                                                      !cozumGosterList
                                                              .contains(e.id)
                                                          ? "Soru"
                                                          : "Çözüm",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: 20,
                                                  width: 80,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemCount: e["zorluk"],
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Icon(
                                                          Icons.star,
                                                          size: 20,
                                                          color: Colors.yellow,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0, vertical: 4),
                                            child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2.4,
                                                width: double.maxFinite,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20)),
                                                    child: CachedNetworkImage(
                                                      progressIndicatorBuilder:
                                                          (context, url,
                                                              progress) {
                                                        return Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                          value:
                                                              progress.progress,
                                                        ));
                                                      },
                                                      imageUrl: !cozumGosterList
                                                              .contains(e.id)
                                                          ? e["soruFotos"][0]
                                                          : e["cozumFotos"][0],
                                                      fit: BoxFit.cover,
                                                    ))),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16.0, vertical: 4),
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.white,
                                                          Color(0xFFCDCEDC)
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                width: double.maxFinite,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    20)),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(e["ipucu"],
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF6E719B))),
                                                    ))),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 17.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (cozumGosterList
                                                              .contains(e.id)) {
                                                            cozumGosterList
                                                                .remove(e.id);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)),
                                                            color: !cozumGosterList
                                                                    .contains(
                                                                        e.id)
                                                                ? Color(
                                                                    0xFF41C6FF)
                                                                : Color(
                                                                    0xFFA3A6BF)),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 3),
                                                          child: Text(
                                                            "Soru",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w300,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    e.data().containsKey(
                                                                "cozumFotos") &&
                                                            e["cozumFotos"]
                                                                .isNotEmpty
                                                        ? SizedBox(
                                                            width: 2,
                                                          )
                                                        : Container(),
                                                    e.data().containsKey(
                                                                "cozumFotos") &&
                                                            e["cozumFotos"]
                                                                .isNotEmpty
                                                        ? GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                if (!cozumGosterList
                                                                    .contains(
                                                                        e.id)) {
                                                                  cozumGosterList
                                                                      .add(
                                                                          e.id);
                                                                }
                                                              });
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              30)),
                                                                  color: !cozumGosterList
                                                                          .contains(e
                                                                              .id)
                                                                      ? Color(
                                                                          0xFFA3A6BF)
                                                                      : Color(
                                                                          0xFF41C6FF)),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            10,
                                                                        vertical:
                                                                            3),
                                                                child: Text(
                                                                  "Çözüm",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => emojiBirak(
                                                          e.id, "smiling"),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            e.data().containsKey(
                                                                        "smiling") &&
                                                                    e["smiling"] !=
                                                                        null
                                                                ? e["smiling"]
                                                                    .length
                                                                    .toString()
                                                                : "0",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                            Emoji.byName(
                                                                    "smiling face with smiling eyes")
                                                                .toString(),
                                                            style: TextStyle(
                                                                fontSize: 30),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => emojiBirak(
                                                          e.id, "grinning"),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            e.data().containsKey(
                                                                        "grinning") &&
                                                                    e["grinning"] !=
                                                                        null
                                                                ? e["grinning"]
                                                                    .length
                                                                    .toString()
                                                                : "0",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              Emoji.byName(
                                                                      "grinning squinting face")
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      30)),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => emojiBirak(
                                                          e.id, "crying"),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            e.data().containsKey(
                                                                        "crying") &&
                                                                    e["crying"] !=
                                                                        null
                                                                ? e["crying"]
                                                                    .length
                                                                    .toString()
                                                                : "0",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              Emoji.byName(
                                                                      "crying face")
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      30)),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () => emojiBirak(
                                                          e.id, "angry"),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Text(
                                                            e.data().containsKey(
                                                                        "angry") &&
                                                                    e["angry"] !=
                                                                        null
                                                                ? e["angry"]
                                                                    .length
                                                                    .toString()
                                                                : "0",
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          Text(
                                                              Emoji.byName(
                                                                      "angry face")
                                                                  .newSkin(
                                                                      fitzpatrick
                                                                          .None)
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      30)),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            )));
  }

  emojiBirak(String docID, String emojiName) async {
    await FirebaseFirestore.instance
        .collection("Sorular")
        .doc(docID)
        .get()
        .then((doc) async {
      if (doc.data().containsKey("angry") && doc["angry"].contains(user.uid)) {
        await FirebaseFirestore.instance
            .collection("Sorular")
            .doc(docID)
            .update({
          "angry": FieldValue.arrayRemove([user.uid])
        });
      }
      if (doc.data().containsKey("crying") &&
          doc["crying"].contains(user.uid)) {
        await FirebaseFirestore.instance
            .collection("Sorular")
            .doc(docID)
            .update({
          "crying": FieldValue.arrayRemove([user.uid])
        });
      }
      if (doc.data().containsKey("grinning") &&
          doc["grinning"].contains(user.uid)) {
        await FirebaseFirestore.instance
            .collection("Sorular")
            .doc(docID)
            .update({
          "grinning": FieldValue.arrayRemove([user.uid])
        });
      }
      if (doc.data().containsKey("smiling") &&
          doc["smiling"].contains(user.uid)) {
        await FirebaseFirestore.instance
            .collection("Sorular")
            .doc(docID)
            .update({
          "smiling": FieldValue.arrayRemove([user.uid])
        });
      }
      if (doc.data().containsKey(emojiName)) {
        if (doc[emojiName].contains(user.uid)) {
          await FirebaseFirestore.instance
              .collection("Sorular")
              .doc(docID)
              .update({
            emojiName: FieldValue.arrayRemove([user.uid])
          });
        } else {
          await FirebaseFirestore.instance
              .collection("Sorular")
              .doc(docID)
              .update({
            emojiName: FieldValue.arrayUnion([user.uid])
          });
        }
      } else {
        await FirebaseFirestore.instance
            .collection("Sorular")
            .doc(docID)
            .update({
          emojiName: FieldValue.arrayUnion([user.uid])
        });
      }
    });
  }

  myGradient() {
    return LinearGradient(colors: [
      Color(0xFF8378F9),
      Color(0xFF6453F6),
      Color(0xFF6453F6),
      Color(0xFF8378F9),
    ], stops: [
      0.1,
      0.4,
      0.6,
      0.9
    ], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  }

  tarihSec() async {
    final dates = await DateRangePicker.showDatePicker(
      context: context,
      initialFirstDate: pickedDates[0].isBefore(DateTime(2021))
          ? DateTime.now().subtract(Duration(days: 1))
          : pickedDates[0],
      initialLastDate: pickedDates[1],
      firstDate: DateTime(2021),
      lastDate: DateTime(2030),
    );
    setState(() {
      if (dates != null && dates.isNotEmpty) {
        pickedDates = dates;
        if (pickedDates.length == 1) {
          pickedDates.add(pickedDates[0].add(Duration(days: 1)));
        }
        if (pickedDates.length == 2 && pickedDates[0] == pickedDates[1]) {
          pickedDates[1] = pickedDates[0].add(Duration(days: 1));
        }
        if (siralamaString == "Beğeniye Göre" ||
            siralamaString == "Zordan Kolaya" ||
            siralamaString == "Kolaydan Zora") {
          siralamaString = "Varsayılan";
          boolList.fillRange(0, siralamaList.length, false);
          boolList[0] = true;
        }

        queryFunc();
      }
    });
    print(pickedDates);
  }

  siralaUp() {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              setState(() {
                queryFunc();
                mySetState();
              });
              return true;
            },
            child: StatefulBuilder(
              builder: (context, setState) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        contentPadding: EdgeInsets.zero,
                        titlePadding: EdgeInsets.zero,
                        title: Container(
                          width: double.maxFinite,
                          height: MediaQuery.of(context).size.height / 15,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Color(0xff545B92)),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 18.0),
                                child: Text(
                                  "Sırala",
                                  style: TextStyle(color: Colors.white),
                                ),
                              )),
                        ),
                        content: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Column(
                              children: [
                                for (int index = 0;
                                    index < siralamaList.length;
                                    index++)
                                  (ListTile(
                                    onTap: () {
                                      setState(() {
                                        boolList.fillRange(
                                            0, siralamaList.length, false);
                                        boolList[index] = !boolList[index];
                                        siralamaString = siralamaList[index];
                                        print(siralamaString);
                                      });
                                    },
                                    title: Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(siralamaList[index],
                                          style: TextStyle(
                                            color: Colors.black,
                                          )),
                                    ),
                                    leading: Container(
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: boolList[index]
                                              ? Color(0xffF2F2F2)
                                              : Color(0xFFF2F2F2)),
                                      child: boolList[index]
                                          ? Container(
                                              child: Icon(
                                              Icons.circle,
                                              size: 12,
                                              color: Color(0xFF00AE87),
                                            ))
                                          : Container(),
                                    ),
                                  ))
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);

                            setState(() {
                              queryFunc();
                              mySetState();
                            });
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.clear,
                                size: 50,
                                color: Colors.white,
                              )))
                    ],
                  ),
                );
              },
            ),
          );
        });
  }

  mySetState() {
    setState(() {});
  }

  queryFunc() {
    setState(() {
      if (pickedDates != null && pickedDates.isNotEmpty) {
        if (siralamaString == "Varsayılan") {
          querySnapshot = FirebaseFirestore.instance
              .collection("Sorular")
              .where("ders", isEqualTo: widget.ders)
              .where("konu", isEqualTo: widget.konu)
              .where("sinav", isEqualTo: widget.sinav)
              .where(
                "date",
                isGreaterThanOrEqualTo: pickedDates[0],
              )
              .where("date", isLessThanOrEqualTo: pickedDates[1])
              .orderBy("date", descending: true)
              .snapshots();
        } else if (siralamaString == "Beğeniye Göre") {
          querySnapshot = FirebaseFirestore.instance
              .collection("Sorular")
              .where("ders", isEqualTo: widget.ders)
              .where("konu", isEqualTo: widget.konu)
              .where("sinav", isEqualTo: widget.sinav)
              .orderBy("likeSayisi", descending: true)
              .snapshots();
        } else if (siralamaString == "Eskiden Yeniye") {
          querySnapshot = FirebaseFirestore.instance
              .collection("Sorular")
              .where("ders", isEqualTo: widget.ders)
              .where("konu", isEqualTo: widget.konu)
              .where("sinav", isEqualTo: widget.sinav)
              .where(
                "date",
                isGreaterThanOrEqualTo: pickedDates[0],
              )
              .where("date", isLessThanOrEqualTo: pickedDates[1])
              .orderBy("date", descending: false)
              .snapshots();
        } else if (siralamaString == "Yeniden Eskiye") {
          querySnapshot = FirebaseFirestore.instance
              .collection("Sorular")
              .where("ders", isEqualTo: widget.ders)
              .where("konu", isEqualTo: widget.konu)
              .where("sinav", isEqualTo: widget.sinav)
              .where(
                "date",
                isGreaterThanOrEqualTo: pickedDates[0],
              )
              .where("date", isLessThanOrEqualTo: pickedDates[1])
              .orderBy("date", descending: true)
              .snapshots();
        } else if (siralamaString == "Zordan Kolaya") {
          querySnapshot = FirebaseFirestore.instance
              .collection("Sorular")
              .where("ders", isEqualTo: widget.ders)
              .where("konu", isEqualTo: widget.konu)
              .where("sinav", isEqualTo: widget.sinav)
              .orderBy("zorluk", descending: true)
              .snapshots();
        } else if (siralamaString == "Kolaydan Zora") {
          querySnapshot = FirebaseFirestore.instance
              .collection("Sorular")
              .where("ders", isEqualTo: widget.ders)
              .where("konu", isEqualTo: widget.konu)
              .where("sinav", isEqualTo: widget.sinav)
              .orderBy("zorluk", descending: false)
              .snapshots();
        }
      }
    });
  }
}
