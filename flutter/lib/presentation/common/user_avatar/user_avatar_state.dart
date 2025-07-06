class UserAvatarState {
  
  final String? name;
  final bool isLoggedIn;

  UserAvatarState({
    this.name,
    required this.isLoggedIn,
  });

  copyWith({String? name, bool? isLoggedIn}) => UserAvatarState(
    name: name ?? this.name,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn
  );

}