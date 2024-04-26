import 'dart:convert';

import 'package:network/network.dart';
import 'package:pokemon/src/data/dto/pokemon_dto.dart';
import 'package:pokemon/src/domain/entity/ipokemon.dart';

abstract class PokemonRemoteDatasource {
  Future<IPokemon> requestPokemonDetail(int pokemonId);
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDatasource {
  final HttpInterceptor http;

  const PokemonRemoteDatasourceImpl({required this.http});

  @override
  Future<IPokemon> requestPokemonDetail(int pokemonId) async {
    final call = await http.requestGet(
      path: "/pokemon/$pokemonId",
    );

    final data = json.decode(call.body);
    try {
      return PokemonDto.fromJson(data).toDomain();
    } catch (e, s) {
      throw ParseFailure(
        message: 'Error parsing PokemonDto: $e',
        stacktrace: s,
      );
    }
  }
}
