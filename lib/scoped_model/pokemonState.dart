import 'dart:convert';

import 'package:flutte_pokedex/helper/constants.dart';
import 'package:flutte_pokedex/model/pokemonList.dart';
import 'package:flutte_pokedex/scoped_model/appState.dart';

class PokemonState extends AppState {

  PokemonState();
  
  bool _isBusy = false;
  bool get isBusy => _isBusy;
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
          apiCall(isReady: true);
          var url = apiPokemonList;
          print('Get Api Address :- ' + url);
          var response = await getAsync(url);
          if (response != null) {
            print('Api call success');
            _pokemonList = pokemonListResponseFromJson(response.body);
            if(_pokemonList != null){
              apiCall(isReady: false,isnotify: true);
            }
          } else {
           apiCall(isReady: false,isnotify: true);
         }
    }
    catch(error){
      apiCall(isReady: false,isnotify: true,isApiError: true);
      print('ERROR: $error');
    }
    
  }
  
}
