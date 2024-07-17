class SubscriptionDetailsModel {
  final int subscriptionId;
  final String subscriptionNumber;
  final String subscriptionStatus;
  final int planId;
  final String planName;
  final String planArabicName;
  final int planDuration;
  final DateTime startDate;
  final DateTime endDate;
  final double total;
  final double couponDiscount;
  final double grandTotal;
  final int mealsCount;

  SubscriptionDetailsModel({
    required this.subscriptionId,
    required this.subscriptionNumber,
    required this.subscriptionStatus,
    required this.planId,
    required this.planName,
    required this.planArabicName,
    required this.planDuration,
    required this.startDate,
    required this.endDate,
    required this.total,
    required this.couponDiscount,
    required this.grandTotal,
    required this.mealsCount,
  });

  factory SubscriptionDetailsModel.fromJson(Map<String, dynamic> json) =>
      SubscriptionDetailsModel(
        subscriptionId: json["subscription_id"],
        subscriptionNumber: json["subscription_number"],
        subscriptionStatus: json["subscription_status"],
        planId: json["plan_id"],
        planName: json["plan_name"],
        planArabicName: json["plan_arabic_name"],
        planDuration: json["plan_duration"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        total: json["total"],
        couponDiscount: json["coupon_discount"],
        grandTotal: json["grand_total"],
        mealsCount: json["meals_count"],
      );

  Map<String, dynamic> toJson() => {
        "subscription_id": subscriptionId,
        "subscription_number": subscriptionNumber,
        "subscription_status": subscriptionStatus,
        "plan_id": planId,
        "plan_name": planName,
        "plan_arabic_name": planArabicName,
        "plan_duration": planDuration,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "total": total,
        "coupon_discount": couponDiscount,
        "grand_total": grandTotal,
        "meals_count": mealsCount,
      };
}
