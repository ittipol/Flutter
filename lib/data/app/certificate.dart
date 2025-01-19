class Certificate {

  static const List<String> allowedSHAFingerprints = [
    "99 8E 63 B9 2D F2 2C BD 24 34 02 58 96 5C 19 27 7E 9D 71 2F 8D 0B E2 6B D4 CE 7D BF 8E E1 C4 44", // localhost:5050
    "00 FF AA D8 CC 6C 3A B4 CC 7D F5 0E A1 C1 0C 51 61 0D 96 86 21 65 24 7A CA 7A F3 AF E2 CE A0 2D" // pokeapi.co
  ];

  static String? _certificate;

  static String get certificate => _certificate ?? "";

  static set certificate(String value) {
    _certificate = value;
  }
}