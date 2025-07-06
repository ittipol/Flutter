class ApiBaseUrl {
  static String? _localhostUrl;
  static String? _localhostApiBaseUrl;
  static String? _localhostWebAppBaseUrl;

  static String get localhostUrl => _localhostUrl ?? "";

  static set localhostUrl(String value) {
    _localhostUrl = value;
  }

  static String get localhostApiBaseUrl => _localhostApiBaseUrl ?? "";

  static set localhostApiBaseUrl(String value) {
    _localhostApiBaseUrl = value;
  }

  static String get localhostWebAppBaseUrl => _localhostWebAppBaseUrl ?? "";

  static set localhostWebAppBaseUrl(String value) {
    _localhostWebAppBaseUrl = value;
  }
}