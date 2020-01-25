import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/colorTheme.dart';
import '../../widgets/customWidget.dart';
import '../../widgets/customWidget.dart';
import 'widget/generationModel.dart';
import 'widget/pokemonCard.dart';
import 'widget/pokemonCard3.dart';
import 'widget/pokemonCard_2.dart';

class PokemonListPage extends StatefulWidget {
  _PokemonListPageState createState() => _PokemonListPageState();
}

class _PokemonListPageState extends State<PokemonListPage>  with TickerProviderStateMixin {
  List<Pokemon> list = [];
  AnimationController _controller;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;
  Animation<double> _translateButton;
  bool showFabButton =  false, card1 = true,card2= false, card3 = false;

  @override
  void initState() {
    _controller = AnimationController(
     vsync: this, duration: Duration(milliseconds: 4000));
    _controller.repeat();
     _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
   _translateButton = Tween<double>(
      begin: -200,
      end: 0,
    ).animate(CurvedAnimation(parent: _animationController,curve: Interval(0.0,1,curve: _curve,),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
     _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
    showFabButton = !showFabButton;
  }

  Widget _floatingActionButton() {
    return FloatingActionButton(
      backgroundColor: Color(0xff6c79dc),
      onPressed: animate,
      tooltip: 'Toggle',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
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
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: card1 ? 1.4 : card2 ? 1 : 1,
                children: state.pokemonList == null ? [] : 
                card1 ?
                state.pokemonList.map((x)=> PokemonCard(
                  model: x,
                  onPressed: (){ Navigator.of(context).pushNamed('/detail/${x.name}');},
                  onLongPressed: (){openPokemonshortDetail(x);}
                  )).toList() :
                card2 ?
                state.pokemonList.map((x)=>  PokemonCard2(
                  model: x,
                  onPressed: (){ Navigator.of(context).pushNamed('/detail/${x.name}');},
                  onLongPressed: (){openPokemonshortDetail(x);}
                  )).toList() :
                 state.pokemonList.map((x)=>  PokemonCard3(
                  model: x,
                  onPressed: (){ Navigator.of(context).pushNamed('/detail/${x.name}');},
                  onLongPressed: (){openPokemonshortDetail(x);}
                  )).toList()
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
                    color: Color(0xffe3e3e3).withAlpha(100),
                    height: getDimention(context, 250),
     ),)));
  }
 
  Widget _rightTopSearchIcon(){
    final state = Provider.of<PokemonState>(context,);
    if(state.pokemonList == null || state.pokemonList.length == 0){
      return Container();
    }
    return  Padding(
        padding: EdgeInsets.only(right: 0),
        child: IconButton(
          iconSize: getDimention(context,30),
          alignment: Alignment.center,
          padding: EdgeInsets.all(0),
          onPressed: ()async{
               await showSearch(
                 context: context,
                 delegate: PokemonSearch(state.pokemonList));
             },
          icon: Icon(Icons.search,color: Colors.black87,),
        )
      );
  }
 
  Widget _floatingActionButtonColumn(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
         _smallFabButton(
          Icons.favorite,
          text: 'Favourite Pokemon',
          animationValue: 6,
          isEnable: false,
          onPressed: (){
             animate();
          }),
         _smallFabButton(
          Icons.donut_small,
          text: 'All Genration',
          animationValue: 5,
          isEnable: false,
          onPressed: (){
             animate();
             openPokemonGenerationPanel();
          }),
        _smallFabButton(
          Icons.gamepad,
          text: 'All Type',
          animationValue: 4,
          isEnable: false,
          onPressed: (){
             animate();
          }),
           _smallFabButton(
          Icons.search,
          text: 'Search',
          animationValue: 3,
          isEnable: false,
          onPressed: ()async{
             animate();
             final state = Provider.of<PokemonState>(context,);
             await showSearch(
                 context: context,
                 delegate: PokemonSearch(state.pokemonList));
          }),
        _smallFabButton(
          Icons.filter_1,
          text: 'Layout',
          animationValue: 3,
          isEnable: card1,
          onPressed:(){
                  setState(() {
                     card1 = true;
                     card2 = false;
                     card3 = false;
                  });
                  animate();
                },
        ),
        SizedBox(height: 3,),
        _smallFabButton(
          Icons.filter_2,
          text: 'Layout',
          animationValue: 2,
          isEnable: card2,
          onPressed: (){
            setState(() {
               card1 = false;
               card2 = true;
               card3 = false;
            });
             animate();
          },
        ),
        _smallFabButton(
          Icons.filter_3,
          text: 'Layout',
          animationValue: 1,
          isEnable: card3,
          onPressed: (){
            setState(() {
               card1 = false;
               card2 = false;
               card3 = true;
            });
             animate();
          },
        ),
    ],);
  }
  
  Widget _smallFabButton(IconData iconData,{Function onPressed,double animationValue,bool isEnable,String text = ''}){
    return  Container(
              margin:  EdgeInsets.symmetric(vertical: 8),
              child: Transform(
              transform: Matrix4.translationValues(
                 _translateButton.value * animationValue,
                 0.0,
                 0.0,
              ),
              child:  Material(
                elevation: 4,
                color: Colors.transparent,
                shape:  RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
                child: InkWell(
                  onTap: onPressed,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15,vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      color: isEnable ? Color(0xff6c79dc) : Colors.white,//isEnable ? Colors.blue : Colors.white
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(text,style: TextStyle(fontWeight: FontWeight.bold, color: isEnable ? Colors.white : Colors.black)),
                        SizedBox(width: 5,),
                        Icon(iconData,color:isEnable ? Colors.white : Color(0xff6c79dc),size: 20,),
                      ],
                    )
                  ),
                )
              ),
      ),
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
 
  void openPokemonshortDetail(PokemonListModel model)async{
    print(model.name);
    var _panelHeight = getFontSize(context, 300);
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
                   margin: EdgeInsets.only(top: getFontSize(context, 30)),
                   padding: EdgeInsets.only(bottom:10,left: 20,right: 20,top:getFontSize(context, 30)),
                   decoration: BoxDecoration(
                     color: setSecondaryColor(model.type1),
                     borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                   ),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: getFontSize(context, 10),left:20),
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
           Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: getDimention(context, _panelHeight-30),),
                child:InkWell(
                   onTap: () {
                    Navigator.of(context).pushNamed('/detail/${model.name}');
                 },
                 child:  Hero(
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
 
  void openPokemonGenerationPanel()async{
    var _panelHeight = getFontSize(context, 350);
     await showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (context)=> GenerationModel()
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _floatingActionButton(),
      body: Stack(
        children: <Widget>[
          _topRightPokeball(),
          /// [Back Button]
          Positioned(
            left: 10,
            top: 35,
            child: BackButton(color: Colors.black,),
          ),
          Container(
             padding: EdgeInsets.symmetric(horizontal: 25),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    automaticallyImplyLeading: true,
                    leading: SizedBox(),
                    backgroundColor: Colors.transparent,
                    brightness: Brightness.dark,
                    floating: false,
                    actions: <Widget>[
                     _rightTopSearchIcon()
                    ],
                    flexibleSpace: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
                      alignment: Alignment.bottomLeft,
                      child: Text('Pokedex', style: TextStyle(fontSize: getFontSize(context,25), fontWeight: FontWeight.w700),),
                    ),
                    expandedHeight: getDimention(context, 130),
                  ),
                  _pokemonList()
                ],
              ),
           ),
          AnimatedPositioned(
            bottom: 16 + 60.0,
            right: 25,//showFabButton ? 25 : 0,
            duration: Duration(milliseconds: 500),
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: showFabButton ? 1 : 0,
              child: _floatingActionButtonColumn(),
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
              color: Theme.of(context).cardColor,
               
            ),
            child: ListTile(
              leading:   Image( image: customAdvanceNetworkImage(
                     templist[index].image,),
                      fit: BoxFit.contain,
                      height: getDimention(context, 40),
                    ),
            trailing:  Container(
              
              width: 85,
                  padding:EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: <BoxShadow>[
                            BoxShadow(blurRadius: 5,offset: Offset(3, 3),color: setSecondaryColor(templist[index].type1).withAlpha(150),spreadRadius:0),
                            BoxShadow(blurRadius: 8,offset: Offset(5,-5),color: Color(0xffffffff),spreadRadius:5)
                          ],
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
