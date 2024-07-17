class CreateAddressModel {
  final String mobile;
  final String nickname;
  final int area;
  final int block;
  final String street;
  final String jedha;
  final int houseNumber;
  final int floorNumber;
  final int apartmentNo;
  final int deliveryTime;
  final String comments;

  CreateAddressModel({
    required this.mobile,
    required this.nickname,
    required this.area,
    required this.block,
    required this.street,
    required this.jedha,
    required this.houseNumber,
    required this.floorNumber,
    required this.apartmentNo,
    required this.deliveryTime,
    required this.comments,
  });

  factory CreateAddressModel.fromJson(Map<String, dynamic> json) {
    return CreateAddressModel(
      mobile: json['mobile'],
      nickname: json['nickname'],
      area: json['area'],
      block: json['block'],
      street: json['street'],
      jedha: json['jedha'],
      houseNumber: json['house_number'],
      floorNumber: json['floor_number'],
      apartmentNo: json['apartment_no'],
      deliveryTime: json['delivery_time'],
      comments: json['comments'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'nickname': nickname,
      'area': area,
      'block': block,
      'street': street,
      'jedha': jedha,
      'house_number': houseNumber,
      'floor_number': floorNumber,
      'apartment_no': apartmentNo,
      'delivery_time': deliveryTime,
      'comments': comments,
    };
  }
}
