class GetPlanCategoriesModel {
  final int id;
  final String name;
  final String arabicName;
  final String description;
  final String arabicDescription;
  final String image;
  final List<String> mealConfiguration;
  final List<String> mealConfigurationArabic;

  GetPlanCategoriesModel({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.image,
    required this.mealConfiguration,
    required this.mealConfigurationArabic,
  });

  factory GetPlanCategoriesModel.fromJson(Map<String, dynamic> json) =>
      GetPlanCategoriesModel(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        description: json["description"],
        arabicDescription: json["arabic_description"],
        image: json["image"],
        mealConfiguration:
            List<String>.from(json["meal_configuration"].map((x) => x)),
        mealConfigurationArabic:
            List<String>.from(json["meal_configuration_arabic"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "description": description,
        "arabic_description": arabicDescription,
        "image": image,
        "meal_configuration":
            List<dynamic>.from(mealConfiguration.map((x) => x)),
        "meal_configuration_arabic":
            List<dynamic>.from(mealConfigurationArabic.map((x) => x)),
      };
}
