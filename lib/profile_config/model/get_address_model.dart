class GetAddressModel {
  final int id;
  final String name;
  final int areaId;
  final String areaName;
  final String areaNameArabic;
  final int blockId;
  final String blockName;
  final String blockNameArabic;
  final String street;
  final String jedha;
  final String houseNumber;
  final String floorNumber;
  final String comments;

  GetAddressModel({
    required this.id,
    required this.name,
    required this.areaId,
    required this.areaName,
    required this.areaNameArabic,
    required this.blockId,
    required this.blockName,
    required this.blockNameArabic,
    required this.street,
    required this.jedha,
    required this.houseNumber,
    required this.floorNumber,
    required this.comments,
  });

  factory GetAddressModel.fromJson(Map<String, dynamic> json) =>
      GetAddressModel(
        id: json["id"],
        name: json["name"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        areaNameArabic: json["area_name_arabic"],
        blockId: json["block_id"],
        blockName: json["block_name"],
        blockNameArabic: json["block_name_arabic"],
        street: json["street"],
        jedha: json["jedha"],
        houseNumber: json["house_number"],
        floorNumber: json["floor_number"],
        comments: json["comments"] == null||json["comments"] == ""?"*" : json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "area_id": areaId,
        "area_name": areaName,
        "area_name_arabic": areaNameArabic,
        "block_id": blockId,
        "block_name": blockName,
        "block_name_arabic": blockNameArabic,
        "street": street,
        "jedha": jedha,
        "house_number": houseNumber,
        "floor_number": floorNumber,
        "comments": comments,
      };
}
