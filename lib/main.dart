import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:flutte_pokedex/pages/homePageBody.dart';
import 'package:flutte_pokedex/pages/pokemonDetailPage.dart';
import 'package:flutte_pokedex/pages/pokemonListPage.dart';
import 'package:flutte_pokedex/scoped_model/connetedModel.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MainModel model = new MainModel();
  Pokemon pokemonModel;
  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
        model: model,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: TextTheme(
              body1: TextStyle(fontSize: 14),
              body2: TextStyle(fontSize: 16),
              title: TextStyle(fontSize: 16),
              subtitle: TextStyle(fontSize: 12),
              caption: TextStyle(fontSize: 14),
              subhead: TextStyle(fontSize: 16),
              headline: TextStyle(fontSize: 16)
            )
          ),
          // home: MyHomePage(),
          routes: {
            '/': (BuildContext context) => MyHomePage(model: model),
            '/pokemonList': (BuildContext context) =>
                PokemonListPage(model: model),
            '/detail': (BuildContext context) => PokemonDetailPage()
          },
          onGenerateRoute: (RouteSettings settings ){
              final List<String> pathElements = settings.name.split('/');
                if (pathElements[0] != '') {
                  return null;
                }
                if(pathElements[1].contains('detail')){
                  var id  = int.tryParse(pathElements[2]);
                  pokemonModel = model.allPokemon.firstWhere((x) { return x.id == id;});
                  return MaterialPageRoute<bool>(builder:(BuildContext context)=> PokemonDetailPage(model: pokemonModel,));
                }
          },
        ));
  }
}

class MyHomePage extends StatefulWidget {
  final MainModel model;
  const MyHomePage({this.model});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isViewAll = false;
  double viewAllHeight = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color(0xfff4f4f4), body: HomePageBody());
  }
}
