import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:state_manager/state_manager.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            Expanded(
              child: Card(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextFormField(
                          key: const ValueKey('search_field'),
                          controller: _urlController,
                          decoration: const InputDecoration(
                            hintText: "Who's that pokemon?",
                            border: InputBorder.none,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Add a valid name";
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (input) {
                            if (_formKey.currentState!.validate()) {
                              final input = _urlController.text;
                              context.read<EncyclopediaBloc>().add(
                                    Invoke(
                                      params: PokedexParams(
                                          region: "kanto", query: input),
                                    ),
                                  );
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        key: const Key("search_search"),
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final input = _urlController.text;
                            context.read<EncyclopediaBloc>().add(
                                  Invoke(
                                    params: PokedexParams(
                                        region: "kanto", query: input),
                                  ),
                                );
                          }
                        },
                      ),
                      const SizedBox(width: 24),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                key: const Key("search_refresh"),
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  context.read<EncyclopediaBloc>().add(
                        Invoke(
                          params: PokedexParams(region: "kanto"),
                        ),
                      );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
