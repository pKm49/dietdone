class MealsModel {
  final int id;
  final String name;
  final String description;
  final String arabicName;
  final String arabicDescription;
  final List<int> mealCategory;
  final String image;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final String rating;
  final int ratingCount;
  final double price;
  final List<dynamic> ingredients;

  MealsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.arabicName,
    required this.arabicDescription,
    required this.mealCategory,
    required this.image,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.rating,
    required this.ratingCount,
    required this.price,
    required this.ingredients,
  });

  factory MealsModel.fromJson(Map<String, dynamic> json) => MealsModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        arabicName: json["arabic_name"],
        arabicDescription: json["arabic_description"],
        mealCategory: List<int>.from(json["meal_category"].map((x) => x)),
        image: json["image"],
        calories: json["calories"],
        protein: json["protein"],
        carbs: json["carbs"],
        fat: json["fat"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        price: json["price"],
        ingredients: List<dynamic>.from(json["ingredients"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "arabic_name": arabicName,
        "arabic_description": arabicDescription,
        "meal_category": List<dynamic>.from(mealCategory.map((x) => x)),
        "image": image,
        "calories": calories,
        "protein": protein,
        "carbs": carbs,
        "fat": fat,
        "rating": rating,
        "rating_count": ratingCount,
        "price": price,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
      };
}
