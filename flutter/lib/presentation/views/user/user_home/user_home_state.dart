// enum UserHomeStateStatus { initial, loading, success, failure }

class UserHomeState {
  
  final String? name;
  final bool isLoggedIn;

  UserHomeState({
    this.name,
    required this.isLoggedIn,
  });

  copyWith({String? name, bool? isLoggedIn}) => UserHomeState(
    name: name ?? this.name,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn
  );

}