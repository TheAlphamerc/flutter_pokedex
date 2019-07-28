import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PokemonListPage extends StatefulWidget {
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
           Positioned(
            right: 0,
            top: 0,
            child:Align(
            heightFactor: .75,
            widthFactor: .7,
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/images/pokeball.png',
              color: Color(0xffe3e3e3),
              height: 250,
            ),)
          ),
          Positioned(
            left: 10,
            top: 40,
            right: 32,
            child: 
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
              BackButton(),
              Icon(Icons.list,size: 30,)
            ],),
        ),
         Positioned(
           top: 100,
           left: 20,
           right: 20,
           child: 
         Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
           Text('Pokedex',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w900),),
           Container(
             height: MediaQuery.of(context).size.height - 135 ,
             width: MediaQuery.of(context).size.width - 20,
             child: GridView.count(
             mainAxisSpacing: 15,
             crossAxisSpacing: 15,
             crossAxisCount: 2,
             children: List.generate(15, (index){
                return  Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)
                  ),
                );
             }),
           ),
           ),
         ],),)
        ],
      ),
    );
  }
}
