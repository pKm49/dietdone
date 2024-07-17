import 'dart:convert';

class DietMealsModel {
  double subscriptionRecommendedCalories;
  List<Meal> meals;

  DietMealsModel({
    required this.subscriptionRecommendedCalories,
    required this.meals,
  });

  factory DietMealsModel.fromRawJson(String str) =>
      DietMealsModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DietMealsModel.fromJson(Map<String, dynamic> json) => DietMealsModel(
        subscriptionRecommendedCalories:
            json["subscription_recommended_calories"],
        meals: List<Meal>.from(json["meals"].map((x) => Meal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscription_recommended_calories": subscriptionRecommendedCalories,
        "meals": List<dynamic>.from(meals.map((x) => x.toJson())),
      };
}

class Meal {
  int id;
  String name;
  String arabicName;
  int itemCount;
  List<Item> items;

  Meal({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.itemCount,
    required this.items,
  });

  factory Meal.fromRawJson(String str) => Meal.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meal.fromJson(Map<String, dynamic> json) => Meal(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        itemCount: json["item_count"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "item_count": itemCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  int id;
  String name;
  dynamic arabicName;
  bool description;
  bool arabicDescription;
  String image;
  double calories;

  Item({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.image,
    required this.calories,
  });

  factory Item.fromRawJson(String str) => Item.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        description: json["description"],
        arabicDescription: json["arabic_description"],
        image: json["image"],
        calories: json["calories"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "description": description,
        "arabic_description": arabicDescription,
        "image": image,
        "calories": calories,
      };
}
