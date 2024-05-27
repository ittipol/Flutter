class LocalStorageDemoState{
  final String? name;
  
  LocalStorageDemoState({
    this.name
  });

  copyWith({String? name}) => LocalStorageDemoState(
    name: name ?? this.name,
  );
}