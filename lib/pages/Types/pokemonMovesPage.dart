import 'package:flutte_pokedex/helper/enum.dart';
import 'package:flutte_pokedex/scoped_model/moveState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/colorTheme.dart';
import '../../widgets/customWidget.dart';
import '../../widgets/customWidget.dart';

class PokemonMovesPage extends StatefulWidget {
  final HomePageButtonEnum pagetype;
  PokemonMovesPage({Key key,this.pagetype}) : super(key: key);
 
  @override
  _PokemonMovesPageState createState() => _PokemonMovesPageState();
}

class _PokemonMovesPageState extends State<PokemonMovesPage> with TickerProviderStateMixin {
  ScrollController _scrollController;
  AnimationController _controller;
  Color primary;
  Color secondary;

  @override
  void initState() {
    setColor();
    _controller = AnimationController(
     vsync: this, duration: Duration(milliseconds: 4000));
    _controller.repeat();
    var state = Provider.of<MoveState>(context,listen: false);
    state.getMovesList(widget.pagetype);
    _scrollController = ScrollController()
    ..addListener(_scrollListner);
    super.initState();
    
  }
   @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }
  _scrollListner(){
   if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
         var state = Provider.of<MoveState>(context,listen: false);
         print('reached to bottom');
         state.getMovesList(widget.pagetype,initialLoad: false);
    }
  }
  Widget _topRightPokeball() {
    return Positioned(
        right: 0,
        top: 0,
        child: Align(
            heightFactor: fullWidth(context) <= 360 ?  getDimention(context, 1.03) : .74,
            widthFactor:  fullWidth(context) <= 360 ?  getDimention(context,.98) : .69,
            alignment: Alignment.bottomLeft,
            child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child:Image.asset(
                    'assets/images/pokeball.png',
                    color: primary.withAlpha(150),
                    height: getDimention(context, 250),
     ),)));
  }
  Widget _body(){
    var state = Provider.of<MoveState>(context);
    if(state.movesList == null){
      return SliverToBoxAdapter(
        child: Container(
          height: fullHeight(context) - 150,
          child: Center(child: CircularProgressIndicator(
            backgroundColor:primary,
            // valueColor: AlwaysStoppedAnimation<Color>(secondary),
            ),),
        ),
      );
    }
    else{
      return SliverGrid(
        // physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          childAspectRatio: 2.5
        ),
        delegate:SliverChildListDelegate.fixed(
          state.movesList.map((x){
              var color = primary ; //getRendomColor(state.movesList.indexOf(x));
          return  Container(
                margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: color,//setprimaryColor(widget.type).withAlpha(150),
                  boxShadow: <BoxShadow>[
                          // BoxShadow(blurRadius: 5,offset: Offset(0, -5),color: color.withAlpha(150),spreadRadius:0),
                        ],
                ),
                child: Text(x.name.toUpperCase(),overflow:TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                ),
             );
          }).toList()
        ) ,
      );
    }
  }
  Widget _title(){
    String title;
    switch (widget.pagetype) {
      case HomePageButtonEnum.Abilitie: title = 'Abilities';break;
      case HomePageButtonEnum.Move: title = 'Move';break;
      case HomePageButtonEnum.Item: title = 'Items';break;
      case HomePageButtonEnum.Berries: title = 'Berries';break;
      case HomePageButtonEnum.Pokemon: title = 'Pokemons';break;
      case HomePageButtonEnum.Habitats: title = 'Habitats';break;
        
        break;
      default : title = '';
    }
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
      alignment: Alignment.bottomLeft,
      child: Text(title, style: TextStyle(color: Colors.black54,fontSize: getFontSize(context,35), fontWeight: FontWeight.w900),),
    );
  }
 
  setColor(){
   
    switch (widget.pagetype) {
      case HomePageButtonEnum.Abilitie: {
         primary  = Color(0xff4dc2a6);secondary = Color(0xff65d4bc);
         break;
      }
     case HomePageButtonEnum.Berries: {
        primary=Color(0xff7b528c);secondary= Color(0xff9569a5);
         break;
      } 
      case HomePageButtonEnum.Habitats: {
        primary=Color(0xffb1726c);secondary = Color(0xffc1877e);
         break;
      } 
      case HomePageButtonEnum.Item: {
        primary=Color(0xffffce4a);secondary = Color(0xffffd858);
         break;
      }
      case HomePageButtonEnum.Move: {
        primary=Color(0xfff77769);secondary = Color(0xfff88a7d);
         break;
      } 
      case HomePageButtonEnum.Pokemon: {
        primary=Color(0xff4dc2a6);secondary= Color(0xff65d4bc);
         break;
      } 
       
      default:
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
     body: Stack(
       children: <Widget>[
         _topRightPokeball(),
          CustomScrollView(
             controller: _scrollController,
            slivers: <Widget>[
             SliverAppBar(
                    automaticallyImplyLeading: true,
                    leading: BackButton(color: Colors.black54,),
                    backgroundColor: Colors.transparent,
                    brightness: Brightness.dark,
                    stretch: true,
                    flexibleSpace:_title(),
                    expandedHeight: getDimention(context, 130),
                  ),
              _body(),
            ],
         ),
       ],
      )
     );
  }
}