import 'package:flutter/material.dart';

Color setSecondaryColor(String type){
    return type.contains('Grass')  ? Color(0xff57dcc1) :
           type.contains('Water') ? Color(0xff84c9f3)  :
           type.contains('Rock')  ? Color(0xffd1dadf)  :
            Color(0xfffc7f7b);
  }
  Color setprimaryColor(String type){
    return type.contains('Grass')  ? Color(0xff4bcfb2) :
           type.contains('Water') ? Color(0xff75bffc)  :
           type.contains('Rock')  ? Color(0xffbbc7d1)  :
            Color(0xfffc6b6d);
  }