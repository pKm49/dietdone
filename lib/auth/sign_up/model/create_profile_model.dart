class CreateProfileModel {
  final String mobile;
  final String password;
  final String firstName;
  final String lastName;
  final String firstNameArabic;
  final String lastNameArabic;
  final String email;
  final String dateOfBirth;
  final String gender;
  final double height;
  final double weight;
  final String source;
  final String nickname;
  final int area;
  final int block;
  final String street;
  final String jedha;
  final int houseNumber;
  final int floorNumber;
  final String comments;
  final String profile_picture;
  final String other_source;

  CreateProfileModel(
      {required this.mobile,
      required this.password,
      required this.firstName,
      required this.lastName,
      required this.firstNameArabic,
      required this.lastNameArabic,
      required this.email,
      required this.dateOfBirth,
      required this.gender,
      required this.height,
      required this.weight,
      required this.source,
      required this.nickname,
      required this.area,
      required this.block,
      required this.street,
      required this.jedha,
      required this.houseNumber,
      required this.floorNumber,
      required this.comments,
      required this.profile_picture,
      required this.other_source});

  factory CreateProfileModel.fromJson(Map<String, dynamic> json) =>
      CreateProfileModel(
        mobile: json["mobile"],
        password: json["password"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        firstNameArabic: json["first_name_arabic"],
        lastNameArabic: json["last_name_arabic"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        height: json["height"],
        weight: json["weight"],
        source: json["source"],
        nickname: json["nickname"],
        area: json["area_id"],
        block: json["block_id"],
        street: json["street"],
        jedha: json["jedha"],
        houseNumber: json["house_number"],
        floorNumber: json["floor_number"],
        comments: json["comments"],
        profile_picture: json["profile_picture"],
        other_source: json["other_source"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "password": password,
        "first_name": firstName,
        "last_name": lastName,
        "first_name_arabic": firstNameArabic,
        "last_name_arabic": lastNameArabic,
        "email": email,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "height": height,
        "weight": weight,
        "source": source,
        "nickname": nickname,
        "area_id": area,
        "block_id": block,
        "street": street,
        "jedha": jedha,
        "house_number": houseNumber,
        "floor_number": floorNumber,
        "comments": comments,
        "profile_picture": profile_picture,
        "other_source": other_source
      };
}
