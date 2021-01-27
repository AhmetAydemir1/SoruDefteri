import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emojis/emoji.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuestionWall extends StatefulWidget {
  @override
  _QuestionWallState createState() => _QuestionWallState();
}

class _QuestionWallState extends State<QuestionWall> {

  List cozumGosterList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  User user=FirebaseAuth.instance.currentUser;

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
                    .collection("EditorSorular").orderBy("date",descending: true)
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
                                          GestureDetector(
                                            onTap:()async{
                                              await FirebaseFirestore.instance.collection("EditorSorular").doc(e.id).get().then((doc)async{
                                                List liked=[];
                                                if(doc.data().containsKey("liked")){
                                                  liked=doc["liked"];
                                                  if(doc["liked"].contains(user.uid)){
                                                    liked.remove(user.uid);
                                                    await FirebaseFirestore.instance.collection("EditorSorular").doc(e.id).set({"liked":liked},SetOptions(merge:true));
                                                  }else{
                                                    liked.add(user.uid);
                                                    await FirebaseFirestore.instance.collection("EditorSorular").doc(e.id).set({"liked":liked},SetOptions(merge:true));
                                                  }
                                                }else{
                                                  liked.add(user.uid);
                                                  await FirebaseFirestore.instance.collection("EditorSorular").doc(e.id).set({"liked":liked},SetOptions(merge:true));
                                                }
                                              });
                                              },
                                            child: e.data().containsKey("liked") && e["liked"].contains(user.uid)
                                                ? Icon(Icons.favorite,color: Colors.white,size: 35,)
                                                : Icon(Icons.favorite_border,color: Colors.white,size: 35,),
                                          ),
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
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                                gradient: LinearGradient(
                                                    colors: [Color(0xFF6E719B),Color(0xFF8082A7)],
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter
                                                ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                              child: Text(!cozumGosterList.contains(
                                                  e.id)?"Soru":"Çözüm",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
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
                                                imageUrl: !cozumGosterList.contains(e.id) ? e["soruFotos"][0]:e["cozumFotos"][0],
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
                                              GestureDetector(
                                                onTap: (){
                                                  setState(() {
                                                    if(cozumGosterList.contains(e.id)){
                                                      cozumGosterList.remove(e.id);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color:!cozumGosterList.contains(
                                                      e.id)? Color(0xFF41C6FF):Color(0xFFA3A6BF)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                    child: Text("Soru",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                                  ),
                                                ),
                                              ),
                                              e.data().containsKey("cozumFotos")&&e["cozumFotos"].isNotEmpty? SizedBox(width: 2,):Container(),
                                              e.data().containsKey("cozumFotos")&&e["cozumFotos"].isNotEmpty? GestureDetector(
                                                onTap:() {
                                                  setState(() {
                                                    if (!cozumGosterList.contains(
                                                        e.id)) {
                                                      cozumGosterList.add(
                                                          e.id);
                                                    }
                                                  });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color:!cozumGosterList.contains(
                                                      e.id)? Color(0xFFA3A6BF):Color(0xFF41C6FF)),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                                                    child: Text("Çözüm",style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white),),
                                                  ),
                                                ),
                                              ):Container(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: ()=>emojiBirak(e.id, "smiling"),
                                                child: Column(
                                                  children: [
                                                    Text(e.data().containsKey("smiling")&&e["smiling"]!=null?e["smiling"].length.toString():"0",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                    Text(Emoji.byName("smiling face with smiling eyes").toString(),style: TextStyle(fontSize: 30),),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: ()=>emojiBirak(e.id, "grinning"),
                                                child: Column(
                                                  children: [
                                                    Text(e.data().containsKey("grinning")&&e["grinning"]!=null?e["grinning"].length.toString():"0",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                    Text(Emoji.byName("grinning squinting face").toString(),style: TextStyle(fontSize: 30)),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: ()=>emojiBirak(e.id, "crying"),
                                                child: Column(
                                                  children: [
                                                    Text(e.data().containsKey("crying")&&e["crying"]!=null?e["crying"].length.toString():"0",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                    Text(Emoji.byName("crying face").toString(),style: TextStyle(fontSize: 30)),
                                                  ],
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: ()=>emojiBirak(e.id, "angry"),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    Text(e.data().containsKey("angry")&&e["angry"]!=null?e["angry"].length.toString():"0",style: TextStyle(fontSize: 10,color: Colors.white),),
                                                    Text(Emoji.byName("angry face").newSkin(fitzpatrick.None).toString(),style: TextStyle(fontSize: 30)),
                                                  ],
                                                ),
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

  emojiBirak(String docID,String emojiName)async{
    await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).get().then((doc)async{
      if(doc.data().containsKey("angry")&&doc["angry"].contains(user.uid)){
        await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({"angry":FieldValue.arrayRemove([user.uid])});
      }
      if(doc.data().containsKey("crying")&&doc["crying"].contains(user.uid)){
        await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({"crying":FieldValue.arrayRemove([user.uid])});
      }
      if(doc.data().containsKey("grinning")&&doc["grinning"].contains(user.uid)){
        await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({"grinning":FieldValue.arrayRemove([user.uid])});
      }
      if(doc.data().containsKey("smiling")&&doc["smiling"].contains(user.uid)){
        await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({"smiling":FieldValue.arrayRemove([user.uid])});
      }
      if (doc.data().containsKey(emojiName)) {
        if(doc[emojiName].contains(user.uid)){
          await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({emojiName:FieldValue.arrayRemove([user.uid])});
        }else{
          await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({emojiName:FieldValue.arrayUnion([user.uid])});
        }
      } else {
        await FirebaseFirestore.instance.collection("EditorSorular").doc(docID).update({emojiName:FieldValue.arrayUnion([user.uid])});
      }
    });
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
