import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soru_defteri/Models/Strings.dart';
import 'package:soru_defteri/Models/randomInt.dart';
import 'package:soru_defteri/UI/Settings/YetersizKredi.dart';
import 'package:soru_defteri/flutter_local_notifications.dart';
import 'package:uuid/uuid.dart';

class AddQuestion extends StatefulWidget {
  String yayinEvi;
  int zorluk;
  AddQuestion({Key key,@required this.yayinEvi,@required this.zorluk}):super(key:key);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion>
    with SingleTickerProviderStateMixin {
  final soruYukle = new GlobalKey();
  final cozumYukle = new GlobalKey();
  User user = FirebaseAuth.instance.currentUser;
  final ImagePicker _picker = ImagePicker();
  bool admin=false;
  bool premium=false;

  AutoScrollController _autoScrollController;
  final scrollDirection = Axis.vertical;

  bool isExpaned = true;
  bool get _isAppBarExpanded {
    return _autoScrollController.hasClients &&
        _autoScrollController.offset > (160 - kToolbarHeight);
  }

  bool questionChoosingNow = false;
  bool solutionChoosingNow = false;
  TabController tabController;
  bool dersChoosen = false;
  bool konuChoosen = false;
  bool mistakeChoosen=false;
  bool questionChoosen = false;
  bool solutionChoosen = false;
  String yapilanHata;

  File questLastFile;
  List<File> questFileList = [];
  File solutLastFile;
  List<File> solutFileList = [];

  TextEditingController ipucuEdit = TextEditingController();

  int tabIndex = 0;

  String sinav = "TYT";
  String konu;
  String ders;
  String mistake;
  String hataSebebi = "";
  String ipucuFinal = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    print(widget.yayinEvi);
    print(widget.zorluk);
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    )..addListener(
          () => _isAppBarExpanded
          ? isExpaned != false
          ? setState(
            () {
          isExpaned = false;
          print('setState is called');
        },
      )
          : {}
          : isExpaned != true
          ? setState(() {
        print('setState is called');
        isExpaned = true;
      })
          : {},
    );
    startSync();
  }

  startSync()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
      if(doc.data().containsKey("premium")){
        if(doc["premium"]){
          setState(() {
            premium=true;
          });
        }else{
          setState(() {
            premium=false;
          });
        }
      }else{
        setState(() {
          premium=false;
        });
      }
    });
    if(prefs.getBool("admin")){
      setState(() {
        admin=true;
      });
    }else{
      setState(() {
        admin=false;
      });
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


  Widget _wrapScrollTag({int index, Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: child,
    );
  }
  Future _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),

      child: SafeArea(
        bottom: false,
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            shadowColor: Colors.transparent,
            title: Text(
              "Soru Yükle (TYT)",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: AppBar().preferredSize.height),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF5C54D2),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width / 10))),
                  child: Column(
                    children: [
                      topNumbers(),
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
                                  colors: [
                                    Color(0xFF4846BF),
                                    Color(0xFF787897)
                                  ],
                                  stops: [
                                    0.6,
                                    1
                                  ])),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: TabBar(
                                  indicatorColor: Color(0xff00AE87),
                                  unselectedLabelColor: Color(0xFF4D4FBB),
                                  controller: tabController,
                                  onTap: (index) {
                                    // Tab index when user select it, it start from zero
                                    setState(() {
                                      tabIndex = index;
                                      sinav = index == 0 ? "TYT" : "AYT";
                                      reset();
                                    });
                                  },
                                  tabs: [
                                    Tab(
                                        icon: Text(
                                          "TYT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF7F00),
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width /
                                                  25),
                                        )),
                                    Tab(
                                        icon: Text(
                                          "AYT",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFFF7F00),
                                              fontSize: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .width /
                                                  25),
                                        )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: CustomScrollView(
                                  controller:_autoScrollController,
                                  slivers: [
                                    SliverList(delegate: SliverChildListDelegate([
                                      _wrapScrollTag(
                                        index:0,
                                        child: SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              200,
                                        ),
                                      ),
                                      //DERS SEÇ
                                      _wrapScrollTag(
                                          index:1,
                                        child: GestureDetector(
                                          onTap: () =>
                                              _dersModalBottomSheet(context),
                                          child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        10))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        20)),
                                                gradient: LinearGradient(
                                                    colors: dersChoosen
                                                        ? [
                                                      Color(0xFF00AE87),
                                                      Color(0xFF00AE87)
                                                    ]
                                                        : [
                                                      Color(0xFF0079AE),
                                                      Color(0xFF0079AE)
                                                    ],
                                                    begin:
                                                    Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter),
                                              ),
                                              child: ListTile(
                                                leading: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                        MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width /
                                                            30)),
                                                    gradient: LinearGradient(
                                                        colors: dersChoosen
                                                            ? [
                                                          Color(0xFF00AE87),
                                                          Color(0xFF00AE87)
                                                        ]
                                                            : [
                                                          Color(0xFF0079AE),
                                                          Color(0xFF0079AE)
                                                        ],
                                                        begin: Alignment
                                                            .topCenter,
                                                        end: Alignment
                                                            .bottomCenter),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 6),
                                                    child: Image.asset(
                                                        "assets/images/chooseClass.png"),
                                                  ),
                                                ),
                                                title: Text("Ders Seçimi Yap",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                subtitle: Text(
                                                  "Hangi ders için soru yükleyeceğini belirle",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                                trailing: Wrap(
                                                  children: [
                                                    dersChoosen
                                                        ? Icon(
                                                      Icons.done_all,
                                                      color: Colors.white,
                                                    )
                                                        : Container(
                                                      width: 0,
                                                      height: 0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _wrapScrollTag(
                                        index:2,
                                        child: SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              200,
                                        ),
                                      ),
                                      //KONU SEÇ
                                      _wrapScrollTag(
                                          index:3,
                                        child: GestureDetector(
                                          onTap: dersChoosen
                                              ? () =>
                                              _konuModalBottomSheet(context)
                                              : () => null,
                                          child: Card(
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        10))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        20)),
                                                gradient: LinearGradient(
                                                    colors: !dersChoosen &&
                                                        !konuChoosen
                                                        ? [
                                                      Color(0xFF6453F6),
                                                      Color(0xFF6453F6)
                                                    ]
                                                        : dersChoosen &&
                                                        !konuChoosen ? [

                                                      Color(0xFF00858E),
                                                      Color(0xFF00858E)
                                                    ] : [
                                                      Color(0xFF00AE87),
                                                      Color(0xFF00AE87)
                                                    ],
                                                    begin:
                                                    Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter),
                                              ),
                                              child: ListTile(
                                                leading: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                        MediaQuery
                                                            .of(
                                                            context)
                                                            .size
                                                            .width /
                                                            30)),
                                                    gradient: LinearGradient(
                                                        colors: !dersChoosen &&
                                                            !konuChoosen
                                                            ? [
                                                          Color(0xFF646796),
                                                          Color(0xFF646796)
                                                        ]
                                                            : dersChoosen &&
                                                            !konuChoosen ? [

                                                          Color(0xFF00AD87),
                                                          Color(0xFF008B91)
                                                        ] : [
                                                          Color(0xFF00AE87),
                                                          Color(0xFF00AE87)
                                                        ],
                                                        begin: Alignment
                                                            .topCenter,
                                                        end: Alignment
                                                            .bottomCenter),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10,
                                                        horizontal: 6),
                                                    child: Image.asset(
                                                        "assets/images/chooseMatter.png"),
                                                  ),
                                                ),
                                                title: Text("Konu Seçimi Yap",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                    overflow: TextOverflow
                                                        .ellipsis),
                                                subtitle: Text(
                                                  "Hangi konu için soru yükleyeceğini belirle",
                                                  style: TextStyle(
                                                      color: Colors.white
                                                    //white
                                                  ),
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                                trailing: Wrap(
                                                  children: [
                                                    konuChoosen
                                                        ? Icon(
                                                      Icons.done_all,
                                                      color: Colors.white,
                                                    )
                                                        : Container(
                                                        height: 0,
                                                        width: 0),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _wrapScrollTag(
                                          index:4,
                                        child: SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              200,
                                        ),
                                      ),
                                      //SORU EKLE
                                      _wrapScrollTag(
                                        index:5,
                                        child: GestureDetector(
                                          onTap: konuChoosen &&
                                              !questionChoosingNow
                                              ? () => questChoose()
                                              : () => null,
                                          child: Card(
                                            color: Colors.transparent,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        10))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        20)),
                                                gradient: LinearGradient(
                                                    colors: questionChoosingNow
                                                        ? [
                                                      Colors.transparent,
                                                      Colors.transparent
                                                    ]
                                                        : !konuChoosen &&
                                                        !questionChoosen
                                                        ? [
                                                      Color(0xFF6453F6),
                                                      Color(0xFF6453F6)
                                                    ]
                                                        : konuChoosen &&
                                                        !questionChoosen ? [
                                                      Color(0xFF008D90),
                                                      Color(0xFF008D90)
                                                    ] : [
                                                      Color(0xFF00AE87),
                                                      Color(0xFF00AE87)
                                                    ],
                                                    begin:
                                                    Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width /
                                                                    30)),
                                                        gradient: LinearGradient(
                                                            colors: !konuChoosen &&
                                                                !questionChoosen
                                                                ? [
                                                              Color(
                                                                  0xFF646796),
                                                              Color(
                                                                  0xFF646796)
                                                            ]
                                                                : konuChoosen &&
                                                                !questionChoosen
                                                                ? [
                                                              Color(
                                                                  0xFF008A91),
                                                              Color(
                                                                  0xFF00AE87)
                                                            ]
                                                                : [
                                                              Color(
                                                                  0xFF00AE87),
                                                              Color(
                                                                  0xFF00AE87)
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10,
                                                            horizontal:
                                                            6),
                                                        child: Image.asset(
                                                            "assets/images/chooseQuestion.png"),
                                                      ),
                                                    ),
                                                    title: Text("Soru Ekle",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    subtitle: Text(
                                                      "Fotoğraf çekebilir veya galeriden seçebilirsin",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    trailing: Wrap(
                                                      children: [
                                                        questionChoosen
                                                            ? Icon(
                                                          Icons
                                                              .done_all,
                                                          color: Colors.white,
                                                        )
                                                            : Container(
                                                          height: 0,
                                                          width: 0,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  !questionChoosingNow &&
                                                      questFileList.isNotEmpty
                                                      ?
                                                  Container(height: MediaQuery
                                                      .of(
                                                      context)
                                                      .size
                                                      .height /
                                                      9,
                                                      width: MediaQuery
                                                          .of(context)
                                                          .size
                                                          .width / 1.2,
                                                      child: ListView(
                                                        scrollDirection: Axis
                                                            .horizontal,
                                                        children: questFileList
                                                            .map((File e) =>
                                                            Dismissible(
                                                              key: Key(
                                                                  e.path),
                                                              direction: DismissDirection
                                                                  .up,
                                                              onDismissed: (
                                                                  direction) {
                                                                setState(() {
                                                                  questFileList
                                                                      .remove(
                                                                      e);
                                                                  if (questFileList
                                                                      .isEmpty) {
                                                                    questionChoosen =
                                                                    false;
                                                                  }
                                                                });
                                                              },
                                                              child: Wrap(
                                                                direction: Axis
                                                                    .horizontal,
                                                                children: [
                                                                  Container(
                                                                      height: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height /
                                                                          10,
                                                                      width: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height /
                                                                          10,
                                                                      child: ClipRRect(
                                                                          borderRadius: BorderRadius
                                                                              .all(
                                                                              Radius
                                                                                  .circular(
                                                                                  MediaQuery
                                                                                      .of(
                                                                                      context)
                                                                                      .size
                                                                                      .width /
                                                                                      60)),
                                                                          child: Image
                                                                              .file(
                                                                            e,
                                                                            fit: BoxFit
                                                                                .cover,))),
                                                                  SizedBox(
                                                                      width: 3)
                                                                ],
                                                              ),
                                                            )).toList(),))
                                                      : Container(
                                                    height: questionChoosingNow
                                                        ? MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .height /
                                                        2
                                                        : MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .height /
                                                        10,
                                                    child: questionChoosingNow
                                                        ? Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  20)),
                                                          color: Colors
                                                              .transparent),
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .center,
                                                        children: [
                                                          Column(
                                                            mainAxisSize: MainAxisSize
                                                                .min,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width /
                                                                    1.4,
                                                                height:
                                                                MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    3,
                                                                decoration:
                                                                BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .width /
                                                                                20))),
                                                                child:
                                                                ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                      Radius
                                                                          .circular(
                                                                          MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width /
                                                                              20)),
                                                                  child:
                                                                  Image.file(
                                                                    questLastFile,
                                                                    fit:
                                                                    BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: 10),
                                                              Center(
                                                                child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment
                                                                        .spaceAround,
                                                                    mainAxisSize: MainAxisSize
                                                                        .min,
                                                                    children: [
                                                                      GestureDetector(
                                                                        onTap: () async {
                                                                          await solutChooseAndNext();
                                                                        },
                                                                        child: Container(
                                                                            width: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .width /
                                                                                4.5,
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
                                                                                      "Çözümü Yükle",
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
                                                                      GestureDetector(
                                                                        onTap: () =>
                                                                            solutTipType(),
                                                                        child: Container(
                                                                            width: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .width /
                                                                                4.5,
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
                                                                                            40))),
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
                                                                                      "İpucu\nYaz",
                                                                                      textAlign: TextAlign
                                                                                          .center,
                                                                                      style: TextStyle(
                                                                                          color: Colors
                                                                                              .white))
                                                                                ],),
                                                                            )),
                                                                      ),
                                                                      admin?Container():SizedBox(
                                                                          width: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width /
                                                                              90),
                                                                      admin?Container(): GestureDetector(
                                                                          onTap:()=>_mistakeModalBottomSheet(context),
                                                                        child: Container(
                                                                            width: MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .width /
                                                                                4.5,
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
                                                                                      "assets/images/mistakes.png",
                                                                                      scale: 10),
                                                                                  Text(
                                                                                      "Sürekli Hata Yapıyorum!",
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
                                                                      GestureDetector(
                                                                          onTap:()=>uploadQuest(),
                                                                          child:Container(decoration:BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF6E6DB7),Color(0xFFA5A5A7)],begin:Alignment.topCenter,end:Alignment.bottomCenter),shape:BoxShape.circle),height:MediaQuery.of(context).size.height/10,width:MediaQuery.of(context).size.height/10,
                                                                              child: Center(child:Icon(Icons.done_all,color:Colors.white)))
                                                                      )
                                                                    ]

                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                right: 10.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: GestureDetector(
                                                                onTap: konuChoosen &&
                                                                    !questionChoosingNow
                                                                    ? () =>
                                                                    questChoose()
                                                                    : konuChoosen &&
                                                                    questionChoosingNow
                                                                    ? () =>
                                                                    questChooseNext()
                                                                    : () => null,
                                                                child: Container(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      15,
                                                                  height: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      15,

                                                                  child: Center(
                                                                    child: Icon(
                                                                      questionChoosingNow
                                                                          ? Icons
                                                                          .arrow_forward
                                                                          : Icons
                                                                          .upload_rounded,
                                                                      size: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height /
                                                                          22,
                                                                      color: konuChoosen
                                                                          ? Colors
                                                                          .white
                                                                          : Color(
                                                                          0xFF00AE87),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                        : Row(
                                                      mainAxisSize: MainAxisSize
                                                          .max,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(left: 20.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                15,
                                                            height: MediaQuery
                                                                .of(
                                                                context)
                                                                .size
                                                                .height /
                                                                15,

                                                          ),
                                                        ),
                                                        Text(
                                                          "Fotoğraflarını yükle",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(right: 20.0),
                                                          child: GestureDetector(
                                                            onTap: konuChoosen &&
                                                                !questionChoosingNow
                                                                ? () =>
                                                                questChoose()
                                                                : konuChoosen &&
                                                                questionChoosingNow
                                                                ? () =>
                                                                questChooseNext()
                                                                : () => null,
                                                            child: Container(
                                                              width: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,
                                                              height: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,

                                                              child: Center(
                                                                key:soruYukle,

                                                                child: Icon(
                                                                  questionChoosingNow
                                                                      ? Icons
                                                                      .arrow_forward
                                                                      : Icons
                                                                      .upload_rounded,
                                                                  size: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      22,
                                                                  color: konuChoosen
                                                                      ? Colors
                                                                      .white
                                                                      : Color(
                                                                      0xFF00AE87),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )

                                                      ],
                                                    ),

                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      _wrapScrollTag(
                                        index:6,
                                        child: SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              200,
                                        ),
                                      ),
                                      //İPUCU
                                      _wrapScrollTag(
                                        index:7,
                                        child: GestureDetector(
                                          onTap: questionChoosen &&
                                              !solutionChoosingNow &&
                                              solutFileList.isNotEmpty
                                              ? () => solutChoose()
                                              : () => null,
                                          child: Card(
                                            color: Colors.transparent,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        10))),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius
                                                    .all(Radius.circular(
                                                    MediaQuery
                                                        .of(context)
                                                        .size
                                                        .width /
                                                        20)),
                                                gradient: LinearGradient(
                                                    colors: !questionChoosen &&
                                                        !solutionChoosen
                                                        ? [
                                                      Color(0xFF6453F6),
                                                      Color(0xFF6453F6)
                                                    ]
                                                        : questionChoosen &&
                                                        !solutionChoosen ? [
                                                      Color(0xFF008D90),
                                                      Color(0xFF008D90)
                                                    ] : [
                                                      Color(0xFF00AE87),
                                                      Color(0xFF00AE87)
                                                    ],
                                                    begin:
                                                    Alignment.topCenter,
                                                    end: Alignment
                                                        .bottomCenter),
                                              ),
                                              child: Column(
                                                children: [
                                                  ListTile(
                                                    leading: Container(
                                                      decoration:
                                                      BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .all(
                                                            Radius.circular(
                                                                MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width /
                                                                    30)),
                                                        gradient: LinearGradient(
                                                            colors: !questionChoosen &&
                                                                !solutionChoosen
                                                                ? [
                                                              Color(
                                                                  0xFF646796),
                                                              Color(
                                                                  0xFF646796)
                                                            ]
                                                                : questionChoosen &&
                                                                !solutionChoosen
                                                                ? [
                                                              Color(
                                                                  0xFF00AD87),
                                                              Color(
                                                                  0xFF009091)
                                                            ]
                                                                : [
                                                              Color(
                                                                  0xFF00AE87),
                                                              Color(
                                                                  0xFF00AE87)
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical: 10,
                                                            horizontal:
                                                            6),
                                                        child: Image.asset(
                                                            "assets/images/chooseSolution.png"),
                                                      ),
                                                    ),
                                                    title: Text(
                                                        "Çözüm ve İpucu Ekle",
                                                        style: TextStyle(
                                                            color:
                                                            Colors.white,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis),
                                                    subtitle: Text(
                                                      "Soru çözümlerini hatırlamanı sağlayacak ipucu",
                                                      style: TextStyle(
                                                          color: Colors
                                                              .white),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                    trailing: Wrap(
                                                      children: [
                                                        solutionChoosen
                                                            ? Icon(
                                                          Icons
                                                              .done_all,
                                                          color: Colors.white,
                                                        )
                                                            : Container(
                                                          height: 0,
                                                          width: 0,

                                                        ),
                                                      ],
                                                    ),

                                                  ),
                                                  !solutionChoosingNow &&
                                                      solutFileList.isNotEmpty
                                                      ?
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .end,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: questionChoosen
                                                            ? () => solutTipType()
                                                            : () => null,
                                                        child: Align(
                                                          alignment: Alignment
                                                              .bottomLeft,
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .only(left: 10.0,
                                                                bottom: 10,
                                                                right: 10),
                                                            child: Image
                                                                .asset(
                                                                "assets/images/cozumYukle.png",
                                                                scale: 10),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(height: MediaQuery
                                                          .of(
                                                          context)
                                                          .size
                                                          .height /
                                                          9,
                                                          width: MediaQuery
                                                              .of(context)
                                                              .size
                                                              .width / 1.2,
                                                          child: ListView(
                                                            scrollDirection: Axis
                                                                .horizontal,
                                                            children: solutFileList
                                                                .map((File e) =>
                                                                Dismissible(
                                                                  key: Key(
                                                                      e.path),
                                                                  direction: DismissDirection
                                                                      .up,
                                                                  onDismissed: (
                                                                      direction) {
                                                                    setState(() {
                                                                      solutFileList
                                                                          .remove(
                                                                          e);
                                                                      if (solutFileList
                                                                          .isEmpty) {
                                                                        solutionChoosen =
                                                                        false;
                                                                      }
                                                                    });
                                                                  },
                                                                  child: Wrap(
                                                                    direction: Axis
                                                                        .horizontal,
                                                                    children: [
                                                                      Container(
                                                                          height: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height /
                                                                              10,
                                                                          width: MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .height /
                                                                              10,
                                                                          child: ClipRRect(
                                                                              borderRadius: BorderRadius
                                                                                  .all(
                                                                                  Radius
                                                                                      .circular(
                                                                                      MediaQuery
                                                                                          .of(
                                                                                          context)
                                                                                          .size
                                                                                          .width /
                                                                                          60)),
                                                                              child: Image
                                                                                  .file(
                                                                                e,
                                                                                fit: BoxFit
                                                                                    .cover,))),
                                                                      SizedBox(
                                                                          width: 3)
                                                                    ],
                                                                  ),
                                                                )).toList(),)),
                                                    ],
                                                  )
                                                      : Container(
                                                    height: solutionChoosingNow
                                                        ? MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .height /
                                                        2
                                                        : MediaQuery
                                                        .of(
                                                        context)
                                                        .size
                                                        .height /
                                                        10,
                                                    child: solutionChoosingNow
                                                        ? Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                          BorderRadius
                                                              .all(Radius
                                                              .circular(
                                                              MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  20)),
                                                          color: Colors
                                                              .transparent),
                                                      child: Stack(
                                                        alignment: Alignment
                                                            .center,
                                                        children: [
                                                          Column(
                                                            mainAxisSize: MainAxisSize
                                                                .min,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .width /
                                                                    1.4,
                                                                height:
                                                                MediaQuery
                                                                    .of(
                                                                    context)
                                                                    .size
                                                                    .height /
                                                                    3,
                                                                decoration:
                                                                BoxDecoration(
                                                                    borderRadius: BorderRadius
                                                                        .all(
                                                                        Radius
                                                                            .circular(
                                                                            MediaQuery
                                                                                .of(
                                                                                context)
                                                                                .size
                                                                                .width /
                                                                                20))),
                                                                child:
                                                                ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                      Radius
                                                                          .circular(
                                                                          MediaQuery
                                                                              .of(
                                                                              context)
                                                                              .size
                                                                              .width /
                                                                              20)),
                                                                  child:
                                                                  Image.file(
                                                                    solutLastFile,
                                                                    fit:
                                                                    BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),

                                                              SizedBox(
                                                                  height: 10),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets
                                                                .only(
                                                                right: 10.0),
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: GestureDetector(
                                                                onTap: questionChoosen &&
                                                                    !solutionChoosingNow
                                                                    ? () =>
                                                                    solutChoose()
                                                                    : questionChoosen &&
                                                                    solutionChoosingNow
                                                                    ? () =>
                                                                    solutChooseNext()
                                                                    : () => null,
                                                                child: Container(
                                                                  width: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      15,
                                                                  height: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      15,

                                                                  child: Center(
                                                                    child: Icon(
                                                                      solutionChoosingNow
                                                                          ? Icons
                                                                          .arrow_forward
                                                                          : Icons
                                                                          .upload_rounded,
                                                                      size: MediaQuery
                                                                          .of(
                                                                          context)
                                                                          .size
                                                                          .height /
                                                                          22,
                                                                      color: questionChoosen
                                                                          ? Colors
                                                                          .white
                                                                          : Color(
                                                                          0xFF00AE87),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: questionChoosen
                                                                ? () =>
                                                                solutTipType()
                                                                : () => null,

                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                  .only(
                                                                  left: 10.0,
                                                                  bottom: 10),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .bottomLeft,
                                                                child: Image
                                                                    .asset(
                                                                    "assets/images/cozumYukle.png",
                                                                    scale: 10),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                        : Row(
                                                      mainAxisSize: MainAxisSize
                                                          .max,
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .spaceBetween,
                                                      children: [

                                                        GestureDetector(
                                                          onTap: questionChoosen
                                                              ? () =>
                                                              solutTipType()
                                                              : () => null,

                                                          child: Align(
                                                            alignment: Alignment
                                                                .bottomLeft,
                                                            child: Container(
                                                              width: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,
                                                              height: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,
                                                              child: Padding(
                                                                padding: const EdgeInsets
                                                                    .only(
                                                                    left: 10.0,
                                                                    bottom: 10),
                                                                child: Image
                                                                    .asset(
                                                                    "assets/images/cozumYukle.png",
                                                                    scale: 10),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          "Fotoğraflarını yükle",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .only(right: 20.0),
                                                          child: GestureDetector(
                                                            onTap: questionChoosen &&
                                                                !solutionChoosingNow
                                                                ? () =>
                                                                solutChoose()
                                                                : questionChoosen &&
                                                                solutionChoosingNow
                                                                ? () =>
                                                                solutChooseNext()
                                                                : () => null,
                                                            child: Container(
                                                              width: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,
                                                              height: MediaQuery
                                                                  .of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,

                                                              child: Center(
                                                                child: Icon(
                                                                  solutionChoosingNow
                                                                      ? Icons
                                                                      .arrow_forward
                                                                      : Icons
                                                                      .upload_rounded,
                                                                  size: MediaQuery
                                                                      .of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      22,
                                                                  color: questionChoosen
                                                                      ? Colors
                                                                      .white
                                                                      : Color(
                                                                      0xFF00AE87),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )

                                                      ],
                                                    ),

                                                  ),

                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ), _wrapScrollTag(
                                          index:8,child:
                                      Padding(
                                            padding: const EdgeInsets.only(top:8.0),
                                            child: Container(
                                        height: 45.0,
                                        width:MediaQuery.of(context).size.width/2.3,
                                        child: FlatButton(

                                               onPressed: () =>uploadQuest(),
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
                                            minWidth:MediaQuery.of(context).size.width/2.3,
                                            padding: EdgeInsets.all(0.0),
                                            highlightColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            child: Ink(
                                              decoration: BoxDecoration(
                                                  color: Color(0xFF00AE87),
                                                  borderRadius: BorderRadius.circular(45.0)
                                              ),
                                              child: Container(
                                                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width/2.3, minHeight: 45.0),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  "Soruyu Kaydet",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.white,fontSize: 18
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),
                                          )

                                      ),                                      _wrapScrollTag(
                                        index:9,
                                        child: SizedBox(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height /
                                              8,
                                        ),
                                      )
                                    ],))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  topNumbers() {
    if (!konuChoosen && !questionChoosen && !solutionChoosen) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery
                .of(context)
                .size
                .width / 9,
            vertical: MediaQuery
                .of(context)
                .size
                .height / 100),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00948D)
                              ])),
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FittedBox(
                              child: Text(
                                "01",
                                style:
                                TextStyle(color: Colors.white, fontSize: 100),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 18,
                        child: Center(
                            child: Text(
                              "Ders &\nKonu Seç",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Container()),
            Flexible(
                flex: 1,
                child: Container()),
          ],
        ),
      );
    } else if (konuChoosen && !questionChoosen) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery
                .of(context)
                .size
                .width / 9,
            vertical: MediaQuery
                .of(context)
                .size
                .height / 100),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FittedBox(
                              child: Text(
                                "01",
                                style:
                                TextStyle(color: Colors.white, fontSize: 100),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 18,
                        child: Center(
                            child: Text(
                              "Ders &\nKonu Seç",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00948D)
                              ])),
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FittedBox(
                              child: Text(
                                "02",
                                style:
                                TextStyle(color: Colors.white, fontSize: 100),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 18,
                        child: Center(
                            child: Text(
                              "Soru Ekle",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Container()),
          ],
        ),
      );
    } else if (solutionChoosen||(admin&&(ipucuFinal.isNotEmpty&&ipucuFinal!=""&&ipucuFinal!=null))) {
      print(ipucuFinal);
      return Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery
                .of(context)
                .size
                .height / 100),
        child: Container(height: MediaQuery
            .of(context)
            .size
            .height / 18 + 24, child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: MediaQuery
                  .of(context)
                  .size
                  .width / 20),
              child: Text("İşlem Tamam!", style: TextStyle(fontSize: MediaQuery
                  .of(context)
                  .size
                  .height / 36, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.only(right: MediaQuery
                  .of(context)
                  .size
                  .width / 20,),
              child: GestureDetector(
                  onTap:()=>uploadQuest(),
                  child: Container(width: MediaQuery
                      .of(context)
                      .size
                      .height / 15,
                      height: MediaQuery
                          .of(context)
                          .size
                          .height / 15,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Icon(Icons.done, color: Color(0xFF00AE87)))),
            )
          ],
        ),),
      );
    }
    else if (questionChoosen && !solutionChoosen) {
      return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery
                .of(context)
                .size
                .width / 9,
            vertical: MediaQuery
                .of(context)
                .size
                .height / 100),
        child: Row(
          children: [
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FittedBox(
                              child: Text(
                                "01",
                                style:
                                TextStyle(color: Colors.white, fontSize: 100),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 18,
                        child: Center(
                            child: Text(
                              "Ders &\nKonu Seç",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FittedBox(
                              child: Text(
                                "02",
                                style:
                                TextStyle(color: Colors.white, fontSize: 100),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 18,
                        child: Center(
                            child: Text(
                              "Soru Ekle",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )),
            Flexible(
                flex: 1,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00948D)
                              ])),
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(colors: [
                                Color(0xFF00AE87),
                                Color(0xFF00AE87)
                              ])),
                          width: 20,
                          height: 20,
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FittedBox(
                              child: Text(
                                "03",
                                style:
                                TextStyle(color: Colors.white, fontSize: 100),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height / 18,
                        child: Center(
                            child: Text(
                              "Çözüm &\nİpucu Seç",
                              style: TextStyle(color: Colors.white),
                            )))
                  ],
                )),
          ],
        ),
      );
    }  }

  uploadQuest() async {
    if(admin && (ipucuFinal==""||ipucuFinal.isEmpty||ipucuFinal==null)){
      Fluttertoast.showToast(msg:"İpucu yazmadınız.",gravity: ToastGravity.CENTER);
    }else{
      int kredi;
      await FirebaseFirestore.instance.collection("Users").doc(user.uid).get().then((doc){
        kredi=doc["kredi"];
      });
      if(admin||kredi>0||premium){
        if (konu!=null&&ders!=null&&(questionChoosen||questionChoosingNow)) {
          Navigator.pop(context);
          Fluttertoast.showToast(msg:"Sorunuz yükleniyor lütfen uygulamayı kapatmayınız.",gravity: ToastGravity.CENTER);
          String userName;
          await FirebaseFirestore.instance.collection("Users").doc(user.uid)
              .get()
              .then((doc) {
            userName = doc["userName"];
          });
          List questFilesURLS = [];
          List solutFilesURLS = [];
          String docIDUUID=Uuid().v4();
          for(int i=0;i<questFileList.length;i++){
            final filePath = questFileList[i].path;
            print(filePath.split(".").last);
            File mainFile;
            if (filePath.split(".").last.toLowerCase() == "heic" ||
                filePath.split(".").last.toLowerCase() == "heif") {
              String jpegPath = await HeicToJpg.convert(filePath);
              mainFile = File(jpegPath);
            } else {
              mainFile = File(filePath);
            }
            UploadTask uploadTask = FirebaseStorage.instance
                .ref()
                .child("Sorular")
                .child(docIDUUID)
                .child("Quest " + i.toString())
                .putFile(mainFile);
            final StreamSubscription streamSubscription =
            uploadTask.snapshotEvents.listen((event) {
              print("stream subs çalışıyor.");
            });
            streamSubscription.cancel();
            String fotoURL = await (await uploadTask).ref.getDownloadURL();
            questFilesURLS.add(fotoURL);
          
          }
          for(int i=0;i<solutFileList.length;i++){
            final filePath = solutFileList[i].path;
            print(filePath.split(".").last);
            File mainFile;
            if (filePath.split(".").last.toLowerCase() == "heic" ||
                filePath.split(".").last.toLowerCase() == "heif") {
              String jpegPath = await HeicToJpg.convert(filePath);
              mainFile = File(jpegPath);
            } else {
              mainFile = File(filePath);
            }
            UploadTask uploadTask = FirebaseStorage.instance
                .ref()
                .child("Sorular")
                .child(docIDUUID)
                .child("Solut " + i.toString())
                .putFile(mainFile);
            final StreamSubscription streamSubscription =
            uploadTask.snapshotEvents.listen((event) {
              print("stream subs çalışıyor.");
            });
            streamSubscription.cancel();
            String fotoURL = await (await uploadTask).ref.getDownloadURL();
            solutFilesURLS.add(fotoURL);
          }
          Map<String, dynamic> questInfo = Map();
          questInfo["soruFotos"] = questFilesURLS;
          if(solutFilesURLS.isNotEmpty){
            questInfo["cozumFotos"] = solutFilesURLS;
          }
          questInfo["ipucu"] = ipucuFinal;
          questInfo["paylasanID"] = user.uid;
          questInfo["date"] = DateTime.now();
          questInfo["userName"] = userName;
          questInfo["yayinEvi"]=widget.yayinEvi;
          questInfo["zorluk"]=widget.zorluk;
          questInfo["hata"]=mistake;
          questInfo["sinav"]=sinav;
          questInfo["ders"]=ders;
          questInfo["konu"]=konu;
          questInfo["tekrarNum"]=0;
          questInfo["tekrarTime"]=DateTime.now();
          questInfo["tekrarYapilacak"]=DateTime.now().add(Duration(days: 1));
          questInfo["tekrar"]=true;
          questInfo["liked"]=[];
          questInfo["likeSayisi"]=0;
          
          await FirebaseFirestore.instance.collection(admin?"EditorSorular":"Sorular").doc().set(questInfo);
          if (!admin&&!premium) {
            await FirebaseFirestore.instance.collection("Users").doc(user.uid).set({"kredi":kredi-1},SetOptions(merge:true));
          }
          
          Fluttertoast.showToast(msg:"Sorunuz başarıyla yüklenmiştir.",gravity: ToastGravity.CENTER);
          if (!admin) {
            int id=RandomDigits.getInteger(5);
          
            LocalNotification().scheduledNotify(id, "Tekrar etmen gereken sorular var!", "Bugünkü tekrarlarına göz atmayı unutma.",day: 1,hour: 0,minute: 0,second: 0);
            LocalNotification().scheduledNotify(id, "Tekrar etmen gereken sorular var!", "Bugünkü tekrarlarına göz atmayı unutma.",day: 7,hour: 0,minute: 0,second: 0);
            LocalNotification().scheduledNotify(id, "Tekrar etmen gereken sorular var!", "Bugünkü tekrarlarına göz atmayı unutma.",day: 28,hour: 0,minute: 0,second: 0);
          }
        }else{
          Fluttertoast.showToast(msg: "Boşlukları doldurunuz.");
        }
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>YetersizKredi()));
      }
    }
  }

  //BOTTOM SHEETS----------------------------
  void _dersModalBottomSheet(context) {
    List dersler = [];
    print(sinav);
    if (sinav == "TYT") {
      dersler = MyStrings().classesTYT;
    } else {
      dersler = MyStrings().classesAYT;
    }
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      expand: false,
      builder: (context) =>
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width / 10)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15.0, top: 15),
                      child: IconButton(icon: Icon(Icons.clear, size: 24,),
                        onPressed: () => Navigator.pop(context),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "Ders Seç",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Opacity(
                      opacity: 0,
                      child: Padding(
                        padding: EdgeInsets.only(right: 15.0, top: 15),
                        child: IconButton(icon: Icon(Icons.clear, size: 24,),
                          onPressed: () => Navigator.pop(context),),
                      ),
                    )
                  ],
                ),
                ListView(
                  reverse: false,
                  shrinkWrap: true,
                  controller: ModalScrollController.of(context),
                  physics: ClampingScrollPhysics(),
                  children: ListTile.divideTiles(
                      context: context,
                      tiles: dersler
                          .map((e) =>
                          ListTile(
                            title: Text(e),
                            onTap: () {
                              setState(() {
                                ders = e;
                                Navigator.pop(context);
                                dersChoosen = true;
                              });
                            },
                          ))
                          .toList())
                      .toList(),
                ),
              ],
            ),
          ),
    );
  }

  void _konuModalBottomSheet(context) {
    List konular = [];
    print(sinav);

    if (sinav == "TYT") {
      if (ders == "Türkçe") {
        konular = MyStrings().turkceTYT;
      } else if (ders == "Biyoloji") {
        konular = MyStrings().biyolojiTYT;
      } else if (ders == "Coğrafya") {
        konular = MyStrings().cografyaTYT;
      } else if (ders == "Din") {
        konular = MyStrings().dinTYT;
      } else if (ders == "Felsefe") {
        konular = MyStrings().felsefeTYT;
      } else if (ders == "Fizik") {
        konular = MyStrings().fizikTYT;
      } else if (ders == "Geometri") {
        konular = MyStrings().geoTYT;
      } else if (ders == "Kimya") {
        konular = MyStrings().kimyaTYT;
      } else if (ders == "Matematik") {
        konular = MyStrings().matematikTYT;
      } else if (ders == "Tarih") {
        konular = MyStrings().tarihTYT;
      }
    } else {
      if (ders == "Biyoloji") {
        konular = MyStrings().bioAYT;
      } else if (ders == "Coğrafya") {
        konular = MyStrings().cografyaAYT;
      } else if (ders == "Fizik") {
        konular = MyStrings().fizikAYT;
      } else if (ders == "Geometri") {
        konular = MyStrings().geoAYT;
      } else if (ders == "Kimya") {
        konular = MyStrings().kimyaAYT;
      } else if (ders == "Matematik") {
        konular = MyStrings().matematikAYT;
      } else if (ders == "Tarih") {
        konular = MyStrings().tarihAYT;
      }
    }
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      expand: false,
      builder: (context) =>
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width / 10)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 15),
                        child: IconButton(
                          icon: Icon(Icons.clear, size: 24,),
                          onPressed: () => Navigator.pop(context),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Konu Seç",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Opacity(
                        opacity: 0,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0, top: 15),
                          child: IconButton(
                            icon: Icon(Icons.clear, size: 24,),
                            onPressed: () => Navigator.pop(context),),
                        ),
                      )

                    ],
                  ),
                  ListView(
                    reverse: false,
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    physics: ClampingScrollPhysics(),
                    children: ListTile.divideTiles(
                        context: context,
                        tiles: konular
                            .map((e) =>
                            ListTile(
                              title: Text(e),
                              onTap: () {
                                setState(() {
                                  konu = e;
                                  Navigator.pop(context);
                                  konuChoosen = true;
                                });
                              },
                            ))
                            .toList())
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  void _mistakeModalBottomSheet(context) {
    List hatalar = MyStrings().mistakes;

    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      expand: false,
      builder: (context) =>
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(MediaQuery
                      .of(context)
                      .size
                      .width / 10)),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 15.0, top: 15),
                        child: IconButton(icon: Icon(Icons.clear, size: 24,),
                          onPressed: () => Navigator.pop(context),),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: Text(
                          "Hata Yapma Sebebini Bildir",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Opacity(
                        opacity: 0,
                        child: Padding(
                          padding: EdgeInsets.only(right: 15.0, top: 15),
                          child: IconButton(icon: Icon(Icons.clear, size: 24,),
                            onPressed: () => Navigator.pop(context),),
                        ),
                      )
                    ],
                  ),
                  ListView(
                    reverse: false,
                    shrinkWrap: true,
                    controller: ModalScrollController.of(context),
                    physics: ClampingScrollPhysics(),
                    children: ListTile.divideTiles(
                        context: context,
                        tiles: hatalar
                            .map((e) =>
                            ListTile(
                              title: Text(e),
                              onTap: () {
                                setState(() {
                                  mistake = e;
                                  Navigator.pop(context);
                                  mistakeChoosen = true;
                                });
                              },
                            ))
                            .toList())
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
    );
  }


  questChoose() async {
    if(questFileList.length>=1){
      Fluttertoast.showToast(msg: "Her soru için yalnız bir soru fotoğrafı yükleyebilirsiniz");
    }else{
      showDialog(
          context: context,
          builder: (context) {
            return Container(
              color: Color(0xFF6453F6),
              child: Scaffold(
                extendBodyBehindAppBar: true,
                backgroundColor: Color(0xFF6453F6),
                appBar: AppBar(
                  title: Text("Soru Yükle"),
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
                                mainAxisSize: MainAxisSize.min, children: [
                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 16,),
                                Text("Soru Fotoğrafını Çek", style: TextStyle(
                                    fontSize: 20, color: Color(0xFF6453F6))),
                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 60),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Bulanık soruları daha sonra okuyamayacağını unutmamalısın.",
                                    style: TextStyle(
                                        fontSize: 15, color: Color(0xFF999CB9)),
                                    textAlign: TextAlign.center,),
                                ),
                                Expanded(
                                  child: Center(
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      minWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 30,
                                      color: Color(0xFF00AE87),
                                      child: Text(
                                          "BAŞLA"),
                                      onPressed: () async {
                                        //TODO gallery OLARAK DEĞİŞTİR SOURCE

                                        if (await Permission.camera
                                            .isGranted) {} else {
                                          await Permission.camera.request();
                                        }
                                        final pickedFile =
                                        await _picker.getImage(
                                            source: ImageSource.gallery);
                                        File finalImage = await ImageCropper.cropImage(
                                            sourcePath: File(pickedFile.path).path,
                                            aspectRatioPresets: Platform.isAndroid
                                                ? [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ]
                                                : [
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio5x3,
                                              CropAspectRatioPreset.ratio5x4,
                                              CropAspectRatioPreset.ratio7x5,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            androidUiSettings: AndroidUiSettings(
                                                toolbarTitle: 'Görseli Kırp',
                                                toolbarColor: Colors.black,
                                                toolbarWidgetColor: Colors.white,
                                                initAspectRatio: CropAspectRatioPreset.original,
                                                lockAspectRatio: false),
                                            iosUiSettings: IOSUiSettings(
                                              title: 'Görseli Kırp',
                                            ));
                                        setState(() {
                                          questionChoosen = false;
                                          questLastFile = finalImage!=null?finalImage:File(pickedFile.path);
                                          questFileList.add(questLastFile);
                                          Navigator.pop(context);
                                          questionChoosingNow = true;
                                        });
                                        await Future.delayed(Duration(milliseconds: 200));
                                        _scrollToIndex(5);
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
                                  child: Image.asset("assets/images/camIcon.png"),
                                ),),
                            )),
                      ],
                    )
                ),
              ),
            );
          });
    }
  }

  questChooseNext() async {
    setState(() {
      questionChoosingNow = false;
      questionChoosen = true;
    });
  }

  solutChoose() async {
    if(solutFileList.length>=1){
      Fluttertoast.showToast(msg: "Her soru için yalnız bir çözüm fotoğrafı yükleyebilirsiniz");
    }else{
      showDialog(
          context: context,
          builder: (context) {
            return Container(
              color: Color(0xFF6453F6),
              child: Scaffold(
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
                                mainAxisSize: MainAxisSize.min, children: [
                                SizedBox(height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 16,),
                                Text("Çözüm Fotoğrafını Çek", style: TextStyle(
                                    fontSize: 20, color: Color(0xFF6453F6))),
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
                                        fontSize: 15, color: Color(0xFF999CB9)),
                                    textAlign: TextAlign.center,),
                                ),
                                Expanded(
                                  child: Center(
                                    child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      minWidth: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 30,
                                      color: Color(0xFF00AE87),
                                      child: Text(
                                          "BAŞLA"),
                                      onPressed: () async {
                                        //TODO gallery OLARAK DEĞİŞTİR SOURCE

                                        if (await Permission.camera
                                            .isGranted) {} else {
                                          await Permission.camera.request();
                                        }
                                        final pickedFile =
                                        await _picker.getImage(
                                            source: ImageSource.gallery);
                                        File finalImage = await ImageCropper.cropImage(
                                            sourcePath: File(pickedFile.path).path,
                                            aspectRatioPresets: Platform.isAndroid
                                                ? [
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio16x9
                                            ]
                                                : [
                                              CropAspectRatioPreset.original,
                                              CropAspectRatioPreset.square,
                                              CropAspectRatioPreset.ratio3x2,
                                              CropAspectRatioPreset.ratio4x3,
                                              CropAspectRatioPreset.ratio5x3,
                                              CropAspectRatioPreset.ratio5x4,
                                              CropAspectRatioPreset.ratio7x5,
                                              CropAspectRatioPreset.ratio16x9
                                            ],
                                            androidUiSettings: AndroidUiSettings(
                                                toolbarTitle: 'Görseli Kırp',
                                                toolbarColor: Colors.black,
                                                toolbarWidgetColor: Colors.white,
                                                initAspectRatio: CropAspectRatioPreset.original,
                                                lockAspectRatio: false),
                                            iosUiSettings: IOSUiSettings(
                                              title: 'Görseli Kırp',
                                            ));
                                        setState(() {
                                          solutionChoosen = false;
                                          solutLastFile = finalImage!=null?finalImage: File(pickedFile.path);
                                          solutFileList.add(solutLastFile);
                                          Navigator.pop(context);
                                          solutionChoosingNow = true;
                                        });
                                        await Future.delayed(Duration(milliseconds: 200));
                                        _scrollToIndex(7);
                                        if(solutFileList.length==1&&ipucuFinal==""){
                                          await Future.delayed(Duration(milliseconds: 400));
                                          solutTipType();
                                        }
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
                                  child: Image.asset("assets/images/camIcon.png"),
                                ),),
                            )),
                      ],
                    )
                ),
              ),
            );
          });
    }
  }

  solutChooseNext() async {
    setState(() {
      solutionChoosingNow = false;
      solutionChoosen = true;
    });
  }

  solutChooseAndNext() async {
    if(solutFileList.length>=1){
      Fluttertoast.showToast(msg: "Her soru için yalnız bir çözüm fotoğrafı yükleyebilirsiniz");
    }else{
      showDialog(
          context: context,
          builder: (context) {
            return Scaffold(
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
                              mainAxisSize: MainAxisSize.min, children: [
                              SizedBox(height: MediaQuery
                                  .of(context)
                                  .size
                                  .height / 16,),
                              Text("Çözüm Fotoğrafını Çek", style: TextStyle(
                                  fontSize: 20, color: Color(0xFF6453F6))),
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
                                      fontSize: 15, color: Color(0xFF999CB9)),
                                  textAlign: TextAlign.center,),
                              ),
                              Expanded(
                                child: Center(
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    minWidth: MediaQuery
                                        .of(context)
                                        .size
                                        .height / 30,
                                    color: Color(0xFF00AE87),
                                    child: Text(
                                        "BAŞLA"),
                                    onPressed: () async {
                                      //TODO gallery OLARAK DEĞİŞTİR SOURCE

                                      if (await Permission.camera
                                          .isGranted) {} else {
                                        await Permission.camera.request();
                                      }
                                      final pickedFile =
                                      await _picker.getImage(
                                          source: ImageSource.gallery);
                                      File finalImage = await ImageCropper.cropImage(
                                          sourcePath: File(pickedFile.path).path,
                                          aspectRatioPresets: Platform.isAndroid
                                              ? [
                                            CropAspectRatioPreset.square,
                                            CropAspectRatioPreset.ratio3x2,
                                            CropAspectRatioPreset.original,
                                            CropAspectRatioPreset.ratio4x3,
                                            CropAspectRatioPreset.ratio16x9
                                          ]
                                              : [
                                            CropAspectRatioPreset.original,
                                            CropAspectRatioPreset.square,
                                            CropAspectRatioPreset.ratio3x2,
                                            CropAspectRatioPreset.ratio4x3,
                                            CropAspectRatioPreset.ratio5x3,
                                            CropAspectRatioPreset.ratio5x4,
                                            CropAspectRatioPreset.ratio7x5,
                                            CropAspectRatioPreset.ratio16x9
                                          ],
                                          androidUiSettings: AndroidUiSettings(
                                              toolbarTitle: 'Görseli Kırp',
                                              toolbarColor: Colors.black,
                                              toolbarWidgetColor: Colors.white,
                                              initAspectRatio: CropAspectRatioPreset.original,
                                              lockAspectRatio: false),
                                          iosUiSettings: IOSUiSettings(
                                            title: 'Görseli Kırp',
                                          ));
                                      setState(() {
                                        solutionChoosen = false;
                                        solutLastFile = finalImage!=null?finalImage: File(pickedFile.path);
                                        solutFileList.add(solutLastFile);
                                        Navigator.pop(context);
                                        solutionChoosingNow = true;
                                        solutionChoosingNow = false;
                                        solutionChoosen = true;
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
                                shape: BoxShape.circle, color: Color(0xFF6453F6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset("assets/images/camIcon.png"),
                              ),),
                          )),
                    ],
                  )
              ),
            );
          });
    }

  }

  solutTipType() async {
    if (ipucuEdit.text != ipucuFinal) {
      ipucuEdit.clear();
    }
    showDialog(
        context: context,
        builder: (contexts) {
          return WillPopScope(
            onWillPop: ()async{
              setState((){
                ipucuFinal = ipucuEdit.text;
              });
              return true;
            },
            child: Scaffold(
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
                              onPressed: ()async {
                                setState(() {
                                  ipucuFinal = ipucuEdit.text;
                                });
                                Navigator.pop(context);
                                setState((){
                                  ipucuFinal = ipucuEdit.text;
                                });
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
                          Text(ipucuFinal == ipucuEdit.text
                              ? "Kaydedildi"
                              : "Kaydedilmedi",style: TextStyle(color: Colors.white)),
                        ],),
                      ),),
                  );
                },
              ),
            ),
          );
        });
  }

  reset() {
    setState(() {
      ders=null;
      konu=null;
      mistake=null;
      questionChoosingNow = false;
      solutionChoosingNow = false;
      dersChoosen = false;
      konuChoosen = false;
      mistakeChoosen=false;
      questionChoosen = false;
      solutionChoosen = false;
      questLastFile = null;
      questFileList = [];
      solutLastFile = null;
      solutFileList = [];
      ipucuEdit.clear();
      ipucuFinal = "";
    });
  }
}
