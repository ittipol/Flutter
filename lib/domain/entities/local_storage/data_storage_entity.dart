class DataStorageEntity {

  String? name;

  DataStorageEntity({
    this.name
  });

  factory DataStorageEntity.fromJson(Map<String, dynamic> json) => DataStorageEntity(
    name: json["name"]
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };

}