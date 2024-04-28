import 'package:state_manager/state_manager.dart';

enum OrderBy { TYPE, NAME, ID }

class PokedexParams extends Params {
  final String region;
  final String? query;

  PokedexParams({required this.region, this.query});
}
