class GetProfileModel {
  final int id;
  final String customerCode;
  final String firstName;
  final String lastName;
  final String firstNameArabic;
  final String lastNameArabic;
  final String gender;
  final double height;
  final double weight;
  final String dateOfBirth;
  final String mobile;
  final String email;
  final String? profilePicture;
  final String subscriptionEndDate;
  final dynamic subscriptionEndIn;

  GetProfileModel({
    required this.id,
    required this.customerCode,
    required this.firstName,
    required this.lastName,
    required this.firstNameArabic,
    required this.lastNameArabic,
    required this.gender,
    required this.height,
    required this.weight,
    required this.dateOfBirth,
    required this.mobile,
    required this.email,
    required this.profilePicture,
    required this.subscriptionEndDate,
    required this.subscriptionEndIn,
  });

  factory GetProfileModel.fromJson(Map<String, dynamic> json) =>
      GetProfileModel(
        id: json["id"],
        customerCode: json["customer_code"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        firstNameArabic: json["first_name_arabic"],
        lastNameArabic: json["last_name_arabic"],
        gender: json["gender"],
        height: json["height"],
        weight: json["weight"],
        dateOfBirth: json["date_of_birth"],
        mobile: json["mobile"],
        email: json["email"],
        profilePicture: json["profile_picture"],
        subscriptionEndDate: json["subscription_end_date"],
        subscriptionEndIn: json["subscription_end_in"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "first_name_arabic": firstNameArabic,
        "last_name_arabic": lastNameArabic,
        "gender": gender,
        "height": height,
        "weight": weight,
        "date_of_birth": dateOfBirth,
        "mobile": mobile,
        "email": email,
        "profile_picture": profilePicture,
        "subscription_end_date": subscriptionEndDate,
        "subscription_end_in": subscriptionEndIn,
      };
}
