import 'dart:convert';

class SubscriptionHistoryModel {
  int id;
  String plan;
  String planArabic;
  DateTime startDate;
  DateTime endDate;
  String state;
  List<MealsConfig> mealsConfig;

  SubscriptionHistoryModel({
    required this.id,
    required this.plan,
    required this.planArabic,
    required this.startDate,
    required this.endDate,
    required this.state,
    required this.mealsConfig,
  });

  factory SubscriptionHistoryModel.fromRawJson(String str) =>
      SubscriptionHistoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubscriptionHistoryModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionHistoryModel(
        id: json["id"],
        plan: json["plan"],
        planArabic: json["plan_arabic"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        state: json["state"],
        mealsConfig: List<MealsConfig>.from(
            json["meals_config"].map((x) => MealsConfig.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "plan": plan,
        "plan_arabic": planArabic,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "state": state,
        "meals_config": List<dynamic>.from(mealsConfig.map((x) => x.toJson())),
      };
}

class MealsConfig {
  String name;
  String arabicName;
  int itemCount;

  MealsConfig({
    required this.name,
    required this.arabicName,
    required this.itemCount,
  });

  factory MealsConfig.fromRawJson(String str) =>
      MealsConfig.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MealsConfig.fromJson(Map<String, dynamic> json) => MealsConfig(
        name: json["name"],
        arabicName: json["arabic_name"],
        itemCount: json["item_count"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "arabic_name": arabicName,
        "item_count": itemCount,
      };
}
