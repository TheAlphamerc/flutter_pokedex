import 'package:flutter/material.dart';
import '../../../helper/colorTheme.dart';
import '../../../widgets/customWidget.dart';
class GenerationModel extends StatelessWidget {
  const GenerationModel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: .6,
      initialChildSize: .48,
      minChildSize: .3,
      builder: (context,scrollController){
        return  Container(
           width: fullWidth(context),
           child: Container(
            width: fullWidth(context),
            margin: EdgeInsets.only(top: getFontSize(context, 30)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              color: Colors.white
            ),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:10),
                  width: fullWidth(context) * .3,
                  height: 3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: AppColors.pokeballColor
                  ),
                ),
                SizedBox(height: 20,),
                Text('Generation', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 10,),
                 Expanded(
                 child: GridView.builder(
                   padding: EdgeInsets.all(20),
                   controller: scrollController,
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     childAspectRatio: 1.55,
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10,
                   ),
                   itemCount: 6,
                   itemBuilder: (context, index) =>  _generations(context,index),
                 ),
            ),
          ],
         ),
       ),
          
   );
      },
    );
  }
  Widget _generations(BuildContext context,int index){
    String generation;
    switch (index) {
      case 0: generation = "I"; break;
      case 1: generation = "II"; break;
      case 2: generation = "III"; break;
      case 3: generation = "IV"; break;
      case 4: generation = "V"; break;
      case 5: generation = "VI"; break;
      default:generation = "I"; break;
    }
    return Container(
      margin:EdgeInsets.symmetric(horizontal: 0,vertical: 0) ,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: <BoxShadow>[
             BoxShadow(blurRadius: 10,offset: Offset(2, 5),color: Color(0xfff4f4f4),spreadRadius:10),
          ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
           Text('Generation $generation', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
           Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[
             Image.asset('assets/images/pokimon_4.png',height: getDimention(context, 50),),
             Image.asset('assets/images/pokimon_26.png',height: getDimention(context, 50),),
             Image.asset('assets/images/pokimon_5.png',height: getDimention(context, 50),),

           ],)
        ],
      ),
    );
  }
}