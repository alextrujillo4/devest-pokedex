import 'dart:convert';

import 'package:pokemon/pokemon_package.dart';
import 'package:pokemon/src/data/dto/pokemon_dto.dart';
import 'package:pokemon/src/domain/entity/ipokemon.dart';
import 'package:pokemon/src/domain/entity/pokemon.dart';
import 'package:storage/storage_package.dart';
import 'package:network/network.dart';

abstract class PokemonLocalDatasource {
  Future<List<IPokemon>> getFavorites();

  Future<IPokemon> getFavoriteById(int id);

  Future<bool> deleteFromFavorites(int id);

  Future<bool> addToFavorites(Pokemon pokemon);

  Future<bool> isFavorite(int id);
}

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  static const String pokemonKEY = "POKEMON_KEY";
  static const int maxElements = 100;
  final Storage storage;

  PokemonLocalDatasourceImpl({required this.storage});

  @override
  Future<bool> addToFavorites(Pokemon pokemon) async {
    List<Pokemon> existingPokemons = await _loadPokemons();
    existingPokemons.insert(0, pokemon);
    _ensureListMaxSize(existingPokemons);
    List<String> dataToString = existingPokemons.map((e) => e.toJson()).toList();
    return await storage.setStringList(pokemonKEY, dataToString);
  }

  @override
  Future<bool> deleteFromFavorites(int id) async {
    List<Pokemon> existingPokemons = await _loadPokemons();
    existingPokemons.removeWhere((element) => element.id == id);
    _ensureListMaxSize(existingPokemons);
    List<String> dataToString = existingPokemons.map((e) => e.toJson()).toList();
    return await storage.setStringList(pokemonKEY, dataToString);
  }

  @override
  Future<List<IPokemon>> getFavorites() async {
    return await _loadPokemons();
  }

  @override
  Future<bool> isFavorite(int id) async {
    final existingPokemons = await _loadPokemons();
    return existingPokemons.any((pokemon) => pokemon.id == id);
  }

  Future<List<Pokemon>> _loadPokemons() async {
    try {
      final encodedData = storage.getStringList(pokemonKEY);
      return encodedData
          .map((e) => PokemonDto.fromJson(json.decode(e)).toDomain())
          .toList();
    } catch (e, s) {
      throw ParseFailure(
        message: 'Error parsing Pokemon: $e',
        stacktrace: s,
      );
    }
  }

  void _ensureListMaxSize(List<IPokemon> list) {
    if (list.length > maxElements) {
      list.removeLast();
    }
  }

  @override
  Future<IPokemon> getFavoriteById(int id) async {
    final existingPokemons = await _loadPokemons();
    final pokemon = existingPokemons.firstWhere((pokemon) => pokemon.id == id,
        orElse: () => throw CacheFailure(
              message: 'Pokemon not found on local cache.',
              stacktrace: StackTrace.current,
            ));
    return pokemon;
  }
}
