import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemonDetail.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/customWidget.dart';

class BaseState extends StatefulWidget {
  _BaseStateState createState() => _BaseStateState();
}

class _BaseStateState extends State<BaseState>
    with TickerProviderStateMixin {
  PokemonListModel model;
  double opacity = 0;
  int sliderPageno = 0;
  bool isFavourite = false;
  @override
  AnimationController _progressController;
  Animation<double> _progressAnimation;

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    
  
   
    _progressController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
    _progressAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_progressController);
    _progressController.repeat();
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
  Widget _baseStateSection() {
    final state = Provider.of<PokemonState>(context);
    if(state.pokemonDetail == null || state.pokemonDetail.stats == null){
      return Container();
    }
    var stats = state.pokemonDetail.stats;
    var listStates = stats.map((x) => _statesRow(x)).toList();
    var space =   SizedBox(height: 20,);
    listStates.add(space);
    listStates.add( _abilities(state.pokemonDetail.abilities));
    listStates.add(_habitat());
    listStates.add(_shape());
    listStates.add(_seenAt());
    listStates.add(_pokemonColor());
    listStates.add(_captureRate());
   
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:listStates,
        )
    );
  }
  Widget _statesRow(Stat stat){
   return Padding(
     padding: EdgeInsets.symmetric(vertical: 10),
      child: _baseStateProperty(stat.stat.name,double.parse(stat.baseStat.toString()),_getStateColor(stat.stat.name)) ,
   );
  }
  Widget _baseStateProperty(String property, double value, Color color) {
    return Column(
      children:<Widget>[
        Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(
              property,
              style: TextStyle(fontSize: _getFontSize(15), color: Colors.black54),
            ),
          ),
          Text(
              value.toString(),
              style: TextStyle(fontSize: _getFontSize(15), color: Colors.black),
            ),
          
        ],
      ),
      LinearProgressIndicator(
            value: value / 100,
            backgroundColor: Colors.grey.shade200,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        
      ]
  );
  }
  Widget _abilities(List<Ability> abilityList){
    return Container(
      width: fullWidth(context),
      child: Row(
        children: <Widget>[
         Expanded(
           flex: 1,
           child: Text('Abilities',style: TextStyle(fontWeight: FontWeight.w600,fontSize: _getFontSize(14)),),),
         Expanded(
           flex: 2,
           child:  Wrap(
             children:abilityList.map((x){
               return Container(
                 child:Padding(
                   padding: EdgeInsets.only(right: 10),
                   child: customText(x.ability.name,style:  TextStyle(fontSize: _getFontSize(14), color: Colors.black87))
                 )
               );
             }).toList(),
           ),
         )
      ],)
    );
  }

  dynamic _getStateColor(String title){
    switch(title){
      case 'speed' : return setprimaryColor('Fire');
      case 'special-defance' : return setprimaryColor('Grass');
      case 'special-attack' : return setprimaryColor('Poison');
      case 'attack' : return setprimaryColor('Ice');
      case 'hp' : return setprimaryColor('Ground');
    }
  }

  Widget _habitat(){
     final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.habitat == null ){
      return Container();
    }
      return _propertyRow('Habitat',state.pokemonSpecies.habitat.name);
  }
  Widget _shape(){
     final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.shape == null ){
      return Container();
    }
   return _propertyRow('Shape',state.pokemonSpecies.shape.name);
  }
  Widget _seenAt(){
     final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.palParkEncounters == null || state.pokemonSpecies.palParkEncounters.length ==0 ){
      return Container();
    }
   
    return _propertyRow('Seen At', state.pokemonSpecies.palParkEncounters.first.area.name);
  }
  Widget _pokemonColor(){
     final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.palParkEncounters == null || state.pokemonSpecies.palParkEncounters.length ==0 ){
      return Container();
    }
    return _propertyRow('Color', state.pokemonSpecies.color.name);
  }
  Widget _captureRate(){
    final state = Provider.of<PokemonState>(context);
    if(state.pokemonSpecies == null || state.pokemonSpecies.captureRate == null  ){
      return Container();
    }
    return _propertyRow('Capture Rate', state.pokemonSpecies.captureRate.toString());
  }
  
  Widget _propertyRow(String title,String value){
   return Padding(
     padding: EdgeInsets.only(top: 10),
     child:  Row(
              children: <Widget>[
              Expanded(
                flex: 1,
                child: Text(title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: _getFontSize(14)),),
              ),
              Expanded(flex: 2,
                child: Text(value,style: TextStyle(fontSize: _getFontSize(14), color: Colors.black87),)
              )
            ],),);
  }
  
  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child:  _baseStateSection(),
    );
  }
}
