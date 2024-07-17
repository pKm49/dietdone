class GetSubscriptionPlanModel {
  final int id;
  final String name;
  final String durationType;
  final double strikePrice;
  final double price;
  final double protein;
  final double carbohydrates;

  const GetSubscriptionPlanModel({
    required this.id,
    required this.name,
    required this.durationType,
    required this.strikePrice,
    required this.price,
    required this.protein,
    required this.carbohydrates,
  });

  factory GetSubscriptionPlanModel.fromJson(Map<String, dynamic> json) =>
      GetSubscriptionPlanModel(
        id: json['id'] as int,
        name: json['name'] as String,
        durationType: json['duration_type'],
        strikePrice: json['strike_price'],
        price: json['price'] as double,
        protein: json['protein'] as double,
        carbohydrates: json['carbohydrates'] as double,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'duration_type': durationType,
        'strike_price': strikePrice,
        'price': price,
        'protein': protein,
        'carbohydrates': carbohydrates,
      };
}
