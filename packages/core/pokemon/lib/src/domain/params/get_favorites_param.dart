import 'package:state_manager/state_manager.dart';

enum FilterType { id, name, nameReversed }

class GetFavoritesParams extends Params {
  final FilterType type;

  GetFavoritesParams({this.type = FilterType.id});
}
