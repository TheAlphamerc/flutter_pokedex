import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/HalfPainter.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class PokemonTypeListPage extends StatefulWidget {
  _PokemonTypeListPage createState() => _PokemonTypeListPage();
}

class _PokemonTypeListPage extends State<PokemonTypeListPage>{
    
  List<Pokemon> list = [];
  AnimationController _controller;
  bool showFabButton =  false, card1 = true,card2= false, card3 = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
   final state = Provider.of<PokemonState>(context,listen: false);
   state.getPokemonListAsync();
    super.initState();
  }
  Widget _pokemonCard(PokemonListModel model) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail/${model.name}');
      },
      onLongPress: (){ openPokemonshortDetail(model);},
      child: Container(
          margin: EdgeInsets.only(left: 5,right: 5, top: 5,bottom: 5),
          decoration: BoxDecoration(
              color: setprimaryColor(model.type1),
              borderRadius: BorderRadius.circular(10)),
          child: Stack(
            children: <Widget>[
              Positioned(
                bottom: getDimention(context, 10),
                left: getDimention(context, 10),
                child: customText(getId(model.orderId.toString()),
                  style:  TextStyle(
                            color: setSecondaryColor(model.type1),
                             fontSize: getFontSize(context,20),
                            fontWeight: FontWeight.w600),
                            overflow: TextOverflow.ellipsis),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  height: getDimention(context, 120),
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor('#' + model.type1),
                    height: getDimention(context, 150),
                  )),
              Positioned(
                  top: getDimention(context, 10),
                  left:getDimention(context, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        // width: fullHeight(context) / 4.5,
                        // constraints: BoxConstraints(minWidth: 50,maxWidth:(fullHeight(context) - 300)/2),
                        // color: Colors.blue,
                        child: customText(
                          model.name,
                          context: context,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getFontSize(context,20),
                              fontWeight: FontWeight.w600,),
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.start
                        ),
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
                              fontSize: getFontSize(context,14),
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  )),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child:
                   Hero(
                    tag: model.orderId,
                    child:  Image( image: customAdvanceNetworkImage(
                      model.image,),
                      fit: BoxFit.contain,
                      height: getDimention(context, 100),
                    ),
                  )
                  )
            ],
          )),
    );
  }
  Widget _pokemonCard_2(PokemonListModel model){

    return  InkWell(
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
                  bottom: 0,
                  right: 0,
                  height: getDimention(context, 120),
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor('#' + model.type1),
                    height: getDimention(context, 150),
                  )),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child:
                    Hero(
                    tag: model.orderId,
                    child:  Image( image: customAdvanceNetworkImage(
                      model.image,),
                      fit: BoxFit.contain,
                      height: getDimention(context, 100),
                    ),
                  )
                 
                  )
            ],
          )),
    );
  }
  Widget _pokemonCard3(PokemonListModel model) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed('/detail/${model.name}');
      },
      onLongPress: (){ openPokemonshortDetail(model);},
      child: Container(
        height: 40,
          margin: EdgeInsets.only(left: 5,right: 5, top: 5,bottom: 5),
          decoration: BoxDecoration(
              color: setprimaryColor(model.type1),
              borderRadius: BorderRadius.circular(10)),
          child: Hero(
                    tag: model.orderId,
                    child:  Image( image: customAdvanceNetworkImage(
                      model.image,),
                      fit: BoxFit.contain,
                      height: getDimention(context, 30),
                    ),
                  ),
         )
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
                
                crossAxisCount: card1 ? 2 : card2 ? 3 :  4 ,
                crossAxisSpacing: 0,
                mainAxisSpacing: 0,
                children: state.pokemonList == null ? [] : 
                card1 ?
                state.pokemonList.map((x)=> _pokemonCard(x)).toList() :
                card2 ?
                state.pokemonList.map((x)=> _pokemonCard_2(x)).toList() :
                 state.pokemonList.map((x)=> _pokemonCard3(x)).toList() 
              );
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
                    color: Color(0xffe3e3e3),
                    height: getDimention(context, 250),
     ),)));
  }
   Widget _rightTopSearchIcon(){
    final state = Provider.of<PokemonState>(context,);
    if(state.pokemonList == null || state.pokemonList.length == 0){
      return Container();
    }
    return  Padding(
        padding: EdgeInsets.only(right: 19),
        child: IconButton(
          iconSize: getDimention(context,30),
          alignment: Alignment.center,
          padding: EdgeInsets.all(0),
          onPressed: ()async{
               var result = await showSearch(
                 context: context,
                 delegate: PokemonSearch(state.pokemonList));
             },
          icon: Icon(Icons.search,color: Colors.black87,),
        )
      );
  }
  Widget _floatingActionButton(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Material(
          elevation: 4,
          color: Colors.transparent,
          shape:  RoundedRectangleBorder(
           borderRadius: new BorderRadius.circular(18.0),
        ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue
            ),
            child: IconButton(
               onPressed: (){
                setState(() {
                    card1 = true;
                   card2 = false;
                   card3 = false;
                });
              },
              icon: Icon(Icons.filter_1,color: Colors.white,),)
          ),
        ),
      SizedBox(key: Key('SizedBox_1'),height: 5,),
      Material(
        color: Colors.transparent,
        elevation: 5,
        shape:  RoundedRectangleBorder(
           borderRadius: new BorderRadius.circular(18.0),
        ),
        child:  Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue
          ),
          child: IconButton(
             onPressed: (){
              setState(() {
                 card1 = false;
                 card2 = true;
                 card3 = false;
              });
            },
            icon: Icon(Icons.filter_2,color: Colors.white,),)
        ),
      ),
     SizedBox(
        height: 5,),
    Material(
       color: Colors.transparent,
        elevation: 5,
        shape:  RoundedRectangleBorder(
           borderRadius: new BorderRadius.circular(18.0),
        ),
      child:  Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blue
          ),
          child: IconButton(
            onPressed: (){
              setState(() {
                 card1 = false;
                 card2 = false;
                 card3 = true;
              });
            },
            icon: Icon(Icons.filter_3,color: Colors.white,),)
        ),
    ),
    ],);
  }
  void openPokemonshortDetail(PokemonListModel model)async{
    print(model.name);
    var _panelHeight = 300.0;
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (context)=> 
       Stack(
         children: <Widget>[
           Container(
              width: fullWidth(context),
              //  color: Colors.black26,
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                   width: fullWidth(context),
                   height: _panelHeight,
                   alignment: Alignment.bottomCenter,
                   margin: EdgeInsets.only(top: 40),
                   padding: EdgeInsets.only(bottom:10,left: 20,right: 20,top: 40),
                   decoration: BoxDecoration(
                     color: setSecondaryColor(model.type1),
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                   ),
                   child: Column(
                     children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                          model.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: getFontSize(context,22),
                              fontWeight: FontWeight.w600),
                        ),
                        ),
                        _panelRow('Id',getId(model.orderId.toString()),),
                        _panelRow('Type',model.type1,),
                        _panelRow('Ability',model.ability1),
                        _panelRow('Hiddenability',model.hiddenability.toString(),),
                        _panelRow('Attack',model.atk.toString(),),
                        _panelRow('Defence',model.def.toString(),),
                      
                     ],
                   )
               )
            ),
          InkWell(
              onTap: () {
               Navigator.of(context).pushNamed('/detail/${model.name}');
            },
            child:   Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: getDimention(context, _panelHeight-30),),
                child: Hero(
                      tag: model.orderId,
                      child:  Image( image: customAdvanceNetworkImage(
                        model.image,),
                        fit: BoxFit.contain,
                        height: getDimention(context, 150),
                      ),
                    ),
              )
           ),
          ),
            
         ],
       )
    );
  }
  Widget _panelRow(String title,String value){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      child:   Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Expanded(
        flex: 2,
        child: Align(alignment: Alignment.centerLeft,child:  Text(title,style: TextStyle(color: Colors.white,fontSize: getFontSize(context,14),fontWeight: FontWeight.w600),),)
      ),
       Expanded(
         flex: 4,
         child: Align(alignment: Alignment.centerLeft,child:  Text(value,style: TextStyle(color: Colors.white,fontSize: getFontSize(context,14),fontWeight: FontWeight.w600),),)
       )
    ],),
    );
  }
  String getId(String id){
     return '#' + (id.toString().length == 1  ? '00' + id.toString() : id.toString().length == 2 ? '0'+id.toString() : id.toString());
  }
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<PokemonState>(context,);
    return Scaffold(
      floatingActionButton:  FloatingActionButton(
            isExtended: false,
             onPressed: (){
               setState(() {
                 showFabButton = !showFabButton;
               });
             },
              child: Icon(Icons.edit),
        ),
      body: Stack(
        children: <Widget>[
          _topRightPokeball(),
           CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: true,
                leading: BackButton(color: Colors.black,),
                backgroundColor: Colors.transparent,
                brightness: Brightness.dark,
                floating: false,
                actions: <Widget>[
                  _rightTopSearchIcon()
                ],
                flexibleSpace: Container(
                  padding: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
                  alignment: Alignment.bottomLeft,
                  child: Text('Pokedex', style: TextStyle(fontSize: getFontSize(context,35), fontWeight: FontWeight.w900),),
                ),
                expandedHeight: getDimention(context, 130),
              ),
              _pokemonList()
            ],
          ),
          AnimatedPositioned(
            bottom: 16 + 60.0,
            right: showFabButton ? 25 : 0,
            duration: Duration(milliseconds: 500),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: showFabButton ? 1 : 0,
              child: _floatingActionButton(),
            ),
          )
        ],
      )
    );
  }
}

