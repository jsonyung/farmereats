
import 'package:flutter/material.dart';

class MyColors{

 //static Color customGrey = const Color(0xFFE9E9E9);


 static Color customGreyLight = const Color.fromARGB(255, 238, 237, 236);
 static Color customGreyDark= const Color.fromARGB(255, 38, 28, 18);
 //static Color customRed = const Color.fromARGB(255, 213, 113, 91);
 static Color customOrange = const Color.fromARGB(255, 248, 197, 105);
 static Color customGreen = const Color.fromARGB(255, 94, 162, 95);

 static const int _customRedPrimaryValue = 0xFFD5715B;

 static const MaterialColor customRed = MaterialColor(
  _customRedPrimaryValue,
  <int, Color>{
   50: Color(0xFFFFEBE5),
   100: Color(0xFFFFC7BF),
   200: Color(0xFFFFA193),
   300: Color(0xFFFF7B67),
   400: Color(0xFFFF5B49),
   500: Color(_customRedPrimaryValue),
   600: Color(0xFFC65043),
   700: Color(0xFFB9473C),
   800: Color(0xFFAC3F34),
   900: Color(0xFF942E27),
  },
 );



}
