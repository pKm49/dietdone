import 'dart:convert';

class DietMealsModel {
  double subscriptionRecommendedCalories;
  Meals meals;

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
        meals: Meals.fromJson(json["meals"]),
      );

  Map<String, dynamic> toJson() => {
        "subscription_recommended_calories": subscriptionRecommendedCalories,
        "meals": meals.toJson(),
      };
}

class Meals {
  Breakfast breakfast;
  Breakfast lunch;
  Snacks snacks;
  Breakfast dinner;
  MainCourse mainCourse;
  MainCourse snackSoup;
  MainCourse salad;

  Meals({
    required this.breakfast,
    required this.lunch,
    required this.snacks,
    required this.dinner,
    required this.mainCourse,
    required this.snackSoup,
    required this.salad,
  });

  factory Meals.fromRawJson(String str) => Meals.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Meals.fromJson(Map<String, dynamic> json) => Meals(
        breakfast: Breakfast.fromJson(json["Breakfast"]),
        lunch: Breakfast.fromJson(json["Lunch"]),
        snacks: Snacks.fromJson(json["Snacks"]),
        dinner: Breakfast.fromJson(json["Dinner"]),
        mainCourse: MainCourse.fromJson(json["Main Course"]),
        snackSoup: MainCourse.fromJson(json["Snack & Soup"]),
        salad: MainCourse.fromJson(json["Salad"]),
      );

  Map<String, dynamic> toJson() => {
        "Breakfast": breakfast.toJson(),
        "Lunch": lunch.toJson(),
        "Snacks": snacks.toJson(),
        "Dinner": dinner.toJson(),
        "Main Course": mainCourse.toJson(),
        "Snack & Soup": snackSoup.toJson(),
        "Salad": salad.toJson(),
      };
}

class Breakfast {
  int id;
  String name;
  String arabicName;
  int itemCount;
  List<BreakfastItem> items;

  Breakfast({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.itemCount,
    required this.items,
  });

  factory Breakfast.fromRawJson(String str) =>
      Breakfast.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Breakfast.fromJson(Map<String, dynamic> json) => Breakfast(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        itemCount: json["item_count"],
        items: List<BreakfastItem>.from(
            json["items"].map((x) => BreakfastItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "item_count": itemCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class BreakfastItem {
  int id;
  String name;
  dynamic arabicName;
  bool description;
  bool arabicDescription;
  String image;
  double calories;

  BreakfastItem({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.image,
    required this.calories,
  });

  factory BreakfastItem.fromRawJson(String str) =>
      BreakfastItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BreakfastItem.fromJson(Map<String, dynamic> json) => BreakfastItem(
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

class MainCourse {
  int id;
  String name;
  String arabicName;
  int itemCount;
  List<MainCourseItem> items;

  MainCourse({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.itemCount,
    required this.items,
  });

  factory MainCourse.fromRawJson(String str) =>
      MainCourse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainCourse.fromJson(Map<String, dynamic> json) => MainCourse(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        itemCount: json["item_count"],
        items: List<MainCourseItem>.from(
            json["items"].map((x) => MainCourseItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "item_count": itemCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class MainCourseItem {
  int id;
  String name;
  String arabicName;
  bool description;
  bool arabicDescription;
  String image;
  double calories;

  MainCourseItem({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.image,
    required this.calories,
  });

  factory MainCourseItem.fromRawJson(String str) =>
      MainCourseItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MainCourseItem.fromJson(Map<String, dynamic> json) => MainCourseItem(
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

class Snacks {
  int id;
  String name;
  String arabicName;
  int itemCount;
  List<SnacksItem> items;

  Snacks({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.itemCount,
    required this.items,
  });

  factory Snacks.fromRawJson(String str) => Snacks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Snacks.fromJson(Map<String, dynamic> json) => Snacks(
        id: json["id"],
        name: json["name"],
        arabicName: json["arabic_name"],
        itemCount: json["item_count"],
        items: List<SnacksItem>.from(
            json["items"].map((x) => SnacksItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "arabic_name": arabicName,
        "item_count": itemCount,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class SnacksItem {
  int id;
  String name;
  bool arabicName;
  bool description;
  bool arabicDescription;
  String image;
  double calories;

  SnacksItem({
    required this.id,
    required this.name,
    required this.arabicName,
    required this.description,
    required this.arabicDescription,
    required this.image,
    required this.calories,
  });

  factory SnacksItem.fromRawJson(String str) =>
      SnacksItem.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SnacksItem.fromJson(Map<String, dynamic> json) => SnacksItem(
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
