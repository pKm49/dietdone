class AllergiesModel {
  final int id;
  final String name;
  final String arabicName;

  AllergiesModel(
      {required this.id, required this.name, required this.arabicName});

  factory AllergiesModel.fromJson(Map<String, dynamic> json) {
    return AllergiesModel(
      id: json['id'],
      name: json['name'],
      arabicName: json['arabic_name'],
    );
  }
}
