import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/home_screen.dart';
import 'package:network/di.dart' as network;
import 'package:pokedex/di.dart' as pokedex;
import 'package:pokemon/di.dart' as pokemon;
import 'package:storage/di.dart' as storage;

import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await network.init();
  await storage.init();
  await pokemon.init();
  await pokedex.init();
  await init();
  runApp(const Pokedex());
}

class Pokedex extends StatelessWidget {
  const Pokedex({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokédex Code Challenge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: const [],
        child: const HomeScreen(),
      ),
    );
  }
}
