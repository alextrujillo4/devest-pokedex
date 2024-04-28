import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

class AddToFavoriteParam extends Params {
  final IPokemon pokemon;

  AddToFavoriteParam({required this.pokemon});
}
