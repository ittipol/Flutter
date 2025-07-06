class Authentication {

  static String? _accessToken;
  static String? _refreshToken;

  static bool get isLoggedIn => _accessToken?.isNotEmpty ?? false;

  static String get accessToken => _accessToken ?? "";
  static String get refreshToken => _refreshToken ?? "";

  static void setToken({required String accessToken, required String refreshToken}) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  static void setRefreshToken(String refreshToken) {
    _refreshToken = refreshToken;
  }

  static void clearToken() {
    _accessToken = "";
    _refreshToken = "";
  }
}