import 'package:failure/failure_package.dart';

class CapturedBlocFailure extends Failure {
  CapturedBlocFailure({required super.message, super.stacktrace});
}
