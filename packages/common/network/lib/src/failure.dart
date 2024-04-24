import 'package:failure/failure_package.dart';

class ApiCallFailure extends Failure {
  ApiCallFailure({required super.message, super.stacktrace});
}

class BadRequestFailure extends Failure {
  BadRequestFailure({required super.message, super.stacktrace});
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure({required super.message, super.stacktrace});
}

class ForbiddenFailure extends Failure {
  ForbiddenFailure({required super.message, super.stacktrace});
}

class NotFoundFailure extends Failure {
  NotFoundFailure({required super.message, super.stacktrace});
}

class ParseFailure extends Failure {
  ParseFailure({required super.message, super.stacktrace});
}
