import 'dart:convert';

import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/data/dto/pokedex_dto.dart';
import 'package:network/network.dart';

abstract class PokedexRemoteDataSource {
  Future<IPokedex> requestPokedexByRegion(String region);
}

class PokedexRemoteDataSourceImpl implements PokedexRemoteDataSource {
  final HttpInterceptor http;

  const PokedexRemoteDataSourceImpl({required this.http});

  @override
  Future<IPokedex> requestPokedexByRegion(
      String region
  ) async {

    final call = await http.requestGet(
      path: 'pokedex/$region'
    );

    final data = json.decode(call.body);

    try {
      return PokedexDto.fromJson(data).toDomain();
    } catch (e, s) {
      throw ParseFailure(
        message: 'Error parsing PokedexDto: $e',
        stacktrace: s,
      );
    }
  }
}
