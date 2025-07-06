enum UserLoginStatus { loading, success, failure }

class UserLoginState {
  final UserLoginStatus status;
  final String? accessToken;
  final String? refreshToken;

  UserLoginState({
    this.status = UserLoginStatus.loading,
    this.accessToken,
    this.refreshToken,
  });

  copyWith({UserLoginStatus? status, String? accessToken, String? refreshToken}) => UserLoginState(
    status: status ?? this.status,
    accessToken: accessToken ?? this.accessToken,
    refreshToken: refreshToken ?? this.refreshToken
  );
}