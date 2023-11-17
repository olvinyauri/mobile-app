// To parse this JSON data, do
//
//     final getDoctorScheduleResponse = getDoctorScheduleResponseFromJson(jsonString);

import 'dart:convert';

GetDoctorScheduleResponse getDoctorScheduleResponseFromJson(String str) =>
    GetDoctorScheduleResponse.fromJson(json.decode(str));

String getDoctorScheduleResponseToJson(GetDoctorScheduleResponse data) =>
    json.encode(data.toJson());

class GetDoctorScheduleResponse {
  int? statusCode;
  String? message;
  List<ItemDoctorSchedule>? data;

  GetDoctorScheduleResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetDoctorScheduleResponse copyWith({
    int? statusCode,
    String? message,
    List<ItemDoctorSchedule>? data,
  }) =>
      GetDoctorScheduleResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetDoctorScheduleResponse.fromJson(Map<String, dynamic> json) =>
      GetDoctorScheduleResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ItemDoctorSchedule>.from(
                json["data"]!.map((x) => ItemDoctorSchedule.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemDoctorSchedule {
  int? id;
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleTimeEnd;
  int? qty;
  String? placeName;

  ItemDoctorSchedule({
    this.id,
    this.scheduleDate,
    this.scheduleTime,
    this.scheduleTimeEnd,
    this.qty,
    this.placeName,
  });

  ItemDoctorSchedule copyWith({
    int? id,
    String? scheduleDate,
    String? scheduleTime,
    String? scheduleTimeEnd,
    int? qty,
    String? placeName,
  }) =>
      ItemDoctorSchedule(
        id: id ?? this.id,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        scheduleTimeEnd: scheduleTimeEnd ?? this.scheduleTimeEnd,
        qty: qty ?? this.qty,
        placeName: placeName ?? this.placeName,
      );

  factory ItemDoctorSchedule.fromJson(Map<String, dynamic> json) =>
      ItemDoctorSchedule(
        id: json["id"],
        scheduleDate: json["schedule_date"],
        scheduleTime: json["schedule_time"],
        scheduleTimeEnd: json["schedule_time_end"],
        qty: json["qty"],
        placeName: json["place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_date": scheduleDate,
        "schedule_time": scheduleTime,
        "schedule_time_end": scheduleTimeEnd,
        "qty": qty,
        "place_name": placeName,
      };
}
