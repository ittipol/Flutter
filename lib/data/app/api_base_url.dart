class ApiBaseUrl {
  static String? _localhostBaseUrl;

  static String get localhostBaseUrl => _localhostBaseUrl ?? "";

  static set localhostBaseUrl(String value) {
    _localhostBaseUrl = value;
  }
}