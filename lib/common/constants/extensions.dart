extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
extension PokemonIdExtension on int {
  String get formattedPokemonId {
    return toString().padLeft(3, '0');
  }
}