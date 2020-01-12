import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class About extends StatefulWidget {
  final PokemonListModel model;

  const About({this.model});
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin<About>{
  PokemonListModel model;
  bool isExpanded = false;
  @override
  void initState() {
    model = widget.model;
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
  Widget aboutSection() {
     final state = Provider.of<PokemonState>(context);
    return SingleChildScrollView(
      child: Container(
      padding: EdgeInsets.only(left: 20, right: 20,bottom: 20,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          
         _description(),
          Container(
            height: _getFontSize(70),
            margin: EdgeInsets.only(bottom: _getFontSize(10)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.grey.withOpacity(.2),
                    offset: Offset(0, 5),
                  )
                ]),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: _getFontSize(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Weight',
                      style: TextStyle(
                          color: Colors.black87, fontFamily: 'Circular-bold',fontSize: _getFontSize(14)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    customText('${state?.pokemonDetail?.weight} kg',style: TextStyle(fontSize: _getFontSize(14)),)
                  ],
                ),
                SizedBox(
                  width: 50,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Height',
                      style: TextStyle(
                          color: Colors.black87, fontFamily: 'Circular-bold',fontSize: _getFontSize(14)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('${state?.pokemonDetail?.height} cm',style: TextStyle(fontSize: _getFontSize(14)),)
                  ],
                ),
              ],
            ),
          ),
          Text('Breeding',style: TextStyle(fontWeight: FontWeight.w600,fontSize: _getFontSize(14)),),
          SizedBox(height: 10,),
          _gender(),
          SizedBox(height: 10,),
          _eggGroup(),
          _propertyRow('Egge Cycle',model.type1),
          SizedBox(height: 10,),
         
          Text('Location',style: TextStyle(fontWeight: FontWeight.w600,fontSize: _getFontSize(14)),),
          SizedBox(height: 10,),
          Container(
            height: _getFontSize(150),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: setprimaryColor(model.type1),
                image: DecorationImage(
                    image: customAdvanceNetworkImage(
                      'https://tr4.cbsistatic.com/hub/i/r/2014/07/09/5ddb5529-bdc9-4656-913d-8cc299ea5e15/resize/1200x/b4fddca0887e8fdbdef49b4515c2844a/staticmapgoogle0514.png',
                    ),
                    fit: BoxFit.cover)),
          ),
          SizedBox(height: 14,),
          Text('Training',style: TextStyle(fontWeight: FontWeight.w600,fontSize: _getFontSize(15)),),
          SizedBox(height: 10,),
          Row(
            children: <Widget>[
              Text('Base EXP',style: TextStyle(fontSize: _getFontSize(14), color: Colors.black45),),
              SizedBox(width: 50,),
              customText(state.pokemonDetail?.baseExperience?.toString(),
                style: TextStyle(fontSize: _getFontSize(14), color: Colors.black87),
              ),
            ],
          ),
        ],
      ),
    ),
    );
  }
 
  Widget _description(){
    final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.flavorTextEntries == null || state.pokemonSpecies.flavorTextEntries.length == 0){
      return Container();
    }
      var list  = state.pokemonSpecies.flavorTextEntries.where((x)=> x.language.name == 'en').toSet().toList();
      list = list.toSet().toList();
      list.forEach((x)=> x.flavorText..replaceAll("\n", " "));
      String desc = '';
      StringBuffer description = new StringBuffer();
      
      for(int i= 0; i< list.length ;i++){
        var it = list[i].flavorText.replaceAll("\n", " ");
        if(!desc.toString().toLowerCase().contains(it.toLowerCase())){
          description.write(it + ' ');
          desc += it+ ' ';
        }
      }
     
      var wid =  Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
         AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 500),
          child: new ConstrainedBox(
              constraints: isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 58.0),
              child: new Text(
               description.toString().replaceAll("\n", " "),
                softWrap: true,
                overflow: TextOverflow.fade,
                style: TextStyle(fontSize: _getFontSize(14),),textAlign: TextAlign.justify,
              ))),
              new FlatButton(
               padding: EdgeInsets.all(0),
               child:  Text(!isExpanded ? 'more...' : 'Less...',style: TextStyle(color: Colors.blue),),
               onPressed: () => setState(() => isExpanded = !isExpanded))
         ]);
    
    return wid;
  }
  Widget _gender(){
    return Row(
            children: <Widget>[
             Expanded(
               child:  Text('Gender',style: TextStyle(fontSize: _getFontSize(14), color: Colors.black45),),
             ),
             Expanded(
               flex: 2,
               child:  Wrap(
                children: <Widget>[
                 Text('Male 87%',style: TextStyle(fontSize: _getFontSize(14), color: Colors.black87),),
                 SizedBox(width: 10,),
                 Text('Female 13%',style: TextStyle(fontSize: _getFontSize(14), color: Colors.black87),),
                ],
              ),
             )
            ],
          );
  }
  Widget _eggGroup(){
     final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.eggGroups == null || state.pokemonSpecies.eggGroups.length == 0){
      return Container();
    }
     var list  = state.pokemonSpecies.eggGroups;
    return Container(
      width: fullWidth(context),
      child: Row(
        children: <Widget>[
         Expanded(
           flex: 1,
           child: Text('Egg Groups',style: TextStyle(fontSize: _getFontSize(14), color: Colors.black45)),),
         Expanded(
           flex: 2,
           child:  Wrap(
             children:list.map((x){
               return Container(
                 child:Padding(
                   padding: EdgeInsets.only(right: 10),
                   child: customText(x.name,style:  TextStyle(fontSize: _getFontSize(14), color: Colors.black87))
                 )
               );
             }).toList(),
           ),
         )
      ],)
    );
  }
  Widget _propertyRow(String title,String value){
   return Padding(
     padding: EdgeInsets.only(top: 10),
     child:  Row(
              children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(title,style: TextStyle(fontSize: _getFontSize(14), color: Colors.black45)),
              ),
              Expanded(flex: 2,
                child: Text(value,style: TextStyle(fontSize: _getFontSize(14), color: Colors.black87),)
              )
            ],),);
  }

  
  @override
  Widget build(BuildContext context) {
    return   aboutSection();
  }
}
