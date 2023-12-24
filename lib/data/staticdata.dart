import 'dart:ui';

class StaticData {
  static const String urlConnectionConst =
      'http://localhost:5000/api/'; //10.0.15.117 10.9.100.225:7011   10.0.65.51:7001   10.0.65.164
  static const String urltransportationFeeAdd =
      '${urlConnectionConst}transportationFee/add';
//http://localhost:5000/api/transportationFee/add
////////////////////////// textDirection /////////////////////
  static const arabicTextDirection = TextDirection.rtl;
  static const englishTextDirection = TextDirection.ltr;
////////////////////   Images path  //////////////////////////////////
  static const String imageLogo = 'assets/images/logo.PNG';
  static const String imageDrawer =
      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg';
  static const String drawerImage = 'assets/images/drawerImage.png';
  static const Color button = Color(0xFFD5AA6D);
  static const Color font = Color(0xFF200908);
  static const Color appBarColor = Color(0xFF200908);
  static const Color backgroundColors = Color(0xFFfcfcfc);
  static const Color borderTextFieldColor = Color(0xFF200908);

//////////////////// font family ///////////////////
  static String fontFamily = "Cairo";
}
