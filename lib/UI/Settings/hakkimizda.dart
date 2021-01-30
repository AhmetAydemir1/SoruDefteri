import 'package:flutter/material.dart';

class Hakkimizda extends StatefulWidget {
  @override
  _HakkimizdaState createState() => _HakkimizdaState();
}

class _HakkimizdaState extends State<Hakkimizda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6E719B),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFF6E719B),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text("Ayarlar"),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset("assets/images/hakkimizda.png",fit: BoxFit.fitWidth,),
                      Padding(padding: EdgeInsets.all(20),child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\n\nBibendum est ultricies integer quis. Iaculis urna id volutpat lacus laoreet. Mauris vitae ultricies leo integer malesuada.\n\nAc odio tempor orci placerat orci nulla. Tincidunt ornare massa eget egestas purus viverra accumsan in nisl. Tempor id eu nisl nunc mi ipsum faucibus. Fusce id velit ut tortor pretium.\n\nErat velit scelerisque in dictum non consectetur a erat. Amet nulla facilisi morbi tempus iaculis urna. Egestas purus viverra accumsan in nisl. Feugiat in ante metus dictum at tempor commodo. Convallis tellus id interdum velit laoreet.",style: TextStyle(color: Colors.white),),),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Image.asset("assets/images/justLabel.png",scale: 4,),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}
