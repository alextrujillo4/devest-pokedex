import 'package:state_manager/state_manager.dart';

enum OrderBy { TYPE, NAME, ID }

class RequestAllParam extends Params {
  final String region;
  final String? query;

  RequestAllParam({required this.region, this.query});
}
