import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutte_pokedex/helper/colorTheme.dart';
import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PokemonDetailPage extends StatefulWidget {
  PokemonDetailPage({this.model});

  // MainModel model;
  Pokemon model;

  _PokemonDetailPageState createState() => _PokemonDetailPageState();
}

class _PokemonDetailPageState extends State<PokemonDetailPage> with TickerProviderStateMixin{
  Pokemon model;
  double opacity = 0;
  int sliderPageno = 0;

  @override
 AnimationController _controller;
 AnimationController _progressController;
 Animation<double> _progressAnimation;

 @override
  void dispose() {
    _controller.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    model = widget.model;
    _controller = AnimationController(vsync: this,duration: Duration(milliseconds: 4000));
    _controller.repeat();
    _progressController = AnimationController(duration: Duration(milliseconds: 4000),vsync: this);
    _progressAnimation = Tween(begin: 0.0,end: 1.0).animate(_progressController);
    _progressController.repeat();
    super.initState();
  }

  Widget _pokemonCategoryChip(String type){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      height: 30,
      decoration: BoxDecoration(color: setSecondaryColor(type),borderRadius: BorderRadius.circular(20)),
      child: Text(type,style: TextStyle(color: Colors.white,fontSize: 16),),
    );
  }

  Widget aboutSection(){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
       Text('Balbasaur can be seen in napping in bright sunlight. There is a seed on its back. By soaking up the sun\'s rays, the seed grows progressively larger.'),
       Container(
         height: 70,
         margin: EdgeInsets.symmetric(vertical: 30),
         decoration: BoxDecoration(
           color: Colors.white,
           borderRadius: BorderRadius.circular(10),
           boxShadow: <BoxShadow>[ BoxShadow(blurRadius: 20, color: Colors.grey.withOpacity(.2), offset: Offset(0,5),) ]
         ),
         padding: EdgeInsets.symmetric(horizontal: 30,vertical: 10),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           children: <Widget>[
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
             Text('Weight',style: TextStyle(color: Colors.black87,fontFamily: 'Circular-bold'),),
             SizedBox(height: 5,),
             Text('15.2 lbs (6.9 kg)')
           ],),
           SizedBox(width: 50,),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
             Text('Height',style: TextStyle(color: Colors.black87,fontFamily: 'Circular-bold'),),
             SizedBox(height: 5,),
             Text('2\'3.5(0.70 cm"')
           ],),
         ],),
       ),
       Text('Breeding',style: TextStyle(fontWeight:FontWeight.w600 ),),
       SizedBox(height: 10,),
       Row(children: <Widget>[
         Text('Gender',style:TextStyle(fontSize: 14,color: Colors.black45),),
         SizedBox(width: 50,),
         Text('Male 87%',style:TextStyle(fontSize: 14,color: Colors.black87),),
         SizedBox(width: 50,),
         Text('Female 13%',style:TextStyle(fontSize: 14,color: Colors.black87),)
       ],),
       SizedBox(height: 10,),
       Row(children: <Widget>[
         Text('Egg Groups',style:TextStyle(fontSize: 14,color: Colors.black45),),
         SizedBox(width: 27,),
         Text('Monster',style:TextStyle(fontSize: 14,color: Colors.black87),),
       ],),    
       SizedBox(height: 10,),
       Row(children: <Widget>[
         Text('Egg Cycle',style:TextStyle(fontSize: 14,color: Colors.black45),),
         SizedBox(width: 37,),
         Text('Grass',style:TextStyle(fontSize: 14,color: Colors.black87),),
       ],),    
       SizedBox(height: 10,),
       Text('Location',style: TextStyle(fontWeight:FontWeight.w600 ),),
       SizedBox(height:10,),
       Container(
         height: 150,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),color: setprimaryColor(model.type),
           image: DecorationImage(
             image: NetworkImage('https://tr4.cbsistatic.com/hub/i/r/2014/07/09/5ddb5529-bdc9-4656-913d-8cc299ea5e15/resize/1200x/b4fddca0887e8fdbdef49b4515c2844a/staticmapgoogle0514.png',),
             fit: BoxFit.cover
             )),
          //  child: Image.network('https://tr4.cbsistatic.com/hub/i/r/2014/07/09/5ddb5529-bdc9-4656-913d-8cc299ea5e15/resize/1200x/b4fddca0887e8fdbdef49b4515c2844a/staticmapgoogle0514.png',fit:BoxFit.cover,),
           ),
           SizedBox(height:15,),
            Text('Training',style: TextStyle(fontWeight:FontWeight.w600 ),),
       SizedBox(height: 10,),
       Row(children: <Widget>[
         Text('Base EXP',style:TextStyle(fontSize: 14,color: Colors.black45),),
         SizedBox(width: 50,),
         Text('64',style:TextStyle(fontSize: 14,color: Colors.black87),),
        
       ],),
     ],),
    );
  }

  Widget _baseStateSection(){
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
        _baseStateProperty('Attack',60,setprimaryColor("Grass")),
        SizedBox(height: 20,),
        _baseStateProperty('Defence',48,setprimaryColor("Fire")),
        SizedBox(height: 20,),
        _baseStateProperty('Sp. Atk',65,setprimaryColor("Water")),
        SizedBox(height: 20,),
        _baseStateProperty('Speed',45,setprimaryColor("Grass")),
        SizedBox(height: 20,),
        _baseStateProperty('Total',87,setprimaryColor("Fire")),
        SizedBox(height: 40,),
        Text('Type Defence',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        SizedBox(height: 20,),
        Text('Type Defence',style: TextStyle(fontSize: 14,color: Colors.black54),)
      ],)
    );
  }

  Widget _baseStateProperty(String property, double value,Color color){
    return Row(children: <Widget>[
      Expanded(
        flex: 2,
      child:  Text(property,style:TextStyle(fontSize: 15,color: Colors.black54),),
    ),

    Expanded(
      flex: 1,
      child: Text(value.toString(),style:TextStyle(fontSize: 15,color: Colors.black),),
    ),
    Expanded(
      flex: 4,
      child: 
        LinearProgressIndicator(
        value: _progressAnimation.value,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
     
    ),
    ],);
  }
  
  Widget  _evalutionSection(){
    return Container(
    padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Text("Evaluation Chain",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),
      SizedBox(height: 20,),
      _evaluationChainRow('Lvl 15'),
      SizedBox(height: 20,),
      _evaluationChainRow('Lvl 16'),
      SizedBox(height: 20,),
      _evaluationChainRow('Lvl 17'),SizedBox(height: 20,),
      _evaluationChainRow('Lvl 18'),SizedBox(height: 20,),
    ],),
    );
  }
  Widget _evaluationChainRow(String lvl){
    return Row(children: <Widget>[
     Expanded(flex: 1, child:  _pokemonEvaluationImage(model.image,'Bulbasaur'),),
      Expanded(flex: 2,child: Column(children: <Widget>[
       Icon(Icons.arrow_forward,color: Colors.black26,),
       Text(lvl,style: TextStyle(fontSize: 12),)
      ],),),
      Expanded(flex: 1, child:  _pokemonEvaluationImage(model.image,'Ivysaur'),),
    ],);
  }
  Widget _pokemonEvaluationImage(String img, String name){
    return Column(children: <Widget>[
       Stack(
         alignment: Alignment.center,
         children: <Widget>[
         Image.asset('assets/images/pokeball.png',height: 70,color: Color(0xffe3e3e3),),
         Image.asset(img,height: 60,)
       ],),
       SizedBox(height: 10,),
       Text(name,style: TextStyle(fontSize: 14),)
    ],);
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
          SlidingUpPanel(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
            onPanelSlide: (slide){
             // print(slide.toString());
              setState(() {
                opacity = slide;
              });
            },
            onPanelOpened: (){print('panel opened');},
            onPanelClosed: (){ print('Panel closed');},
            minHeight: MediaQuery.of(context).size.height - 430,
            maxHeight: MediaQuery.of(context).size.height - 200,
            panel: Container(
             width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
               ),
               child:  DefaultTabController(
                  length: 4,
                  child: Scaffold(
                    backgroundColor: Colors.white,
                    appBar: TabBar(
                      indicatorColor: setprimaryColor(model.type),
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black54,
                      indicatorPadding: EdgeInsets.symmetric(horizontal: 20),
                        tabs: [
                          Tab(child: Text('About',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),),
                          Tab(child: Text('Base State',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),),
                          Tab(child: Text('Evaluation',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),),
                          Tab(child: Text('Moves',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900),),),
                          
                        ],
                      ),
                    body: TabBarView(
                      children: [
                        aboutSection(),
                        _baseStateSection(),
                        _evalutionSection(),
                        Icon(Icons.bubble_chart),
                      ],
                    ),
                  ),
                ),
           ),
          ),
           Positioned(
            width: MediaQuery.of(context).size.width,
             top: 260,
             height: 200 * (1 - opacity),
             child: Opacity(
                opacity: 1 - opacity,
                child:  CarouselSlider(
                  autoPlayCurve: Curves.easeInOutCirc,
                  enableInfiniteScroll: false,
                  onPageChanged: (page){
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
                    Container(
                       child: 0 == (sliderPageno) ? Hero(tag: model.id ,child: Image.asset(model.image),) :Image.asset(model.image,color: setSecondaryColor(model.type),),
                    ),
                     Container(
                       child: 1 == (sliderPageno) ? Image.asset(model.image):Image.asset(model.image,color: setSecondaryColor(model.type),),
                    ), 
                    Container(
                      child: 2 == (sliderPageno) ? Image.asset(model.image):Image.asset(model.image,color: setSecondaryColor(model.type),),
                    ),
                  ],
                ),)
             
          ) ,
        ],
      ),
      
    );
  }
}
