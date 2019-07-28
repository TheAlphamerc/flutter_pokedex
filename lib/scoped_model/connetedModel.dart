import 'package:flutte_pokedex/model/pokemon.dart';
import 'package:scoped_model/scoped_model.dart';

class ConnectedModel extends Model{
  List<Pokemon> _pokemonList = [
   Pokemon(id: 1, name: 'Balbasaur',type: 'Grass', image: 'assets/images/pokimon_1.png'),
   Pokemon(id: 2, name: 'Pikachu',type: 'Fire', image: 'assets/images/pokimon_2.png'),
   Pokemon(id: 3, name: 'Balbasaur',type: 'Water', image: 'assets/images/pokimon_3.png'),
   Pokemon(id: 4, name: 'Balbasaur',type: 'Grass', image: 'assets/images/pokimon_4.png'),
   Pokemon(id: 5, name: 'Squartle',type: 'Water', image: 'assets/images/pokimon_5.png'),
   Pokemon(id: 6, name: 'Balbasaur',type: 'Rock', image: 'assets/images/pokimon_6.png'),
   Pokemon(id: 7, name: 'Balbasaur',type: 'Grass', image: 'assets/images/pokimon_7.png'),
   Pokemon(id: 8, name: 'Balbasaur',type: 'Water', image: 'assets/images/pokimon_8.png'),
   Pokemon(id: 9, name: 'Balbasaur',type: 'Rock', image: 'assets/images/pokimon_9.png'),
   Pokemon(id: 11, name: 'Charlizard',type: 'Fire', image: 'assets/images/pokimon_11.png'),
   Pokemon(id: 12, name: 'Charlizard',type: 'Rock', image: 'assets/images/pokimon_12.png'),
   Pokemon(id: 13, name: 'Charlizard',type: 'Grass', image: 'assets/images/pokimon_13.png'),
   Pokemon(id: 14, name: 'Charlizard',type: 'Water', image: 'assets/images/pokimon_14.png'),
   Pokemon(id: 15, name: 'Charlizard',type: 'Fire', image: 'assets/images/pokimon_15.png'),
   Pokemon(id: 16, name: 'Charlizard',type: 'Grass', image: 'assets/images/pokimon_16.png'),
   Pokemon(id: 17, name: 'Charlizard',type: 'Fire', image: 'assets/images/pokimon_17.png'),
   Pokemon(id: 18, name: 'Charlizard',type: 'Water', image: 'assets/images/pokimon_18.png'),
   Pokemon(id: 19, name: 'Charlizard',type: 'Rock', image: 'assets/images/pokimon_19.png'),
   Pokemon(id: 20, name: 'Charlizard',type: 'Fire', image: 'assets/images/pokimon_20.png'),
   Pokemon(id: 21, name: 'Charlizard',type: 'FiWaterre', image: 'assets/images/pokimon_21.png'),
   Pokemon(id: 22, name: 'Charlizard',type: 'Grass', image: 'assets/images/pokimon_22.png'),
   Pokemon(id: 23, name: 'Charlizard',type: 'Rock', image: 'assets/images/pokimon_23.png'),
   Pokemon(id: 24, name: 'Charlizard',type: 'Grass', image: 'assets/images/pokimon_24.png'),
   Pokemon(id: 25, name: 'Pichu',type: 'Water', image: 'assets/images/pokimon_25.png'),
   Pokemon(id: 26, name: 'Charmender',type: 'Fire', image: 'assets/images/pokimon_26.png'),
   Pokemon(id: 27, name: 'Charlizard',type: 'Rock', image: 'assets/images/pokimon_27.png'),
  ];
}
class MainModel extends ConnectedModel {

   List<Pokemon> get allPokemon{
    return  List.from(_pokemonList);
  }
}