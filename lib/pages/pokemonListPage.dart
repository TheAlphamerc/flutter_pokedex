import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/colorTheme.dart';
import '../helper/colorTheme.dart';

class PokemonListPage extends StatefulWidget {
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>
    with TickerProviderStateMixin {
  List<Pokemon> list = [];
  AnimationController _controller;
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    _controller.repeat();
    // list = widget.model.allPokemon;
   final state = Provider.of<PokemonState>(context,listen: false);
   state.getPokemonListAsync();
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
  Widget _pokemonCard(PokemonListModel model) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail/${model.name}');
      },
      child: Container(
          margin: EdgeInsets.only(left: 5,right: 5, top: 5,bottom: 5),
          decoration: BoxDecoration(
              color: setprimaryColor(model.type1),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: 10,
                left: 10,
                child: customText('#' + (model.orderId.toString().length == 1  ? '00' + model.orderId.toString() : model.orderId.toString().length == 2 ? '0'+model.orderId.toString() : model.orderId.toString()),
                  style:  TextStyle(
                            color: setSecondaryColor(model.type1),
                             fontSize: _getFontSize(20),
                            fontWeight: FontWeight.w600),),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  height: 120,
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor('#' + model.type1),
                    height: 150,
                  )),
              Positioned(
                  top: 20,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        model.name,
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: _getFontSize(20),
                            fontWeight: FontWeight.w600),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: setSecondaryColor(model.type1),
                        ),
                        child: Text(
                          model.type1,
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: _getFontSize(14),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: Hero(
                    tag: model.orderId,
                    child:  Image( image: customAdvanceNetworkImage(
                      model.image,),
                      fit: BoxFit.contain,
                      height: 100,
                    ),
                  )
                  )
            ],
          )),
    );
  }
  Widget _pokemonList(){
    final state = Provider.of<PokemonState>(context,);
    if(state.isBusy && state.pokemonList ==null){
        return SliverGrid.count(
                crossAxisCount: 1,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: [
                 Center(child: CircularProgressIndicator(),)
                ],
              );
        
    }
    else if(!state.isBusy && state.pokemonList == null){
        return 
        SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: [
                   Center(child: Text('No pokemon available'))
                ],
              );
       
    }
    else{
      return   SliverGrid.count(
                crossAxisCount: 2,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: state.pokemonList == null ? [] : state.pokemonList.map((x)=> _pokemonCard(x)).toList(),
              );
    }
     
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokemonState>(context,);
    return Scaffold(
      body: Stack(
        children: <Widget>[
           Positioned(
              right: 0,
              top: 0,
              child: Align(
                  heightFactor: .75,
                  widthFactor: .7,
                  alignment: Alignment.bottomLeft,
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Image.asset(
                      'assets/images/pokeball.png',
                      color: Color(0xffe3e3e3),
                      height: 250,
                    ),
                  ))),
          
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: true,
                leading: BackButton(color: Colors.black,),
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
                floating: true,
               
                flexibleSpace: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  alignment: Alignment.bottomLeft,
                  child: Text('Pokedex', style: TextStyle(fontSize: _getFontSize(35), fontWeight: FontWeight.w900),),
                ),
                expandedHeight: 130,
              ),
              _pokemonList()
            ],
            
          ),
          Positioned(
            right: 15,
            top: 35,
            child:IconButton(
                  onPressed: ()async{
                var result = await showSearch(
                  context: context,
                  delegate: SpeakerSearch(state.pokemonList));
              },
                  icon: Icon(Icons.search),
            )
          ),
        ],
      )
    );
  }
}

class SpeakerSearch extends SearchDelegate<PokemonListModel>{
   final List<PokemonListModel> list;
    List<PokemonListModel> templist;
  SpeakerSearch(this.list);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: (){ query = '';},
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: (){
        close(context, null);
      },
      icon: Icon(Icons.arrow_back,color: Theme.of(context).primaryColor,),
    );
  }
 
  @override
  Widget buildResults(BuildContext context) {
   templist = list.where((x)=>x.name.toLowerCase().contains(query.toLowerCase())).toList() ?? list;
   
    return _result(context);
  }
 
  Widget _result(BuildContext context){
    return SingleChildScrollView(
      child: Container(
      child: Column(
        children: templist.map((t)=> Container(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Theme.of(context).cardColor
            ),
            child:  ListTile(
              leading: Text(t.name),
            onTap: (){
              Navigator.of(context).pushNamed('/detail/${t.name}');
              // close(context, t);
            },
            
           ),
          )
        )).toList(),
      ),
    ),
    );
  }
 
  @override
  Widget buildSuggestions(BuildContext context) {
    templist = list.where((x)=>x.name.toLowerCase().contains(query.toLowerCase())).toList() ?? list;
    return _result(context);
    // _result(context);
  }
}