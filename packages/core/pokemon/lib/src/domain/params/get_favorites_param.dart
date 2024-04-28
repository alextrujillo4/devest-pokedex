import 'package:state_manager/state_manager.dart';

enum FilterType { ID, NAME, NAME_REVERSED }

class GetFavoritesParams extends Params {
  final FilterType type;

  GetFavoritesParams({this.type = FilterType.ID});
}
