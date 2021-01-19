import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';

class QuestionWall extends StatefulWidget {
  @override
  _QuestionWallState createState() => _QuestionWallState();
}

class _QuestionWallState extends State<QuestionWall> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(Emoji.all().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFF6E719B),
        child: SafeArea(
            bottom: false,
            child: Scaffold(
              backgroundColor: Color(0xFF6E719B),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                title: Text("Soru Duvarı"),
              ),
              body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Sorular")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                decoration: BoxDecoration(
                                    gradient: myGradient()),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal:15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(Icons.favorite,color: Colors.white,size: 35,),
                                          Column(
                                            children: [
                                              SizedBox(height: 10,),
                                              Text(e["ders"]+" - "+e["sinav"],style: TextStyle(color: Color(0xFF41C6FF)),),
                                              Text(e["konu"],style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                                              Text(e["yayinEvi"],style: TextStyle(color: Color(0xFF00AE87)),),
                                            ],
                                          ),
                                          SizedBox(width: 35,)
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal:30.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),gradient: LinearGradient(colors: [Color(0xFF6E719B),Color(0xFF8082A7)],begin: Alignment.topCenter,end: Alignment.bottomCenter)),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                              child: Text("Soru",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            width: 80,
                                            child: Align(
                                              alignment:Alignment.topRight,
                                              child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                physics: NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: e["zorluk"],
                                                itemBuilder: (context,index){
                                                  return Icon(Icons.star,size: 20,color: Colors.yellow,);
                                                },
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 4),
                                      child: Container(
                                        height: MediaQuery.of(context).size.height/2.4,
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)),
                                              child: CachedNetworkImage(
                                                progressIndicatorBuilder: (context,url,progress){

                                                  print("${progress.progress.toString()}");

                                                  return Center(child: CircularProgressIndicator(value: progress.progress,));
                                                },
                                                imageUrl: e["soruFotos"][0],
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
                                                      top: Radius.circular(20)),
                                              gradient: LinearGradient(
                                                  colors: [
                                                    Colors.white,
                                                    Color(0xFFCDCEDC)
                                                  ],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter)),
                                          width: double.maxFinite,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top: Radius.circular(20)),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(e["ipucu"],
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF6E719B))),
                                              ))),
                                    ),
                                    SizedBox(height: 5,),
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal:17.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Color(0xFF41C6FF)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                  child: Text("Soru",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                                ),
                                              ),
                                              SizedBox(width: 2,),
                                              Container(
                                                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Color(0xFFA3A6BF)),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                  child: Text("Çözüm",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Text("155",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                  Text(Emoji.byName("smiling face with smiling eyes").toString(),style: TextStyle(fontSize: 30),),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("155",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                  Text(Emoji.byName("grinning squinting face").toString(),style: TextStyle(fontSize: 30)),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text("155",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                  Text(Emoji.byName("crying face").toString(),style: TextStyle(fontSize: 30)),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text("155",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                  Text(Emoji.byName("angry face").newSkin(fitzpatrick.None).toString(),style: TextStyle(fontSize: 30)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 3,)

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
              ),
            )));
  }

  myGradient(){
    return LinearGradient(
        colors: [
          Color(0xFF8C8FB0),
          Color(0xFF6E719B),
          Color(0xFF6E719B),
          Color(0xFF8C8FB0),
        ],
        stops: [
          0.1,
          0.4,
          0.6,
          0.9
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter);
  }
}
