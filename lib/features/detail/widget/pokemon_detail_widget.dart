import 'package:cached_network_image/cached_network_image.dart';
import 'package:d_chart/single_bar/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/constants/app_colors.dart';
import 'package:flutter_pokedex/common/constants/extensions.dart';
import 'package:flutter_pokedex/common/widgets/capture_widget.dart';
import 'package:flutter_pokedex/common/widgets/problem_widget.dart';
import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_pokedex/features/detail/widget/audio_icon_btn.dart';
import 'package:flutter_pokedex/features/detail/widget/pokemon_foot_icons.dart';
import 'package:flutter_pokedex/features/detail/widget/pokemon_info_card.dart';
import 'package:flutter_pokedex/features/detail/widget/pokemon_type_icons.dart';
import 'package:flutter_pokedex/features/detail/widget/section_title.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import '../../../di.dart';

class PokemonDetailWidget extends StatelessWidget {
  final IPokemon pokemon;

  PokemonDetailWidget({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final primaryColor =
        AppColors.getPokemonColorType[pokemon.types.first.name];
    return Stack(
      children: [
        Container(color: Colors.black),
        Container(color: primaryColor?.withOpacity(0.7)),
        SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                  AudioIconButton(
                      flowery: sl(),
                      player: sl(),
                      description: pokemon.description)
                ],
              ),
              Center(
                child: CachedNetworkImage(
                  width: 240,
                  height: 240,
                  fit: BoxFit.cover,
                  imageUrl: pokemon.picture.frontDefault ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Center(
                child: Text(
                  "STANDARD FORM",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 16,
                  child: DChartSingleBar(
                    radius: BorderRadius.circular(16),
                    backgroundColor: Colors.grey,
                    value: pokemon.baseExperience.toDouble(),
                    max: 1000,
                    foregroundColor: AppColors.goldenYellow,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: SectionTitle(
                  title: "EXP. ${pokemon.baseExperience}/1000",
                  color: AppColors.goldenYellow,
                ),
              ),
              const SizedBox(height: 24),
              PokemonInfoCard(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          pokemon.name.capitalize(),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 24.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: pokemon.types
                              .map((e) => PokemonTypeIcon(typeName: e.name))
                              .toList(),
                        ),
                      ],
                    ),
                    Text(
                      '#${pokemon.id.formattedPokemonId}',
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      pokemon.description,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 26),
                    const SectionTitle(title: "FOOTPRINT"),
                    PokemonFootIcon(id: pokemon.id)
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: PokemonInfoCard(
                      child: Column(
                        children: [
                          const SectionTitle(title: "HEIGHT"),
                          Text(
                            "${pokemon.height} DM",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: PokemonInfoCard(
                      child: Column(
                        children: [
                          const SectionTitle(title: "WEIGHT"),
                          Text(
                            "${pokemon.weight} HG",
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              PokemonInfoCard(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: pokemon.picture.backDefault ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    const Icon(
                      Icons.change_circle,
                      color: Colors.white,
                    ),
                    CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: pokemon.picture.frontDefault ?? '',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              BlocProvider(
                create: (_) => sl<PokemonDetailBloc>()
                  ..add(Invoke(params: CheckIsFavorite(id: pokemon.id))),
                child: BlocBuilder<PokemonDetailBloc, RequestState>(
                  builder: (context, state) {
                    if (state is LOADING) {
                      return const CircularProgressIndicator();
                    } else if (state is ERROR) {
                      return ProblemWidget(
                        title: state.failure.toString(),
                        message: state.failure.message,
                        onTap: () {
                          context.read<PokemonDetailBloc>().add(
                              Invoke(params: CheckIsFavorite(id: pokemon.id)));
                        },
                      );
                    } else if (state is SUCCESS<bool>) {
                      final isAlreadyCaptured = state.data;
                      return isAlreadyCaptured
                          ? CaptureWidget(
                              background: AppColors.goldFoil.withOpacity(0.8),
                              onPressed: () {
                                context.read<PokemonDetailBloc>().add(Invoke(
                                    params: DeleteFavorite(id: pokemon.id)));
                              },
                              label: 'Release Pokemon',
                              icon: const Icon(
                                Icons.catching_pokemon_outlined,
                                color: Colors.white,
                              ),
                            )
                          : CaptureWidget(
                              background: AppColors.red.withOpacity(0.8),
                              onPressed: () {
                                context.read<PokemonDetailBloc>().add(Invoke(
                                    params: AddFavorite(pokemon: pokemon)));
                              },
                              label: 'Capture Pokemon',
                              icon: const Icon(
                                Icons.catching_pokemon_outlined,
                                color: Colors.white,
                              ),
                            );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
