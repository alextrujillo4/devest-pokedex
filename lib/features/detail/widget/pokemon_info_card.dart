import 'package:flutter/material.dart';

class PokemonInfoCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const PokemonInfoCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black.withOpacity(0.1),
      child: Container(
        padding: padding,
        width: double.infinity,
        child: child,
      ),
    );
  }
}
