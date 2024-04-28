import 'package:state_manager/state_manager.dart';

enum FilterType { ID, NAME, NAME_REVERSED }

class GetAllFavoritesParams extends Params {
  final FilterType type;

  GetAllFavoritesParams({this.type = FilterType.ID});
}
