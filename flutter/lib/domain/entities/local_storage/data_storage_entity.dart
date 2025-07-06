class DataStorageEntity {

  String? name;
  String? refreshToken;

  DataStorageEntity({
    this.name,
    this.refreshToken,
  });

  factory DataStorageEntity.fromJson(Map<String, dynamic> json) => DataStorageEntity(
    name: json["name"],
    refreshToken: json["refreshToken"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "refreshToken": refreshToken,
  };

  copyWith({String? name, String? refreshToken}) => DataStorageEntity(
    name: name ?? this.name,
    refreshToken: refreshToken ?? this.refreshToken
  );

}