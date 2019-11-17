import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class Moves extends StatefulWidget {
  final PokemonListModel model;

  const Moves({this.model});
  _MovesState createState() => _MovesState();
}

class _MovesState extends State<Moves> with TickerProviderStateMixin<Moves>{
  PokemonListModel model;
  bool isExpanded = false;
  @override
  void initState() {
    model = widget.model;
    //  flutterTts = new FlutterTts();
    //  languages = await flutterTts.getLanguages;
     
    super.initState();
  }
  double _getFontSize(double size){
   if(MediaQuery.of(context).textScaleFactor < 1){
      return size;
   }
   else{
     return (size / MediaQuery.of(context).textScaleFactor);
   }

  }
  Widget _moves() {
     final state = Provider.of<PokemonState>(context);
     if(state.pokemonDetail == null || state.pokemonDetail.moves == null || state.pokemonDetail.moves.length == 0){
        return Container(child:Center(child:  Text('No information available'),),);
     }
     List<Widget> moves;
         moves = state.pokemonDetail.moves.map((f)=> Text(f.move.name)).toList();
      return  Padding(
        padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
        child: GridView.builder(
             gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 2,
              crossAxisCount: 3) ,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
            itemCount: moves.length,
            itemBuilder: (context,index) => Container(
                 alignment: Alignment.center,
                 margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                 padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  shape:BoxShape.rectangle
                ),
               child: Text(state.pokemonDetail.moves[index].move.name,style: TextStyle(fontSize: getFontSize(context, 15),color: Colors.black87,fontWeight: FontWeight.w400),),
               ))
      );
 }
  
  Widget _propertyRow(String title,String value){
   return  Row(
              children: <Widget>[
              Text(title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: _getFontSize(14)),),
              SizedBox(width: 50,),
              Text(value,style: TextStyle(fontSize: _getFontSize(14), color: Colors.black87),)
            ],);
  }
  
  @override
  Widget build(BuildContext context) {
    return   _moves();
  }
}
