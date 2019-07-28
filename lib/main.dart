import 'package:flutte_pokedex/pages/homePageBody.dart';
import 'package:flutte_pokedex/pages/pokemonListPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: MyHomePage(),
        routes: {
          '/': (BuildContext context) => MyHomePage(),
          '/pokemonList': (BuildContext context) => PokemonListPage(),
        },
        // onGenerateRoute: (RouteSettings settings ){
        //     final List<String> pathElements = settings.name.split('/');
        //       if (pathElements[0] != '') {
        //         return null;
        //       }
        //       if(pathElements[0].contains('detail')){

        //         return MaterialPageRoute<bool>(builder:(BuildContext context)=> HomePageBody());
        //       }
        // },
        );
  }
}

class MyHomePage extends StatefulWidget {
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
