import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:soru_defteri/Models/Strings.dart';

class AddQuestion extends StatefulWidget {
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();

  bool questionChoosingNow = false;
  bool solutionChoosingNow = false;
  TabController tabController;
  String ders;
  bool dersChoosen = false;
  String konu;
  bool konuChoosen = false;
  String questionImageUrl;
  bool questionChoosen = false;
  String solutionImageUrl;
  bool solutionChoosen = false;

  File questLastFile;
  List<File> questFileList = [];
  File solutLastFile;
  List<File> solutFileList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF281D87),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: Text(
          "Soru Yükle",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/addQuestBG.png",
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SizedBox(height: AppBar().preferredSize.height + 20),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xFF351C83),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              MediaQuery.of(context).size.width / 10))),
                  child: Column(
                    children: [
                      topNumbers(),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      MediaQuery.of(context).size.width / 10)),
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xFF5E4FEF),
                                    Color(0xFF050C77)
                                  ],
                                  stops: [
                                    0.01,
                                    0.09
                                  ])),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                child: TabBar(
                                  indicatorColor: Color(0xffF15C22),
                                  unselectedLabelColor: Color(0xFF4D4FBB),
                                  controller: tabController,
                                  onTap: (index) {
                                    // Tab index when user select it, it start from zero
                                  },
                                  tabs: [
                                    Tab(
                                        icon: Text(
                                      "TYT",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFFFF7F00),
                                          fontSize: MediaQuery.of(context)
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
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              25),
                                    )),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: TabBarView(
                                  controller: tabController,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                200,
                                          ),
                                          //DERS SEÇ
                                          GestureDetector(
                                            onTap: () =>
                                                _dersModalBottomSheet(context),
                                            child: Card(
                                              elevation:0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              10))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              20)),
                                                  gradient: LinearGradient(
                                                      colors: dersChoosen
                                                          ? [
                                                              Color(0xFF40107A),
                                                              Color(0xFF492F73)
                                                            ]
                                                          : [
                                                              Color(0xFFFF007E),
                                                              Color(0xFFFF9500)
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
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  30)),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color(0xFFFF9400),
                                                            Color(0xFF472E71)
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
                                                        color: dersChoosen
                                                            ? Color(0xFFFF7E00)
                                                            : Colors.white),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  trailing: Wrap(
                                                    children: [
                                                      dersChoosen
                                                          ? Icon(
                                                              Icons.done_all,
                                                              color: Color(
                                                                  0xFF00AE87),
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
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                200,
                                          ),
                                          //KONU SEÇ
                                          GestureDetector(
                                            onTap: dersChoosen? () =>
                                                _konuModalBottomSheet(context):()=>null,
                                            child: Card(
                                              elevation:0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              10))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              20)),
                                                  gradient: LinearGradient(
                                                      colors: dersChoosen &&
                                                              !konuChoosen
                                                          ? [
                                                              Color(0xFFF200FF),
                                                              Color(0xFF3A29FF)
                                                            ]
                                                          : [
                                                              Color(0xFF4C00A3),
                                                              Color(0xFF2B18A7)
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
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  30)),
                                                      gradient: LinearGradient(
                                                          colors: [
                                                            Color(0xFFF400FF),
                                                            Color(0xFF3B29FF)
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
                                                        color: dersChoosen &&
                                                                !konuChoosen
                                                            ? Colors.white
                                                            : Color(
                                                                0xFFEF00FF) //white
                                                        ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  trailing: Wrap(
                                                    children: [
                                                      konuChoosen
                                                          ? Icon(
                                                              Icons.done_all,
                                                              color: Color(
                                                                  0xFF00AE87),
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
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                200,
                                          ),
                                          //SORU EKLE
                                          GestureDetector(
                                            onTap: konuChoosen&&!questionChoosingNow
                                                ? () => questChoose()
                                                : konuChoosen&&questionChoosingNow? () => questChooseNext():()=>null,
                                            child: Card(
                                              elevation:0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              10))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              20)),
                                                  gradient: LinearGradient(
                                                      colors: konuChoosen &&
                                                              !questionChoosen
                                                          ? [
                                                              Color(0xFF392BFF),
                                                              Color(0xFF40C5FF)
                                                            ]
                                                          : [
                                                              Color(0xFF2E21A8),
                                                              Color(0xFF373FA8)
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
                                                              .all(Radius.circular(
                                                                  MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      30)),
                                                          gradient: LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xFF41C4FF),
                                                                Color(
                                                                    0xFF392CFF)
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
                                                            color: konuChoosen &&
                                                                    !questionChoosen
                                                                ? Colors.white
                                                                : Color(
                                                                    0xFF42B6FF)),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      trailing: Wrap(
                                                        children: [
                                                          questionChoosen
                                                              ? Icon(
                                                                  Icons
                                                                      .done_all,
                                                                  color: Color(
                                                                      0xFF00AE87),
                                                                )
                                                              : Container(
                                                                  height: 0,
                                                                  width: 0,
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                    !questionChoosingNow&&questFileList.isNotEmpty?
  Container(height:MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height /
                                                        10,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        child:ListView(scrollDirection: Axis.horizontal,children:questFileList.map((File e) => Dismissible( key:Key(e.path),direction: DismissDirection.up,onDismissed: (direction){setState(() {
                                                          questFileList.remove(e);
                                                          if(questFileList.isEmpty){
                                                              questionChoosen=false;
                                                          }
                                                        });},                                                          child: Wrap(
                                                            direction:Axis.horizontal,
                                                            children: [
                                                              Container(height:MediaQuery.of(context).size.height/15,width:MediaQuery.of(context).size.width/10,child: ClipRRect(borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/60)),child: Image.file(e,fit: BoxFit.cover,))),
                                                              SizedBox(width:3)
                                                            ],
                                                          ),
                                                        )).toList(),)):                                                    Container(
    height: questionChoosingNow
        ? MediaQuery.of(
        context)
        .size
        .height /
        2
        : MediaQuery.of(
        context)
        .size
        .height /
        10,
    child: Row(
      mainAxisAlignment:
      MainAxisAlignment
          .spaceBetween,
      children: [
        Padding(
          padding:
          EdgeInsets.only(
              left: 20.0),
          child: Container(
            width: MediaQuery.of(
                context)
                .size
                .height /
                15,
          ),
        ),
        questionChoosingNow
            ? Container(
          decoration: BoxDecoration(
              borderRadius:
              BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width /
                  20)),
              color: Color(
                  0xFF262063)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: MediaQuery.of(context).size.width /
                    1.6,
                height:
                MediaQuery.of(context).size.height /
                    3,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width / 20))),
                child:
                ClipRRect(
                  borderRadius:
                  BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width / 20)),
                  child:
                  Image.file(
                    questLastFile,
                    fit:
                    BoxFit.fitWidth,
                  ),
                ),
              ),
              Padding(
                padding:
                EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.width/60),
                child:
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize:MainAxisSize.max,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height:MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration( gradient:LinearGradient(colors:[Color(0xFF3128CE),Color(0xFF3B8ACB)],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width / 20), topRight: Radius.circular(MediaQuery.of(context).size.width / 20), bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 20), bottomRight: Radius.circular(MediaQuery.of(context).size.width / 40))),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/images/chooseSolution.png",scale:10),
                                Text("İpucunu Yükle",textAlign:TextAlign.center,style:TextStyle(color:Colors.white))
                              ],),
                          ) ),
                      SizedBox(width:MediaQuery.of(context).size.width/90),
                      Container(
                          width: MediaQuery.of(context).size.width / 4,
                          height:MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF3128CE),Color(0xFF3B8ACB)],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width / 20), topRight: Radius.circular(MediaQuery.of(context).size.width / 20), bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 40), bottomRight: Radius.circular(MediaQuery.of(context).size.width / 40))),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/images/mistakes.png",scale:10),
                                Text("Çözerken Hata Yapıyorum!",textAlign:TextAlign.center,style:TextStyle(color:Colors.white))
                              ],),
                          ) ),
                      SizedBox(width:MediaQuery.of(context).size.width/90),

                      Container(
                          width: MediaQuery.of(context).size.width / 6,
                          height:MediaQuery.of(context).size.height / 10,
                          decoration: BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF3128CE),Color(0xFF3B8ACB)],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width / 20), topRight: Radius.circular(MediaQuery.of(context).size.width / 20), bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 40), bottomRight: Radius.circular(MediaQuery.of(context).size.width / 20))),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset("assets/images/cozumYukle.png",scale:10),
                                Text("Çözümü Yükle",textAlign:TextAlign.center,style:TextStyle(color:Colors.white))
                              ],),
                          ) ),

                    ]

                ),
              )
            ],
          ),
        )
            : Text(
          "Fotoğraflarını yükle",
          style: TextStyle(
              color: konuChoosen &&
                  !questionChoosen
                  ? Colors
                  .white
                  : Color(
                  0xFF3F7ED7)),
        ),
        Padding(
          padding:
          EdgeInsets.only(
              right:
              20.0),
          child: Opacity(
            opacity:
            konuChoosen &&
                !questionChoosen
                ? 1
                : 0.4,
            child: GestureDetector(
              //onTap:()=>  questChooseNext(),
              child: Container(
                width: MediaQuery.of(
                    context)
                    .size
                    .height /
                    15,
                height: MediaQuery.of(
                    context)
                    .size
                    .height /
                    15,
                decoration: BoxDecoration(
                    shape: BoxShape
                        .circle,
                    gradient: LinearGradient(
                        colors: [
                          Color(
                              0xFF41C4FF),
                          Color(
                              0xFF392CFF)
                        ],
                        begin: Alignment
                            .topCenter,
                        end: Alignment
                            .bottomCenter)),
                child: Center(
                  child: Icon(
                    questionChoosingNow
                        ? Icons
                        .arrow_forward
                        : Icons
                        .upload_rounded,
                    size: MediaQuery.of(context)
                        .size
                        .height /
                        22,
                    color: Colors
                        .white,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                200,
                                          ),
                                          //İPUCU EKLE
                                          GestureDetector(
                                            onTap: questionChoosen&&!solutionChoosingNow
                                                ? () => solutChoose():questionChoosen&&solutionChoosingNow?()=>solutChooseNext()
                                                : ()=>null,
                                            child: Card(
                                              elevation:0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          10))),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                          20)),
                                                  gradient: LinearGradient(
                                                      colors: questionChoosen &&
                                                          !solutionChoosen
                                                          ? [
                                                        Color(0xFF00AD87),
                                                        Color(0xFF6F5EFF)
                                                      ]
                                                          : [
                                                        Color(0xFF1B3A8D),
                                                        Color(0xFF3322A2)
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
                                                              .all(Radius.circular(
                                                              MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .width /
                                                                  30)),
                                                          gradient: LinearGradient(
                                                              colors: [
                                                                Color(
                                                                    0xFF41C4FF),
                                                                Color(
                                                                    0xFF392CFF)
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
                                                        "Soru çözümlerini hatırlamanı sağlayacak ipucu",
                                                        style: TextStyle(
                                                            color: questionChoosen &&
                                                                !solutionChoosen
                                                                ? Colors.white
                                                                : Color(
                                                                0xFF00AE87) //white
                                                        ),
                                                        overflow:
                                                        TextOverflow.ellipsis,
                                                      ),
                                                      trailing: Wrap(
                                                        children: [
                                                          solutionChoosen
                                                              ? Icon(
                                                            Icons
                                                                .done_all,
                                                            color: Color(
                                                                0xFF00AE87),
                                                          )
                                                              : Container(
                                                            height: 0,
                                                            width: 0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    !solutionChoosingNow&&solutFileList.isNotEmpty?
                                                    Container(height:MediaQuery.of(
                                                        context)
                                                        .size
                                                        .height /
                                                        10,
                                                        width: MediaQuery.of(context).size.width/1.3,
                                                        child:ListView(scrollDirection: Axis.horizontal,children:solutFileList.map((File e) => Dismissible( key:Key(e.path),direction: DismissDirection.up,onDismissed: (direction){setState(() {
                                                          solutFileList.remove(e);
                                                          if(solutFileList.isEmpty){
                                                            solutionChoosen=false;
                                                          }
                                                        });},                                                          child: Wrap(
                                                          direction:Axis.horizontal,
                                                          children: [
                                                            Container(height:MediaQuery.of(context).size.height/15,width:MediaQuery.of(context).size.width/10,child: ClipRRect(borderRadius:BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width/60)),child: Image.file(e,fit: BoxFit.cover,))),
                                                            SizedBox(width:3)
                                                          ],
                                                        ),
                                                        )).toList(),)):                                                    Container(
                                                      height: solutionChoosingNow
                                                          ? MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height /
                                                          2
                                                          : MediaQuery.of(
                                                          context)
                                                          .size
                                                          .height /
                                                          10,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                left: 20.0),
                                                            child: Container(
                                                              width: MediaQuery.of(
                                                                  context)
                                                                  .size
                                                                  .height /
                                                                  15,
                                                            ),
                                                          ),
                                                          solutionChoosingNow
                                                              ? Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width /
                                                                    20)),
                                                                color: Color(
                                                                    0xFF262063)),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width /
                                                                      1.6,
                                                                  height:
                                                                  MediaQuery.of(context).size.height /
                                                                      3,
                                                                  decoration:
                                                                  BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width / 20))),
                                                                  child:
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.all(Radius.circular(MediaQuery.of(context).size.width / 20)),
                                                                    child:
                                                                    Image.file(
                                                                      solutLastFile,
                                                                      fit:
                                                                      BoxFit.fitWidth,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.width/60),
                                                                  child:
                                                                  Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                      mainAxisSize:MainAxisSize.max,
                                                                      children: [
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width / 6,
                                                                            height:MediaQuery.of(context).size.height / 10,
                                                                            decoration: BoxDecoration( gradient:LinearGradient(colors:[Color(0xFF3128CE),Color(0xFF3B8ACB)],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width / 20), topRight: Radius.circular(MediaQuery.of(context).size.width / 20), bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 20), bottomRight: Radius.circular(MediaQuery.of(context).size.width / 40))),
                                                                            child: Center(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Image.asset("assets/images/chooseSolution.png",scale:10),
                                                                                  Text("İpucunu Yükle",textAlign:TextAlign.center,style:TextStyle(color:Colors.white))
                                                                                ],),
                                                                            ) ),
                                                                        SizedBox(width:MediaQuery.of(context).size.width/90),
                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width / 4,
                                                                            height:MediaQuery.of(context).size.height / 10,
                                                                            decoration: BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF3128CE),Color(0xFF3B8ACB)],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width / 20), topRight: Radius.circular(MediaQuery.of(context).size.width / 20), bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 40), bottomRight: Radius.circular(MediaQuery.of(context).size.width / 40))),
                                                                            child: Center(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Image.asset("assets/images/mistakes.png",scale:10),
                                                                                  Text("Çözerken Hata Yapıyorum!",textAlign:TextAlign.center,style:TextStyle(color:Colors.white))
                                                                                ],),
                                                                            ) ),
                                                                        SizedBox(width:MediaQuery.of(context).size.width/90),

                                                                        Container(
                                                                            width: MediaQuery.of(context).size.width / 6,
                                                                            height:MediaQuery.of(context).size.height / 10,
                                                                            decoration: BoxDecoration(gradient:LinearGradient(colors:[Color(0xFF3128CE),Color(0xFF3B8ACB)],begin:Alignment.topCenter,end:Alignment.bottomCenter),borderRadius: BorderRadius.only(topLeft: Radius.circular(MediaQuery.of(context).size.width / 20), topRight: Radius.circular(MediaQuery.of(context).size.width / 20), bottomLeft: Radius.circular(MediaQuery.of(context).size.width / 40), bottomRight: Radius.circular(MediaQuery.of(context).size.width / 20))),
                                                                            child: Center(
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  Image.asset("assets/images/cozumYukle.png",scale:10),
                                                                                  Text("Çözümü Yükle",textAlign:TextAlign.center,style:TextStyle(color:Colors.white))
                                                                                ],),
                                                                            ) ),

                                                                      ]

                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                              : Text(
                                                            "Fotoğraflarını yükle",
                                                            style: TextStyle(
                                                                color: questionChoosen &&
                                                                    !solutionChoosen
                                                                    ? Colors
                                                                    .white
                                                                    : Color(
                                                                    0xFF006E94)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.only(
                                                                right:
                                                                20.0),
                                                            child: Opacity(
                                                              opacity:
                                                              questionChoosen &&
                                                                  !solutionChoosen
                                                                  ? 1
                                                                  : 0.4,
                                                              child: GestureDetector(
                                                                onTap:()=>  questionChoosen&&solutionChoosingNow? () => solutChooseNext():()=>null,
                                                                child: Container(
                                                                  width: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      15,
                                                                  height: MediaQuery.of(
                                                                      context)
                                                                      .size
                                                                      .height /
                                                                      15,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      gradient: LinearGradient(
                                                                          colors:  [
                                                                            Color(
                                                                                0xFF6D5EFF),
                                                                            Color(
                                                                                0xFF00AC8A)
                                                                          ],
                                                                          begin: Alignment
                                                                              .topCenter,
                                                                          end: Alignment
                                                                              .bottomCenter)),
                                                                  child: Center(
                                                                    child: Icon(
                                                                      solutionChoosingNow
                                                                          ? Icons
                                                                          .arrow_forward
                                                                          : Icons
                                                                          .upload_rounded,
                                                                      size: MediaQuery.of(context)
                                                                          .size
                                                                          .height /
                                                                          22,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                          )
                                        ],
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                      "1",
                                      style: TextStyle(fontSize: 40),
                                    )),
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
          )
        ],
      ),
    );
  }

  topNumbers() {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 9,
          vertical: MediaQuery.of(context).size.height / 100),
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
                          Color(0xFFFF007F),
                          Color(0xFFFF9600)
                        ])),
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xFFFF9108),
                              Color(0xFFFF1771)
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
                      height: MediaQuery.of(context).size.height / 18,
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
                          Color(0xFFF600FF),
                          Color(0xFF392BFF)
                        ])),
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xFFF600FF),
                              Color(0xFFBD00FF)
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
                      height: MediaQuery.of(context).size.height / 18,
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
                          Color(0xFF392BFF),
                          Color(0xFF41C6FF)
                        ])),
                        height: 4,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(colors: [
                              Color(0xFF41C4FF),
                              Color(0xFF3E52FF)
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
                      height: MediaQuery.of(context).size.height / 18,
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
  }

  //BOTTOM SHEETS----------------------------
  void _dersModalBottomSheet(context) {
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      expand: false,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery.of(context).size.width / 10)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                "Ders Seç",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListView(
              reverse: false,
              shrinkWrap: true,
              controller: ModalScrollController.of(context),
              physics: ClampingScrollPhysics(),
              children: ListTile.divideTiles(
                      context: context,
                      tiles: MyStrings()
                          .classesTYT
                          .map((e) => ListTile(
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
    showMaterialModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      expand: false,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(MediaQuery.of(context).size.width / 10)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Text(
                  "Konu Seç",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListView(
                reverse: false,
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                physics: ClampingScrollPhysics(),
                children: ListTile.divideTiles(
                        context: context,
                        tiles: konular
                            .map((e) => ListTile(
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

  questChoose() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Text("Görsel Seç"),
            actions: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text("Kameradan Seç"),
                onPressed: () async {
                  if (await Permission.camera.isGranted) {
                  } else {
                    await Permission.camera.request();
                  }
                  final pickedFile =
                      await _picker.getImage(source: ImageSource.camera);
                  setState(() {
                    questionChoosen=false;
                    questLastFile = File(pickedFile.path);
                    questFileList.add(questLastFile);
                    Navigator.pop(context);
                    questionChoosingNow = true;
                  });
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text("Galeriden Seç"),
                onPressed: () async {
                  print(Permission.storage.status.toString());
                  if (Platform.isIOS) {
                    if (await Permission.storage.isGranted) {
                    } else {
                      await Permission.storage.request();
                    }
                  }
                  final pickedFile =
                      await _picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    questionChoosen=false;
                    questLastFile = File(pickedFile.path);
                    questFileList.add(questLastFile);
                    Navigator.pop(context);
                    questionChoosingNow = true;
                  });
                },
              ),
            ],
          );
        });
  }

  questChooseNext() async {
    setState(() {
      questionChoosingNow = false;
      questionChoosen=true;
    });
  }
  solutChoose() async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Text("Görsel Seç"),
            actions: [
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text("Kameradan Seç"),
                onPressed: () async {
                  if (await Permission.camera.isGranted) {
                  } else {
                    await Permission.camera.request();
                  }
                  final pickedFile =
                      await _picker.getImage(source: ImageSource.camera);
                  setState(() {
                    solutionChoosen=false;
                    solutLastFile = File(pickedFile.path);
                    solutFileList.add(solutLastFile);
                    Navigator.pop(context);
                    solutionChoosingNow = true;
                  });
                },
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text("Galeriden Seç"),
                onPressed: () async {
                  print(Permission.storage.status.toString());
                  if (Platform.isIOS) {
                    if (await Permission.storage.isGranted) {
                    } else {
                      await Permission.storage.request();
                    }
                  }
                  final pickedFile =
                      await _picker.getImage(source: ImageSource.gallery);
                  setState(() {
                    solutionChoosen=false;
                    solutLastFile = File(pickedFile.path);
                    solutFileList.add(solutLastFile);
                    Navigator.pop(context);
                    solutionChoosingNow = true;
                  });
                },
              ),
            ],
          );
        });
  }

  solutChooseNext() async {
    setState(() {
      solutionChoosingNow = false;
      solutionChoosen=true;
    });
  }
}
