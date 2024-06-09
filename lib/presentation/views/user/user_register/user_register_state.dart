enum UserRegisterStatus { loading, success, failure }

class UserRegisterState {
  final UserRegisterStatus status;
  final String? message;

  UserRegisterState({
    this.status = UserRegisterStatus.loading,
    this.message
  });

  copyWith({UserRegisterStatus? status, String? message}) => UserRegisterState(
    status: status ?? this.status,
    message: message ?? this.message
  );
}