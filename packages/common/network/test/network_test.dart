import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';

import 'network_test.mocks.dart';

@GenerateMocks([HttpInterceptor, HttpClient])
void main() {
  final mockDir = "${Directory.current.path}/test/mocks/";

  group("Network GET Request", () {
    const path = "some/path/to";
    late HttpInterceptor http;
    late HttpClient client;
    setUp(() {
      client = MockHttpClient();
      http = HttpInterceptor(client: client);
    });
    // GET Request
    test(
        'When a Get request is performed successfully, Then response contains status code 200',
        () async {
      when(client.get(path)).thenAnswer(
        (_) async => Response("{success:true}", 200),
      );

      Response response = await http.requestGet(path: path);
      expect(response.statusCode, 200);
    });

    test(
        'When a Get request is 404 status code, Then request throws an Failure',
        () async {
      final response_404 =
          await File('$mockDir/detail_404.html').readAsString();
      when(client.get(path)).thenAnswer(
        (_) async => Response(response_404, 404),
      );

      try {
        Response response = await http.requestGet(path: path);
        expect(response, isA<NotFoundFailure>());
      } catch (e) {
        expect(e, isA<NotFoundFailure>());
      }
    });
  });

  group("Network POST Request", () {
    // POST Request

    const path = "some/path/to";
    late HttpInterceptor http;
    late HttpClient client;
    setUp(() {
      client = MockHttpClient();
      http = HttpInterceptor(client: client);
    });
    test(
        'When a Post request is performed successfully, Then response contains status code 200',
        () async {
      when(client.post(path)).thenAnswer(
        (_) async => Response("{success:true}", 200),
      );

      Response response = await http.requestPost(path: path);
      expect(response.statusCode, 200);
    });

    test('When a Post request is non success, Then request throws an Failure',
        () async {
      when(client.get(path)).thenAnswer(
        (_) async => Response("{success:false}", 500),
      );
      try {
        Response response = await http.requestGet(path: path);
        expect(response, isA<ApiCallFailure>());
      } catch (e) {
        expect(e, isA<ApiCallFailure>());
      }
    });
  });
}
