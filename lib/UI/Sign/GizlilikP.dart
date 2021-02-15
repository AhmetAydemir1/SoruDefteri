import 'package:flutter/material.dart';

class GizlilikP extends StatefulWidget {
  @override
  _GizlilikPState createState() => _GizlilikPState();
}

class _GizlilikPState extends State<GizlilikP> {
  @override
  Widget build(BuildContext context) {
    return Container(      color: Color(0xFF6453F6),

      child: SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xFF6453F6),
          appBar: AppBar(
            shadowColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            title: Text(
              "Gizlilik Politikası",
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:10.0),
                    child: Text.rich(
                      TextSpan(
                        text: '\nGizlilik Sözleşmesi\n\n',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '''Madde 1 : Taraflar
İşbu Kullanıcı Sözleşmesi ("Sözleşme"); bir tarafta www.sorudefteriapp.com adresindeki internet sitesi ve sahip olduğu Soru Defterim mobil iOS ve Andriod uygulamaları (bundan böyle topluca “Soru Defterim ” olarak anılacaktır ); ile diğer tarafta bilgileri Soru Defterim mobil iOS veya Android uygulamaları üzerinden belirtilen tüm tek kişi ve tüzel kişi üyeler (“Kullanıcı”) arasında aşağıdaki hüküm ve şartlar çerçevesinde akdedilmektedir.

Madde 2 : Sözleşme'nin Konusu
İsbu Sözleşme, Kullanıcı'nın Soru Defterim mobil iOS veya Andriod uygulama tarafından sunulan eğitim kalitesini iyileştirmek, soru arşivi oluşturmak amacı ile düzenlenmiş olup, anılan ilişki kapsamında tarafların karşılıklı hak ve yükümlülüklerini tespit etmektedir.

Madde 3 : Kayıt Oluşturma
3.1.Kullanıcı, e-posta ve belirlediği şifre ile Soru Defterim mobil uygulama’nın Profil Girişi ekranından giriş yapabilecektir. Aynı zamanda Kullanıcı’ya Soru Defterim mobil uygulama’nın Profil Girişi ekranında "Şifremi Unuttum" ve "Hesap Oluştur" seçenekleri sunulacaktır. Kullanıcı, Soru Defterim mobil uygulama’nın Profil Girişi ekranında hatalı bir giriş yapması halinde ilgili ekrana uyarı mesajı gelecektir.
3.2. Kullanıcı’nın Soru Defterim mobil uygulama’nın Profil Girişi ekranından "Şifremi Unuttum" seçeneğini tıklaması halinde, açılan Soru Defterim mobil uygulama’nın Şifre Yenileme ekranından e-posta adresi istenecek ve "Gönder" butonuna basıldığı takdirde Kullanıcı‘nın şifresini yenilemesi için daha önceden Soru Defterim mobil uygulama’ya girmiş olduğu e-posta adresine bir onay kodu gönderilecektir. Kullanıcı, e-posta adresine gönderilen onay kodunu Soru Defterim mobil uygulama’nın Şifre Onaylama ekranına girerek şifre değiştirme işlemini gerçekleştirmiş olacaktır ve Kullanıcı’nın şifresinin başarılı olarak değiştirildiği hakkında ekrana mesaj gelecektir.
3.3. Kullanıcı, Soru Defterim mobil uygulama’nın Girişi ekranından "Hesap Oluştur" seçeneğini tıklaması halinde, açılan Soru Defterim mobil uygulama’nın Hesap Oluştur ekranın kayıt formundan Ad, Soyad, E-posta, Telefon Numarası, ve kendine özel bir Şifre bilgilerini girerek kayıt oluşturabilecek. Soru Defterim mobil uygulama’nın Hesap Oluştur kayıt formunda tüm bilgiler Kullanıcı tarafından girilmesi zorunludur. Kullanıcı, Soru Defterim mobil uygulama’nın Hesap Oluştur ekranında hatalı bir giriş yapması halinde ilgili ekrana uyarı mesajı gelecektir.
3.4. Kullanıcı, Soru Defterim mobil uygulama’nın sunduğu hizmetlerin, 4 yaşından küçükler tarafından kullanılmayacağını ve 4 yaşından küçük olanların Soru Defterim mobil uygulama’nın Hesap Oluştur ekranında kayıt oluşturmayacağını; buna bağlı olarak, kendisinin de 4 yaşından büyük olduğunu kabul, beyan ve taahhüt etmektedir.

Madde 4 : Kullanıcı'nın Hak & Yükümlülükleri
4.1.Kullanıcı, Soru Defterim mobil uygulama’nın Hesap Oluştur ekranında kullanacağı e-posta ve şifre ile sadece bir tek kişi veya tüzel kişi için kayıt işlem yapma hakkına sahiptir. Diğer tek kişi veya tüzel kişi üyeler Soru Defterim mobil uygulama’dan yararlanmak için ayrıca kayıt işleminin yapılması ve başka bir e-posta ve şifrenin alınması ile gerçekleştirilecektir.
4.2. Kullanıcı, Soru Defterim mobil uygulama’nın Hesap Oluştur ekranındaki kayıt oluşturma işleminde vereceği bilgilerin hukuka uygun ve doğru olmasından tamamen sorumlu olduğunu ve bu bilgilerin hatalı veya noksan olmasından doğacak zararlardan dolayı da Soru Defterim hiçbir sebeple sorumlu olmadığını kabul, beyan, ve taahhüt etmektedir. Hatalı veya noksan bilgilerin sıkıntı veya problem oluşturduğu şartlarda Soru Defterim , Kullanıcı’nın kaydını sona erdirme hakkına sahiptir.
4.3. Kullanıcı, Soru Defterim mobil uygulama’nın Hesap Oluştur ekranındaki kayıt oluşturma işleminde verdiği bilgileri veya şifre yenileme işlemlerini istediği zaman Soru Defterim mobil uygulama’nın Hesabım ekranından dilediği şekilde değiştirilebilir. Şifre, sadece Kullanıcı tarafından bilinir ve şifrenin seçimi ve korunmasının sorumluluğu tamamen Kullanıcı’ya ait olacaktır. Soru Defterim , şifre kullanımından doğacak problemlerden sorumlu değildir.
4.4. . Kullanıcı, Soru Defterim mobil uygulama’dan elde ettiği hizmet ve bilgileri olumsuz kullanarak aşağıda yer alan yasaklanmış eylemlerde bulunmayacağını kabul, beyan ve taahhüt etmektedir;
• Hakaret ve iftira edici davranışta bulunmak,
• Yasadışı faaliyetleri teşvik edici faaliyette bulunmak ve içerik yayınlamak,
• Yürürlükteki ve ileride yürürlüğe girecek her türlü mevzuat kapsamında yasak olan her türlü faaliyette bulunmak.
4.5. . Kullanıcı’nın kendi yapmış olduğu APPSTORE ve GOOGLE PLAY aboneliği, kulanım, ve gizlilik koşullarından Soru Defterim sorumlu değildir.
4.6. . Kullanıcı, Soru Defterim mobil uygulama’nın üzerinden sunulan hizmetlerin ve kullanılan yazılımların telif hakkının Soru Defterim ‘e ve/veya Soru Defterim ‘e lisans veren veya içerik sağlayan kişilere ait olduğunu, fikri mülkiyet hukuku kapsamında korunduğunu; ihlali durumunda Kullanıcı’nın sorumlu olacağını; bu yazılımları ya da servisleri hiçbir şekilde izinsiz çoğaltıp dağıtmayacağını, yayınlamayacağını, pazarlamayacağını kabul, beyan, ve taahhüt etmektedir.
4.7. .Kullanıcı, www.sorudefteriapp.com internet sitesine zarar verecek veya Soru Defterim ’i başka internet siteleriyle ya da üçüncü kişilerle ihtilaflı duruma getirecek herhangi bir yazılım veya materyal bulunduramayacağını, paylaşamayacağını ve herhangi bir şekilde bir hukuka aykırı durum doğarsa bunun hukuki ve cezai sorumlulukların tümünü üzerine aldığını kabul, beyan, ve taahhüt etmektedir.
Madde 5 : Soru Defteri'nin Hak & Yükümlülükleri
5.1.Kullanıcı, SoruDefterim mobil uygulamasında kayıt oluşturabilecek ancak Soru Defterim işbu Sözleşme konusu hizmetten yararlanmak isteyen herhangi bir Kullanıcı’nın başvurusunu kabul etmeme hakkını saklı tutmaktadır. Soru Defterim diğer tüm hakları saklı kalmak kaydıyla, kayıtlı Kullanıcı’nın hesabını askıya alma veya durdurma hakkına sahiptir.
5.2. Kullanıcı’nın Soru Defteri mobil uygulama’dan edindiği bilgilerden dolayı aldığı karar ve hareketlerinden, uğradığı veya uğrayabileceği maddi ve/veya manevi zararlarından, herhangi bir tutum ve davranışlarından Soru Defteri sorumlu değildir.
5.3. Soru Defteri mevcut her tür hizmet, ürün, kullanma koşulları ile www.sorudefteriapp.com internet sitesi ve/veya Soru Defteri mobil uygulama’da sunulan bilgileri önceden bir ihtara gerek olmaksızın değiştirme, yeniden organize etme, yayını durdurma hakkını saklı tutar.
5.4. Soru Defteri mobil uygulamanın ve kendisine ait yayınlanan www.sorudefteriapp.com internet sitesinin tüm içerikleri ve içeriğine ilişkin her türlü görüntü, yazı, belge ve her türlü fikri ve sınai haklar ile tüm telif hakları ve diğer fikri ve sinai mülkiyet hakları Soru Defterim’e aittir.
5.5. Soru Defteri mobil uygulamada bulunan hiçbir yazı; önceden izin alınmadan ve kaynak gösterilmeden, kod ve yazılım da dahil olmak üzere, değiştirilemez, kopyalanamaz, çoğaltılamaz, başka bir lisana çevrilemez, yeniden yayımlanamaz, başka bir bilgisayara yüklenemez, postalanamaz, iletilemez, sunulamaz ya da dağıtılamaz, bütünü veya bir kısmı kaynak gösterilmeden başka bir web sitesinde veya uygulamada izinsiz olarak kullanılamaz.
5.6. . Soru Defteri mobil uygulamanın veri tabanına veya www.sorudefteriapp.com internet sitesine yapılacak herhangi bir saldırı sonucunda, kayıt bilgilerinin kötü amaçlı kullanıcıların eline geçmesinden ve bu bilgilerin kullanılması halinde doğabilecek sonuçlardan Soru Defteri sorumlu tutulamaz.
Madde 6 : Kişisel Verilerin Korunması
6.1. E-posta iletişimlerinde, mesaj şifrelenmediği takdirde, mesajın güvenliği garanti altına alınamadığı için, gönderilecek e-postaların güvenliğinden Kullanıcı sorumludur.
6.2. Kullanıcıların kişisel verileri Soru Defterim tarafından, Kişisel Verilerin Korunumu Kanunu olarak bilinen 24/3/2016 tarihli TBMM kararına göre 6698 sayılı Kanun kapsamında hazırlanan koşullar altında korumaktadır. Soru Defteri , Kullanıcı’nın Sözleşme konusu kişisel bilgilerini yasal zorunluluklar ve hizmetlerini yerine getirmek amacıyla zorunlu olduğu haller haricinde üçüncü kişilerle paylaşmayacaktır. Her halükarda ilgili paylaşımlar, Kişisel Verilerin Korunumu Kanunu olarak bilinen 24/3/2016 tarihli TBMM kararına göre 6698 sayılı Kanun uyarınca uygun olarak yapılmaktadır.
6.3. . Soru Defteri kullanıcılarının verdiği ve veri tabanında saklı tutulan bilgileri Kişisel Verilerin Korunumu Kanunu olarak bilinen 24/3/2016 tarihli TBMM kararına göre 6698 sayılı Kanun kapsamında hazırlanan koşullar altında, usulüne uygun olarak istatistiksel bilgilere dönüştürmek, reklam ve pazarlama alanında kullanmak, sanal platform kullanıcılarının genel eğilimlerini belirlemek, içeriğini ve hizmetlerini genişletmek için kullanabilme hakkına sahip olacaktır.
Madde 7 : Yürürlülük & Yetkili Mahkemeler
7.1. Kullanıcı, Soru defterim mobil uygulama’da sunulan hizmetlerden (belirli bir bedel ödeyerek ya da bedelsiz olarak) yararlanarak veya herhangi bir şekilde uygulamaya erişim sağlayarak 18 yaşından büyük olduğunu veya reşit olmayıp ebeveynlerinin ya da kendilerine bakmakla yükümlü bir kişinin yasal onayına sahip olduğunu; işbu Sözleşme'nin tamamını okuduğunu ve içeriğini tamamıyla anladığını ve tüm maddelerini kayıtsız şartsız kabul ederek onayladığını peşinen kabul, beyan, ve taahhüt etmektedir. Kullanıcı, Soru Defteri tarafından işbu Sözleşme hükümlerinde yapılan her değişikliği önceden kabul etmiş sayılmaktadır.
7.2. . İşbu Sözleşme’nin uygulanmasından doğabilecek her türlü uyuşmazlıkların çözümünde Amerika Birleşik Devletleri Tahkim Yasası, diğer uygulanabilir federal yasalar ve Kaliforniya eyaleti yasaları yetkilidir.
Madde 8 : Fesih
Soru Defteri , Kullanıcı’nın bu koşullar dâhilinde belirtilen hükümlere ve Soru Defteri mobil uygulama içinde yer alan kullanıma ve Soru Defteri hizmetlerine ilişkin benzeri kurallara aykırı hareket etmesi durumunda; Sözleşme’yi tek taraflı olarak feshedebilecektir. Ayrıca Kullanıcı, Soru Defteri mobil uygulama’daki kaydını sona erdirme ve işbu Sözleşme kapsamında verdiği kişisel bilgilerinin silinmesini veya yok edilmesini talep edebilir.

Madde 9 : Üyelik Türleri ve ücret
9.1. Uygulamaya kayıt olan üyeler belirli bir süre veya özellik için sınırlı olarak kullanım sağlarlar.
9.2. Premium üyeler uygulamadan sınırsız yararlanmak için aylık ya da belirli bir dönem için bir ücret öder. Aylık üyelikler 1 aylık periyodlarda devam eder ve kullanıcı ödemeyi her periyodun başında yaparak Premium üyeliğini aktif tutar. Soru Defteri ücretlerinde değişiklik yapılabilir.

İletişim
Kullanıcılar işbu Kullanıcı Sözleşmesi hakkındaki sorular, yorumlar, ve talepleri için her zaman www.sorudefteriapp.com adresinden yetkililer ile iletişime geçebilirler.''',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),


                          ),
                        ],
                      ),
                    )
                    ,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:20.0),
                child: Container(
                  height: 45.0,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          color: Color(0xFF00AE87),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 1.5,
                            minHeight: 45.0),
                        alignment: Alignment.center,
                        child: Text(
                          "KABUL ET VE DEVAM ET",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