class PokemonSearch extends SearchDelegate<PokemonListModel>{
   final List<PokemonListModel> list;
    List<PokemonListModel> templist;
  PokemonSearch(this.list);
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
  //  templist = list.where((x)=>x.name.toLowerCase().contains(query.toLowerCase())).toList() ?? list;
   templist = list;
    return _result(context);
  }
 
  Widget _result(BuildContext context){
    return ListView.builder(
        itemCount: templist.length,
        itemBuilder: (context,index)=> 
        Container(
           margin: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:Theme.of(context).cardColor,
              boxShadow: <BoxShadow>[
                  // BoxShadow(blurRadius: 15,offset: Offset(5, 5),color: setSecondaryColor(templist[index].type1).withAlpha(150),spreadRadius:0),
                  // BoxShadow(blurRadius: 5,offset: Offset(5,-5),color: Color(0xffffffff),spreadRadius:5)
                ]
            ),
            child: ListTile(
              leading:   Image( image: customAdvanceNetworkImage(
                     templist[index].image,),
                      fit: BoxFit.contain,
                      height: getDimention(context, 40),
                    ),
            trailing:  Container(
              width: 85,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(blurRadius: 5,offset: Offset(3, 3),color: setSecondaryColor(templist[index].type1).withAlpha(150),spreadRadius:0),
                            BoxShadow(blurRadius: 8,offset: Offset(5,-5),color: Color(0xffffffff),spreadRadius:5)
                          ],
                          borderRadius: BorderRadius.circular(10),
                          color: setSecondaryColor(templist[index].type1),
                        ),
                        child:
                        Row(children: <Widget>[
                         Expanded(child:  Text(
                         templist[index].type1,
                          style: TextStyle(
                              color: Colors.white60,
                              fontSize: getFontSize(context,14),
                              fontWeight: FontWeight.w600),
                        ),),
                          Image.asset(getTypeImage(templist[index].type1),fit: BoxFit.cover,width: 30,)
                        ],) 
                      ),
            title: customText(templist[index].name,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400,),textAlign: TextAlign.start, context:context),
            onTap: (){
              Navigator.of(context).pushNamed('/detail/${templist[index].name}');
            },
        ))
    );
  } 
  
  @override
  Widget buildSuggestions(BuildContext context) {
    templist = list.where((x)=>x.name.toLowerCase().contains(query.toLowerCase() )||  x.type1.toLowerCase().contains(query.toLowerCase())).toList() ?? list;
    return _result(context);
  }
}