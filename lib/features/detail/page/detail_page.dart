import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/widgets/loading_widget.dart';
import 'package:flutter_pokedex/common/widgets/problem_widget.dart';
import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_pokedex/features/detail/widget/pokemon_detail_widget.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

class DetailPage extends StatelessWidget {
  final PokemonDetailBloc _bloc;
  final int _selectedPokemonId;

  const DetailPage({
    super.key,
    required PokemonDetailBloc bloc,
    required int selectedPokemonId,
  })  : _bloc = bloc,
        _selectedPokemonId = selectedPokemonId;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (bool didPop) {
        if (didPop) {
         // sl<FavoriteBloc>().add(Invoke(params: const NoParams()));
        }
      },
      child: Scaffold(
        key: const Key("detail_page"),
        body: BlocProvider(
          create: (_) => _bloc,
          child: BlocBuilder<PokemonDetailBloc, RequestState>(
            builder: (context, state) {
              if (state is LOADING) {
                return LoadingWidget(message: state.message);
              } else if (state is ERROR) {
                return ProblemWidget(
                  title: state.failure.toString(),
                  message: state.failure.message,
                  onTap: () {
                    context.read<PokemonDetailBloc>().add(Invoke(
                        params: RequestPokemonParam(id: _selectedPokemonId)));
                  },
                );
              } else if (state is SUCCESS<IPokemon>) {
                return PokemonDetailWidget(
                  pokemon: state.data,
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
