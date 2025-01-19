class Certificate {
  static String? _certificate;

  static String get certificate => _certificate ?? "";

  static set certificate(String value) {
    _certificate = value;
  }
}