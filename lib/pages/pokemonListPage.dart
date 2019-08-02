import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutter/material.dart';

class PokemonListPage extends StatefulWidget {
  const PokemonListPage({this.model});

  final MainModel model;

  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>  with TickerProviderStateMixin{
  List<Pokemon> list = [];

 AnimationController _controller;

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 4000));
    _controller.repeat();
    list = widget.model.allPokemon;
    super.initState();
  }


  Widget _pokemonCard(Pokemon model){
    return  InkWell(
      onTap: (){ Navigator.of(context).pushNamed('/detail/${model.id}');},
      child: Container(
                     // padding: EdgeInsets.only(left: 20,top:20),
                     height: 50,
                     decoration: BoxDecoration(
                              color: setprimaryColor(model.type),
                              borderRadius: BorderRadius.circular(20)),
                     child: Stack(
                            children: <Widget>[
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  height: 120,
                                  child: Image.asset(
                                        'assets/images/pokeball.png',
                                        color:setprimaryColor(model.type),
                                        height: 150,
                                      )
                                  ),
                              Positioned(
                                  top: 20,
                                  left: 20,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        model.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 5,horizontal:5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color:setSecondaryColor(model.type),
                                          ),
                                        child: Text(
                                        model.type,
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      )
                                    ],
                                  )),
                              Positioned(
                                  bottom: 10,
                                  right: 10,
                                  height: 100,
                                  child: Hero(
                                    tag: model.id,
                                    child: Image.asset(
                                        model.image,
                                        fit: BoxFit.contain,
                                      ),))
                            ],
                          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
              right: 0,
              top: 0,
              child: Align(
                heightFactor: .75,
                widthFactor: .7 ,
                alignment: Alignment.bottomLeft,
                child: RotationTransition(
                  turns: Tween(begin: 0.0,end: 1.0).animate(_controller),
                  child: Hero(
                  tag: "pokeball",
                  child:  Image.asset(
                  'assets/images/pokeball.png',
                  color: Color(0xffe3e3e3),
                  height: 250,
                ),)
                )
              )),
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
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
                ),
                Container(
                  height: MediaQuery.of(context).size.height - 135,
                  width: MediaQuery.of(context).size.width - 20,
                  child: GridView.count(
                    padding: EdgeInsets.only(top: 20),
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    children: List.generate(list.length, (index) {
                      return _pokemonCard(list[index]);
                    },growable: false),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
