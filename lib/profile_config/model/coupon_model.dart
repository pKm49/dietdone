class CouponModel {
  final double total;
  final double discount;
  final double grandTotal;

  CouponModel({
    required this.total,
    required this.discount,
    required this.grandTotal,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        total: json["total"],
        discount: json["discount"],
        grandTotal: json["grand_total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "discount": discount,
        "grand_total": grandTotal,
      };
}
