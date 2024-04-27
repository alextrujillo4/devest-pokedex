class AppAssets {
  static String getFootprintImagePath(int pokemonId) {
    return 'assets/images/footprints/$pokemonId.png';
  }

  static String getTypeImagePath(String type) {
    print(type);
    return 'assets/images/types/${type.toLowerCase()}.svg';
  }
}
