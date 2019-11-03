import 'package:flutter/material.dart';

Color setSecondaryColor(String type){
    // return type.contains('Grass')  ? Color(0xff57dcc1) :
    //        type.contains('Water') ? Color(0xff84c9f3)  :
    //        type.contains('Rock')  ? Color(0xffd1dadf)  :
    //         Color(0xfffc7f7b);
     return type.contains('Grass')  ? Color(0xff8ede54)  :
           type.contains('Water') ? Color(0xff98cbf5)  :
           type.contains('Rock')  ? Color(0xffd5e1eb)  :
           type.contains('Bug')  ? Color(0xff50f2d0):
           type.contains('Normal')  ? Color(0xff9fc7b7)  :
           type.contains('Poison')  ? Color(0xff5685f5)  :
           type.contains('Electric')  ? Color(0xfffaf25f)  :
           type.contains('Ground')  ? Color(0xfff0c37d)  :
           type.contains('Ice')  ? Color(0xff7aedfa)  :
           type.contains('Dark')  ? Color(0xffd3e0e0)  :
           type.contains('Fairy')  ? Color(0xff9f71e3)  :
           type.contains('Psychic')  ? Color(0xffce91eb)  :
           type.contains('Fighting')  ? Color(0xff9cd44e)  :
           type.contains('Ghost')  ? Color(0xff6d3bad)  :
            Color(0xfff79496);
  }
  Color setprimaryColor(String type){
    return type.contains('Grass')  ? Color(0xff68c724)  :
           type.contains('Water') ? Color(0xff75bffc)  :
           type.contains('Rock')  ? Color(0xffbbc7d1)  :
           type.contains('Bug')  ? Color(0xff4bcfb2) :
           type.contains('Normal')  ? Color(0xff9AB8AC)  :
           type.contains('Poison')  ? Color(0xff094be8)  :
           type.contains('Electric')  ? Color(0xffe8dd09)  :
           type.contains('Ground')  ? Color(0xffcf9b48)  :
           type.contains('Ice')  ? Color(0xff1bcfe3)  :
           type.contains('Dark')  ? Color(0xff9bbfbf)  :
           type.contains('Fairy')  ? Color(0xff784abd)  :
           type.contains('Psychic')  ? Color(0xffbc6ee0)  :
           type.contains('Fighting')  ? Color(0xff72ab22)  :
           type.contains('Ghost')  ? Color(0xff42206e)  :
            Color(0xfffc6b6d);
  }
  