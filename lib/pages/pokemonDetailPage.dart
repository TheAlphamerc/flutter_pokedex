import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutter/material.dart';

class PokemonDetailPage extends StatefulWidget {
  PokemonDetailPage({this.model});

  // MainModel model;
  Pokemon model;

  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin{
  Pokemon model;
  int currentPage;
  @override
 AnimationController _controller;

 @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    model = widget.model;
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 4000));
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setprimaryColor(widget.model.type),
      body: Stack(
        children: <Widget>[
          Positioned(
              top: -20,
              left: -45,
              child: Transform.rotate(
                angle: 7.6,
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: setSecondaryColor(widget.model.type),
                  ),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            right: 20,
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BackButton(
                  color: Colors.white60,
                ),
                Icon(
                  Icons.favorite_border,
                  color: Colors.white60,
                ),
              ],
            ),
          ),
          Positioned(
              top: 120,
              left: 20,
              width: MediaQuery.of(context).size.width - 40,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        model.name,
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '#00${model.id}',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(children: <Widget>[
                     _pokemonCategoryChip(model.type),
                     SizedBox(width: 10,),
                     _pokemonCategoryChip(model.type),
                  ],)
                ],
              )),
          Positioned(
              top: 160,
              right: 20,
              // width: MediaQuery.of(context).size.width - 40,
              child:Text('Seed Pokemon',style: TextStyle(color: Colors.white60,fontSize: 18),)
              ),
            
             Positioned(
              right: 50,
              left: 50,
              top: 320,
              child: Align(
                heightFactor: .75,
                widthFactor: .7 ,
                alignment: Alignment.center,
                child: RotationTransition(
                  turns: Tween(begin: 0.0,end: 1.0).animate(_controller),
                  child: Image.asset(
                  'assets/images/pokeball.png',
                  color: setSecondaryColor(model.type),
                  height: 250,
                ),
                )
              )),
          AnimatedPositioned(
           curve: Curves.linear,
           duration: Duration(milliseconds: 4000),
           top: 420,
           height: MediaQuery.of(context).size.height - 220,
           child: Container(
             width: MediaQuery.of(context).size.width,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
               ),
           ),
          ),
           Positioned(
            width: MediaQuery.of(context).size.width,
             top: 260,
             height: 200,
             child:  CarouselSlider(
               initialPage: 0,
               enlargeCenterPage: true,
               autoPlay: true,
               items: <Widget>[
                 Container(
                  //  width: 120,
                    child: Image.asset(model.image),
                 ),
                  Container(
                    // width: 120,
                    child: Image.asset(model.image),
                 ), Container(
                  //  width: 120,
                    child: Image.asset(model.image),
                 ),
               ],
             ),
             
          ) ,
        ],
      ),
      
    );
  }
  Widget _pokemonCategoryChip(String type){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      height: 30,
      decoration: BoxDecoration(color: setSecondaryColor(type),borderRadius: BorderRadius.circular(20)),
      child: Text(type,style: TextStyle(color: Colors.white,fontSize: 16),),
    );
  }
}
