import 'dart:convert';

import 'package:flutte_pokedex/helper/constants.dart';
import 'package:flutte_pokedex/model/pokemonDetail.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/model/pokemonMoves.dart';
import 'package:flutte_pokedex/model/pokemonSpecies.dart';
import 'package:flutte_pokedex/scoped_model/appState.dart';
import 'package:flutter/services.dart' show rootBundle;
class PokemonState extends AppState {

  PokemonState();
  
  bool _isBusy = false;
  bool get isBusy => _isBusy;
  PokemonSpecies _pokemonSpecies;
  PokemonSpecies get pokemonSpecies => _pokemonSpecies;
  PokemonDetail _pokemonDetail;
  PokemonDetail get pokemonDetail => _pokemonDetail;
  PokemonMoves _pokemonMoves;
  PokemonMoves get  pokemonMoves => _pokemonMoves;
  List<PokemonListModel> _pokemonList;
  List<PokemonListModel>  get pokemonList{
      if(_pokemonList != null){
        return List.from(_pokemonList);
      }
      else{
        return null;
      }
  }
  void setApiBusy([bool isbusy = false]){
    _isBusy = isbusy;
  }

  Future getPokemonListAsync() async {
    try{
          setApiBusy(true);
          apiCall(isReady: true,isnotify: false);
          
         _pokemonList = await parseJsonFromAssets('assets/json/pokemonJson.txt');
         
          // var url = apiPokemonList;
          // var response = await getAsync(url);
          // if(response.statusCode != 200){
          //     print('Status code error : ${response.statusCode}');
          // }
          // else{
          //    if (response != null) {
          //        print('Api call success');
          //        _pokemonList = pokemonListResponseFromJson(response.body);
          //        if(_pokemonList != null){
          //          apiCall(isReady: false,isnotify: true);
          //        }
          //     } else {
          //       apiCall(isReady: false,isnotify: true);
          //    }
          // }
            apiCall(isReady: false,isnotify: false);
         
    }
    catch(error){
      apiCall(isReady: false,isnotify: true,isApiError: true);
      print('ERROR(getPokemonListAsync) : $error');
    }
    
  }
  Future getPokemonDetaiAsync(String name) async {
    try{
          apiCall(isReady: true,);
          
          var url = apiBaseUri + apiPokemonDetail+ name;
          var response = await getAsync(url);
          if (response != null) {
            if(response.statusCode != 200){
              print('API Status code error' + response.body);
            }
            print('Api call success');
             _pokemonDetail = pokemonDetailFromJson(response.body);
            if(_pokemonDetail != null){
              apiCall(isReady: false,isnotify: true);
            }
          } else {
           apiCall(isReady: false,isnotify: true);
         }
    }
    catch(error){
      apiCall(isReady: false,isnotify: true,isApiError: true);
      print('ERROR [getPokemonDetaiAsync]: $error');
    }
  }
  Future getPokemonSpeciesAsync(String name) async {
    try{
          apiCall(isReady: true,);
          var url = apiBaseUri + apiPokemonSpecies+ name.toString();
          var response = await getAsync(url);
          if (response != null) {
            if(response.statusCode != 200){
              print('API Status code error' + response.body);
            }
            print('Api call success');
             _pokemonSpecies = pokemonSpeciesFromJson(response.body);
            if(_pokemonDetail != null){
              apiCall(isReady: false,isnotify: true);
            }
          } else {
           apiCall(isReady: false,isnotify: true);
         }
    }
    catch(error){
      apiCall(isReady: false,isnotify: true,isApiError: true);
      print('ERROR [getPokemonSpeciesAsync]: $error');
    }
  }
  Future getPokemonMovesAsync(String name) async {
    try{
          apiCall(isReady: true,);
          var url = apiBaseUri + apiPokemonMoves+ name.toString();
          var response = await getAsync(url);
          if (response != null) {
            if(response.statusCode != 200){
              print('API Status code error' + response.body);
            }
            print('Api call success');
             _pokemonMoves = pokemonMovesFromJson(response.body);
            if(_pokemonMoves != null){
              apiCall(isReady: false,isnotify: true);
            }
          } else {
           apiCall(isReady: false,isnotify: true);
         }
    }
    catch(error){
      apiCall(isReady: false,isnotify: true,isApiError: true);
      print('ERROR [getPokemonMovesAsync]: $error');
    }
  }

dynamic parseJsonFromAssets(String assetsPath) async {
    print('--- Parse json from: $assetsPath');
    return rootBundle.loadString(assetsPath)
        .then((jsonStr) {
            var data =   jsonEncode(jsonStr);
            var  de =  pokemonListResponseFromJson(jsonDecode(data));
             return de;
        });
  }
}
