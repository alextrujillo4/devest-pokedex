import 'package:http/http.dart' as http;

import '../network.dart';

class HttpInterceptor {
  final Client _client;

  HttpInterceptor({
    required Client client,
  }) : _client = client;

  /// Makes a GET request and handles potential errors.
  Future<http.Response> requestGet({
    required String path,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    http.Response response = await _client.get(path).timeout(timeout);
    await _handleResponseError(response);
    return response;
  }

  /// Makes a POST request and handles potential errors.
  Future<http.Response> requestPost({
    required String path,
    Object? body,
    Duration timeout = const Duration(seconds: 60),
  }) async {
    http.Response response =
        await _client.post(path, body: body).timeout(timeout);
    return response;
  }

  /// Handles different error scenarios based on the HTTP status code.
  Future<void> _handleResponseError(http.Response response) async {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      switch (response.statusCode) {
        case 400:
          throw BadRequestFailure(
              message: response.body, stacktrace: StackTrace.current);
        case 401:
          throw UnauthorizedFailure(
              message: response.body, stacktrace: StackTrace.current);
        case 403:
          throw ForbiddenFailure(
            message: response.body,
            stacktrace: StackTrace.current,
          ); // No DTO needed
        case 404:
          throw NotFoundFailure(
              message: response.body, stacktrace: StackTrace.current);
        default:
          throw ApiCallFailure(
              message: response.body, stacktrace: StackTrace.current);
      }
    }
  }
}
