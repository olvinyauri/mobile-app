import 'dart:convert';

class DataNotificationModel {
  String? title;
  String? message;

  DataNotificationModel({
    this.title,
    this.message,
  });

  DataNotificationModel copyWith({
    String? title,
    String? message,
  }) =>
      DataNotificationModel(
        title: title ?? this.title,
        message: message ?? this.message,
      );

  factory DataNotificationModel.fromJson(String str) =>
      DataNotificationModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataNotificationModel.fromMap(Map<String, dynamic> json) =>
      DataNotificationModel(
        title: json["title"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "message": message,
      };
}
