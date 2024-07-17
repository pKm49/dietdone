class NotificationModel {
  final String dateTime;
  final String title;
  final String message;
  final String image;

  NotificationModel({
    required this.dateTime,
    required this.title,
    required this.message,
    required this.image,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        dateTime: json["datetime"],
        title: json["title"],
        message: json["message"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": dateTime,
        "title": title,
        "message": message,
        "image": image,
      };
}
