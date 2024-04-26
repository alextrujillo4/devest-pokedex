import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/constants/app_strings.dart';
import 'package:flutter_pokedex/common/constants/theme.dart';
import 'package:network/di.dart' as network;
import 'package:pokedex/di.dart' as pokedex;
import 'package:pokemon/di.dart' as pokemon;
import 'package:storage/di.dart' as storage;

import 'di.dart';
import 'features/encyclopedia/page/encyclopedia_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await network.init();
  await storage.init();
  await pokemon.init();
  await pokedex.init();
  await init();
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appBarTitle,
      theme: appTheme,
      home: MultiBlocProvider(
        providers: const [],
        child: const EncyclopediaPage(),
      ),
    );
  }
}
