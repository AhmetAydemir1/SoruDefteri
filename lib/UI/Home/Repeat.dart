import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:soru_defteri/UI/SoruIci.dart';

class Repeat extends StatefulWidget {
  @override
  _RepeatState createState() => _RepeatState();
}

class _RepeatState extends State<Repeat> {

  User user=FirebaseAuth.instance.currentUser;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                shadowColor: Color(0xFF6E719B),
                backgroundColor: Color(0xFF6E719B),
                title: Text("Tekrar Yap"),
              ),
              body: StreamBuilder(
                stream: FirebaseFirestore.instance.collection("Sorular").where("paylasanID",isEqualTo: user.uid).orderBy("date",descending: true).snapshots(),
                builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.hasData){
                    print(snapshot.data.docs.first);
                    return ListView(
                      children: snapshot.data.docs.map((e) => ListTile(
                        title: Text(e["ders"]),
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SoruCoz(doc: e,docList: snapshot.data.docs,))),
                      )).toList(),
                    );
                  }else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
              ),
            ),
        ),
    );
  }
}
