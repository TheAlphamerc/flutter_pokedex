import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';

Widget customText(String msg, {TextStyle style,TextAlign textAlign = TextAlign.justify,overflow = TextOverflow.clip,BuildContext context}){

  if(msg == null){
    return SizedBox(height: 0,width: 0,);
  }
  else{
    if(context != null && style != null){
      style =  style.copyWith(fontSize: style.fontSize - ( fullWidth(context) <= 375  ? 5 : 0));
    }
    return Text(msg,style: style,textAlign: textAlign,overflow:overflow,);
  }
}
double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
} 
double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
} 
 dynamic customAdvanceNetworkImage(String path){
   return AdvancedNetworkImage(
     path,
     useDiskCache: true,
     printError: true,
     fallbackAssetImage: 'assets/images/pokeball.png',
     loadFailedCallback: (){
       print(' Image load failed' + path);
     },
     cacheRule: CacheRule(
     maxAge: const Duration(days: 7)
  ),);
}