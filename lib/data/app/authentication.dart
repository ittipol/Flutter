class Authentication {
  static String accessToken = "";
  static String refreshToken = "";

  static bool get isLoggedIn => accessToken.isNotEmpty;

  static void logout() {
    accessToken = "";
    refreshToken = "";
  }
}