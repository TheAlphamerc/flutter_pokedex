import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/pokemonState.dart';
import 'package:flutte_pokedex/widgets/customWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'pokemonDetails/about.dart';
import 'pokemonDetails/baseState.dart';
import 'pokemonDetails/moves.dart';

class PokemonDetailPage extends StatefulWidget {
  PokemonDetailPage({this.name});
  final String name;
  // MainModel model;
  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage>
    with TickerProviderStateMixin {
  PokemonListModel model;
  double opacity = 0;
  int sliderPageno = 0;
  bool isFavourite = false;
  FlutterTts flutterTts ;
   List<dynamic> languages ;
  @override
  AnimationController _controller;
  AnimationController _progressController;
  Animation<double> _progressAnimation;

  @override
  void dispose() {
    _controller.dispose();
    _stop();
    _progressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    flutterTts = new FlutterTts();
     
    final state = Provider.of<PokemonState>(context,listen: false);
    model = state.pokemonList.firstWhere((x)=> x.name == widget.name);
    state.getPokemonSpeciesAsync(widget.name.toLowerCase().split(' ')[0]).then((val){
       _startSpeak();
    });
    state.getPokemonDetaiAsync(widget.name.toLowerCase().split(' ')[0]);
   
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4000));
    _controller.repeat();
    _progressController = AnimationController(
        duration: Duration(milliseconds: 4000), vsync: this);
    _progressAnimation =
        Tween(begin: 0.0, end: 1.0).animate(_progressController);
    _progressController.repeat();
    super.initState();
  }
 Future _speak(String name,String type, String description) async{
    print('voice start' + type);
    await flutterTts.speak(name + '\n \n' + type + '\n \n' + description);
}
 Future _startSpeak()async{
  final state = Provider.of<PokemonState>(context,listen: false);
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
      String  voice;
      languages = await flutterTts.getLanguages;
      //  await flutterTts.getVoices.then((val){
      //        voice = val[0];
      //        print(voice);
      //  });

      await flutterTts.setLanguage("en-US");
      // await flutterTts.setVoice("es-us-x-sfb#male_1-loca");
      await flutterTts.setVoice("en-us-x-sfg#male_2-local");
      await flutterTts.setSpeechRate(1.0);
      
      await flutterTts.setVolume(1);
      
      await flutterTts.setPitch(.8);
      await flutterTts.isLanguageAvailable("en-US");
      var list2 =  description.toString().split('.');
       var des = list2.length > 3 ? (list2[0] +'\n\n' + list2[1])  +'\n\n' + list2[2] : list2.length > 2 ? (list2[0]  +'\n\n' + list2[1])  : list2[0];
      _speak(model.name.split(' ')[0],state.pokemonSpecies.genera.firstWhere((x)=>x.language.name == 'en').genus, des);
  }
  Future _stop() async{
     await flutterTts.stop();
 }
  
  Widget  _pokemonInfo(){
    return  Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           Expanded(
             flex: 3,
             child:  Text(
                model.name,
                style: TextStyle(
                    fontSize: getFontSize(context,30),
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
                    // overflow: TextOverflow.ellipsis, 
              ),
           ),
           Padding(
             padding: EdgeInsets.only(top: 10),
             child:  customText('#' + (model.orderId.toString().length == 1  ? '00' + model.orderId.toString() : model.orderId.toString().length == 2 ? '0'+model.orderId.toString() : model.orderId.toString()),style: TextStyle(fontSize: getFontSize(context,20),color: Colors.white,fontWeight: FontWeight.w600),),
           )
          ],
        ),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            _pokemonCategoryChip(model.type1),
            SizedBox(width: 10,),
            _pokemonCategoryChip(model.type2),
          ],
        )
      ],
    );
  }

  Widget _pokemonCategoryChip(String type) {
    if(type == null || type.isEmpty){
      return Container();
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 30,
      decoration: BoxDecoration(
          color: setSecondaryColor(type),
          borderRadius: BorderRadius.circular(20)),
      child: Row(children: <Widget>[
        Text(type,style: TextStyle(color: Colors.white, fontSize: getFontSize(context,16)),),
        Image.asset(getTypeImage(type))
      ],)
    );
  }

  Widget _evalutionSection() {
     final state = Provider.of<PokemonState>(context);
    return SingleChildScrollView(
      child:  Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Evaluation Chain",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: getFontSize(context,(14))),
            ),
            SizedBox(
              height: 10,
            ),
            _evaluationChainRow('Lvl 15',state?.pokemonDetail?.name),
           Divider(),
            SizedBox(
              height: 5,
            ),
            _evaluationChainRow('Lvl 16',state?.pokemonDetail?.name),
            Divider(),
            SizedBox(
              height: 5,
            ),
            _evaluationChainRow('Lvl 17',state?.pokemonDetail?.name),
           Divider(),
            SizedBox(
              height: 5,
            ),
            _evaluationChainRow('Lvl 18',state?.pokemonDetail?.name),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _evaluationChainRow(String lvl,String name) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: _pokemonEvaluationImage(model.image, name),
        ),
        Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Icon(
                Icons.arrow_forward,
                color: Colors.black26,
              ),
              Text(
                lvl,
                style: TextStyle(fontSize: getFontSize(context,12)),
              )
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: _pokemonEvaluationImage(model.image, name),
        ),
      ],
    );
  }

  Widget _pokemonEvaluationImage(String img, String name) {
    return Column(
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/pokeball.png',
              height: 70,
              color: Color(0xffe3e3e3),
            ),
            Image.network(
              img,
              height: 60,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        customText(
          name,
          style: TextStyle(fontSize: getFontSize(context,14)),
        )
      ],
    );
  }

  Widget _topRightPokeball() {
    return Positioned(
        right: 0,
        top: 0,
        child: Align(
            heightFactor: fullWidth(context) <= 360 ?  getDimention(context, 1.03) : .75,
            widthFactor:  fullWidth(context) <= 360 ?  getDimention(context,.98) : .7,
            alignment: Alignment.bottomLeft,
            child: RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: Opacity(
                  opacity: opacity,
                  child: Image.asset(
                    'assets/images/pokeball.png',
                    color: setSecondaryColor(model.type1),
                    height: getDimention(context, 250),
                  ),
                ))));
  }
  
  Widget _pokemonType(){
      final state = Provider.of<PokemonState>(context);
      if(state.pokemonSpecies != null && state.pokemonSpecies.genera != null && state.pokemonSpecies.genera.length > 0){
         var type = state.pokemonSpecies.genera.firstWhere((x)=>x.language.name == 'en').genus;
         return customText(type,
                style: TextStyle(color: Colors.white60, fontSize: getFontSize(context,18)),
              );
      }
      else{
        return Container();
      }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: setprimaryColor(model.type1),
      body: Stack(
        children: <Widget>[
          _topRightPokeball(),
          Positioned(
              top: -getDimention(context,20),
              left: -getDimention(context,45),
              child: Transform.rotate(
                angle: 7.6,
                child: Container(
                  height: getDimention(context,140),
                  width: getDimention(context,140),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: setSecondaryColor(model.type1),
                  ),
                ),
              )),
          Positioned(
            left:fullWidth(context) / 2 + 10,
            top: 5,
            child:  Image.asset(
                      'assets/images/dotted.png',
                      color: setSecondaryColor(model.type1),
                      height: getDimention(context,50),
                    ),
          ),
          Positioned(
            left: 10,
            top: getDimention(context,40),
            right: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BackButton(
                  color: Colors.white60,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isFavourite = !isFavourite;
                    });
                  },
                  iconSize: 40,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    size: 30,
                    color: Colors.white60,
                  ),
                )
              ],
            ),
          ),
          Positioned(
              top: 120,
              left: 20,
              width: MediaQuery.of(context).size.width - 40,
              child:_pokemonInfo()),
          Positioned(
              top: 160,
              right: 20,
              // width: MediaQuery.of(context).size.width - 40,
              child: _pokemonType()),
          Positioned(
              right: 50,
              left: 50,
              top: getDimention(context,300),
              child: Align(
                  heightFactor: getDimention(context,0.75),
                  widthFactor: .7,
                  alignment: Alignment.center,
                  child: RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: Image.asset(
                      'assets/images/pokeball.png',
                      color: setSecondaryColor(model.type1),
                      height: getDimention(context,250),
                    ),
                  ))),
          SlidingUpPanel(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            onPanelSlide: (slide) {
              // print(slide.toString());
              setState(() {
                opacity = slide;
              });
            },
            onPanelOpened: () {},
            onPanelClosed: () {},
            minHeight: MediaQuery.of(context).size.height - getDimention(context,430),
            maxHeight: MediaQuery.of(context).size.height - getDimention(context,200),
            panel: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: getFontSize(context,(20))),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: TabBar(
                    indicatorColor: setprimaryColor(model.type1),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    indicatorPadding: EdgeInsets.symmetric(horizontal: getFontSize(context,20,)),
                    tabs: [
                      Tab( child: Text('About',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: getFontSize(context,13)),),),
                      Tab(child: Text('Base State',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: getFontSize(context,13)),),),
                      Tab(child: Text('Evaluation',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: getFontSize(context,13)),),),
                      Tab(child: Text('Moves',style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900,fontSize: getFontSize(context,13),)),),
                    ],
                  ),
                  body: TabBarView(
                    children: [
                      About(model: model,),
                      BaseState(),
                      _evalutionSection(),
                      Moves(type:model.type1),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              width: MediaQuery.of(context).size.width,
              top: getDimention(context,260),
              height: getDimention(context,200 * (1 - opacity)),
              child: Opacity(
                opacity: 1 - opacity,
                child: CarouselSlider(
                  autoPlayCurve: Curves.easeInOutCirc,
                  enableInfiniteScroll: false,
                  onPageChanged: (page) {
                    print(page.toString());
                    setState(() {
                      sliderPageno = page;
                    });
                  },
                  viewportFraction: .6,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  autoPlay: false,
                  items: <Widget>[
                    AnimatedContainer(
                      constraints: BoxConstraints( maxHeight: 100),
                      duration: Duration(milliseconds: 500),
                      child: 0 == (sliderPageno)
                          ? Hero(
                              tag: model.orderId,
                               child: Image( image: customAdvanceNetworkImage(model.image,),fit: BoxFit.contain,),
                                      )
                          : Image(image: customAdvanceNetworkImage(model.image),color: setSecondaryColor(model.type1),),
                    ),
                   AnimatedContainer(
                      constraints: BoxConstraints( maxHeight: 1 == (sliderPageno) ? 200 : 180),
                      duration: Duration(milliseconds: 500),
                      child: 1 == (sliderPageno)
                          ?Image( image: customAdvanceNetworkImage(model.image,),fit: BoxFit.contain,)
                          : Image(image: customAdvanceNetworkImage(model.image),color: setSecondaryColor(model.type1),),
                    ),
                  AnimatedContainer(
                     constraints: BoxConstraints( maxHeight: 2 == (sliderPageno) ? 200 : 150),
                      duration: Duration(milliseconds: 500),
                      child: 2 == (sliderPageno)
                          ? Image( image: customAdvanceNetworkImage(model.image,),fit: BoxFit.contain,)
                          : Image(image: customAdvanceNetworkImage(model.image),color: setSecondaryColor(model.type1),),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
