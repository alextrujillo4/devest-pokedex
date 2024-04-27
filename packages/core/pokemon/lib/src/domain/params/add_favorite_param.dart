import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

class AddFavorite extends Params {
  final IPokemon pokemon;

  AddFavorite({required this.pokemon});
}
