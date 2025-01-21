class Certificate {

  static const List<String> allowedSHAFingerprints = [
    "9F 70 BD DC 76 4C 5F 6D F5 D3 40 64 D8 62 99 C9 05 6F DE 7C 6D 1C 81 59 E2 D5 BD C2 44 BF 58 1E", // localhost:5050
    "00 FF AA D8 CC 6C 3A B4 CC 7D F5 0E A1 C1 0C 51 61 0D 96 86 21 65 24 7A CA 7A F3 AF E2 CE A0 2D" // pokeapi.co
  ];

  static String? _certificate;

  static String get certificate => _certificate ?? "";

  static set certificate(String value) {
    _certificate = value;
  }
}