import 'package:flutter/material.dart';

class Hakkimizda extends StatefulWidget {
  @override
  _HakkimizdaState createState() => _HakkimizdaState();
}

class _HakkimizdaState extends State<Hakkimizda> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF6453F6),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Color(0xFF6453F6),
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
                      Padding(padding: EdgeInsets.all(20),child: Text("Üniversiteye hazırlık sürecini çok kez deneyimlemiş; sınava hazırlanan bir öğrencinin nelere ihtiyacı olduğunu uzun uzaya düşünmüş bir ekip olarak bu uygulamayı senin için geliştirdik.\nSınav senesinde zaman kıymetlidir, biliyoruz. Yapadıklarını biriktirmek istersin, çözümü öğrenmek istersin, geri döneceğim dersin. Zamanla biriken sorular başa çıkılamaz hale gelir. Soracak birini bulmak da zorlaşmaya başlar. Üstelik, birine sorsan bile, eksiğini öğrenmek çaba ve tekrar isteyen bir süreçtir. Bu planla yola çıkmışken, yapamadığın soruları ve hoşuna giden soruları çoğu zaman ikinci sefer göremezsin, çünkü zaman azdır ama yapılacak işin çoktur. Tekrar yapmadığındaysa çözüm ayrıntılarını tam kavrayamayızsın.\nSoru Defterim app tam olarak bu sorununu çözmek için geliştirildi!\n\nBize ulaşmak istersen, www.sorudefteriapp.com adresini ziyaret edebilir veya Sorudefterimapp sosyal medya hesapları üzerinden ulaşabilirsin.",style: TextStyle(color: Colors.white),),),
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
