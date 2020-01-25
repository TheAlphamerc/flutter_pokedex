import 'dart:math';

import 'package:flutter/material.dart';

Color setSecondaryColor(String type){
  if(type == null){
    return Color(0xfff79496);
  }
  type = type.toLowerCase();
    // return type.contains('Grass')  ? Color(0xff57dcc1) :
    //        type.contains('Water') ? Color(0xff84c9f3)  :
    //        type.contains('Rock')  ? Color(0xffd1dadf)  :
    //         Color(0xfffc7f7b);
     return type.contains('grass')  ? Color(0xff8ede54)  :
           type.contains('water') ? Color(0xFF58ABF6)  :
           type.contains('rock')  ? Color(0xffd5e1eb)  :
           type.contains('bug')  ? Color(0xff50f2d0):
           type.contains('normal')  ? Color(0xff9fc7b7)  :
           type.contains('poison')  ? Color(0xff5685f5)  :
           type.contains('electric')  ? Color(0xfffaf25f)  :
           type.contains('ground')  ? Color(0xfff0c37d)  :
           type.contains('ice')  ? Color(0xff7aedfa)  :
           type.contains('dark')  ? Color(0xffd3e0e0)  :
           type.contains('fairy')  ? Color(0xff9f71e3)  :
           type.contains('psychic')  ? Color(0xffce91eb)  :
           type.contains('fighting')  ? Color(0xff9cd44e)  :
           type.contains('ghost')  ? Color(0xff6d3bad)  :
            Color(0xfff79496);
  }
Color setprimaryColor(String type){
    if(type == null){
    return Color(0xfff79496);
  }
  type = type.toLowerCase();
    return type.contains('grass')  ? Color(0xff68c724)  :
           type.contains('water') ? Color(0xFF429BED)  :
           type.contains('rock')  ? Color(0xffbbc7d1)  :
           type.contains('bug')  ? Color(0xff4bcfb2) :
           type.contains('normal')  ? Color(0xff9AB8AC)  :
           type.contains('poison')  ? Color(0xff094be8)  :
           type.contains('electric')  ? Color(0xffe8dd09)  :
           type.contains('ground')  ? Color(0xffcf9b48)  :
           type.contains('ice')  ? Color(0xff1bcfe3)  :
           type.contains('dark')  ? Color(0xff9bbfbf)  :
           type.contains('fairy')  ? Color(0xff784abd)  :
           type.contains('psychic')  ? Color(0xffbc6ee0)  :
           type.contains('fighting')  ? Color(0xff72ab22)  :
           type.contains('ghost')  ? Color(0xff42206e)  :
            Color(0xfffc6b6d);
  }
  
Color getRendomColor(int index){
  List<Color> list = [
          Color(0xff75bffc)  
         , Color(0xffbbc7d1)  
        //  , Color(0xff4bcfb2) 
        // ,  Color(0xff68c724)  
        //  , Color(0xff9AB8AC)  
        //  , Color(0xffe8dd09)  
        //  , Color(0xffcf9b48)  
         , Color(0xff1bcfe3)  
        //  , Color(0xff9bbfbf)  
        //  , Color(0xffbc6ee0)  
        //  , Color(0xff72ab22)  
          ];
         var no =index == 0 ? 0 :  index % 3 ;
        //  var  index = Random().nextInt(14);
         return list[no];
  }
class AppColors{
  AppColors._();
  static  Color pokeballColor =  Color(0xfff2f2f2);
}
