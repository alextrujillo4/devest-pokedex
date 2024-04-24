import 'package:http/http.dart' as http;

abstract class Client {
  Future<http.Response> get(String path, {Map<String, String>? headers});

  Future<http.Response> post(String path,
      {Object? body, Map<String, String>? headers});
}

class HttpClient implements Client {
  final http.Client _client;
  final String _domain;

  HttpClient({http.Client? client, required String domain})
      : _client = client ?? http.Client(),
        _domain = domain;

  @override
  Future<http.Response> get(String path, {Map<String, String>? headers}) =>
      _client.get(Uri.parse(_domain + path), headers: {...?headers});

  @override
  Future<http.Response> post(String path,
          {Object? body, Map<String, String>? headers}) =>
      _client
          .post(Uri.parse(_domain + path), body: body, headers: {...?headers});
}
