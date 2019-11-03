import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    // if(model != null){
    //   return Text(model.name);
    // }
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail/${model.orderId}');
      },
      child: Container(
          // padding: EdgeInsets.only(left: 20,top:20),
          height: 50,
          decoration: BoxDecoration(
              color: setprimaryColor(model.type1),
              borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: <Widget>[
              Positioned(
                  bottom: 0,
                  right: 0,
                  height: 120,
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor(model.type1),
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
                  // height: 100,
                  // child: Image( image: NetworkImage(
                  //     model.image,),
                  //     fit: BoxFit.contain,
                  //   ),
                  child: Hero(
                    tag: model.orderId,
                    child:  Image( image: NetworkImage(
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
        return Center(child: CircularProgressIndicator(),);
    }
    else if(state.isBusy && state.pokemonList == null){
        return Center(child: Text('No pokemon available'));
    }
    else{
      return  Container(
                  height: MediaQuery.of(context).size.height - 135,
                  width: MediaQuery.of(context).size.width - 20,
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 20),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: List.generate(state.pokemonList.length, (index) {
                      return _pokemonCard(state.pokemonList[index]);
                    }, growable: false),
                  ),
                );
    }
     
  }
  @override
  Widget build(BuildContext context) {
    //   print('height');
    // print(MediaQuery.of(context).size.height.toString());
    
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
          Positioned(
            left: 10,
            top: 40,
            right: 32,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BackButton(),
                Icon(
                  Icons.list,
                  size: 30,
                )
              ],
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
               Text(
                 'Pokedex',
                 style: TextStyle(fontSize: _getFontSize(35), fontWeight: FontWeight.w900),
               ),
               _pokemonList()
              ],
            ),
          )
        ],
      ),
    );
  }
}