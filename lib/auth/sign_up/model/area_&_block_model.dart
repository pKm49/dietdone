class GetAreaModel {
  final int id;
  final String name;
  final String arabicName;

  GetAreaModel(
      {required this.id, required this.name, required this.arabicName});

  factory GetAreaModel.fromJson(Map<String, dynamic> json) {
    return GetAreaModel(
      id: json["id"],
      name: json["name"],
      arabicName: json["arabic_name"],
    );
  }
}

class GetBlockModel {
  final int id;
  final String name;

  GetBlockModel({required this.id, required this.name});

  factory GetBlockModel.fromJson(Map<String, dynamic> json) {
    return GetBlockModel(
      id: json["id"],
      name: json["name"],
    );
  }
}
