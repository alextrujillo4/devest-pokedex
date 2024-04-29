import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class ScreenTester {
  late WidgetTester tester;

  ScreenTester(this.tester);

  //EncyclopediaPage
  final pokeballBtn = find.byKey(const ValueKey("pokeball_btn"));
  final encyclopediaPokemonItem =
      find.byKey(const ValueKey("encyclopedia_pokemon_item_0"));
  final searchWidget = find.byKey(const ValueKey("search_widget"));
  final pokemonEntryName = find.byKey(const ValueKey("entry_naming"));
  final encyclopediaPage = find.byKey(const ValueKey("encyclopedia_page"));

  //emptyWidget
  final emptyWidget = find.byKey(const ValueKey("empty_widget"));

  //Detail
  final detailPage = find.byKey(const ValueKey("detail_page"));
  final pokemonName = find.byKey(const ValueKey("pokemon_name"));
  final detailBackBtn = find.byKey(const ValueKey("detail_back_btn"));
  final captureBtn = find.byKey(const ValueKey("capture_btn"));

  //Captured
  final capturedPage = find.byKey(const ValueKey("captured_page"));
  final capturedBackBtn = find.byKey(const ValueKey("captured_back_btn"));
  final capturedPokemonItem =
      find.byKey(const ValueKey("captured_pokemon_item_0"));
  final pokemonCapturedName = find.byKey(const ValueKey("captured_naming"));

  Future<void> goToCapturedPage() async {
    await tester.tap(pokeballBtn, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> backFromCaptured() async {
    await tester.tap(capturedBackBtn, warnIfMissed: true);
    await tester.pumpAndSettle();
  }
  Future<void> backFromDetail() async {
    await tester.tap(detailBackBtn, warnIfMissed: true);
    await tester.pumpAndSettle();
  }


  Future<void> clickSomeWhereInTheApp() async {
    await tester.tap(find.byType(AppBar), warnIfMissed: true);
  }

  Future<void> clickFirstEncyclopediaPokemon() async {
    await tester.tap(encyclopediaPokemonItem, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<void> clickFirstCapturedPokemon() async {
    await tester.tap(capturedPokemonItem, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<bool> isEmptyWidgetPresent() async {
    return tester.any(emptyWidget);
  }

  Future<bool> isDetailPagePresent() async {
    return tester.any(detailPage);
  }

  Future<void> detailScrollUp() async {
    return tester.scrollUntilVisible(detailBackBtn, -100);
  }
  Future<void> detailScrollDown() async {
    return tester.scrollUntilVisible(captureBtn, 100);
  }

  Future<void> clickCapturePokemon() async {
    await tester.tap(captureBtn, warnIfMissed: true);
    await tester.pumpAndSettle();
  }

  Future<bool> isFavoritesPresent() async {
    return tester.any(capturedPage);
  }

  Future<bool> isEncyclopediaPresent() async {
    return tester.any(encyclopediaPage);
  }
}
