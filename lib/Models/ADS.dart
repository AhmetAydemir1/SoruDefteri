import 'dart:io';


class AdMob{
  String getAppID(){
    if(Platform.isAndroid){
      //return "ca-app-pub-5838462795272260~8935341658";
      return "ca-app-pub-3940256099942544~3347511713";//test
    }else if(Platform.isIOS){
      return "ca-app-pub-5838462795272260~6963784438";
      //return "ca-app-pub-3940256099942544~1458002511";//test
    }
    return null;
  }

  String gecisID(){
    if(Platform.isAndroid){
      return "ca-app-pub-5838462795272260/3271951431";
      //return "ca-app-pub-3940256099942544/1033173712";//test
    }else if(Platform.isIOS){
      return "ca-app-pub-5838462795272260/4066158350";
      //return "ca-app-pub-3940256099942544/1033173712";//test
    }
    return null;
  }
  String odulluReklam(){
    if(Platform.isAndroid){
      //return "ca-app-pub-5838462795272260/9387069111";
      return "ca-app-pub-3940256099942544/5224354917";//test
    }else if(Platform.isIOS){
      return "ca-app-pub-5838462795272260/8080908064";
      //return "ca-app-pub-3940256099942544/5224354917";//test
    }
    return null;
  }

}