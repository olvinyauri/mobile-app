import 'dart:convert';

GetTodayReservationsTotalResponse getTodayReservationsTotalResponseFromJson(
        String str) =>
    GetTodayReservationsTotalResponse.fromJson(json.decode(str));

String getTodayReservationsTotalResponseToJson(
        GetTodayReservationsTotalResponse data) =>
    json.encode(data.toJson());

class GetTodayReservationsTotalResponse {
  int? statusCode;
  DataTotalReservations? data;
  String? message;

  GetTodayReservationsTotalResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  GetTodayReservationsTotalResponse copyWith({
    int? statusCode,
    DataTotalReservations? data,
    String? message,
  }) =>
      GetTodayReservationsTotalResponse(
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory GetTodayReservationsTotalResponse.fromJson(
          Map<String, dynamic> json) =>
      GetTodayReservationsTotalResponse(
        statusCode: json["status_code"],
        data: json["data"] == null
            ? null
            : DataTotalReservations.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
        "message": message,
      };
}

class DataTotalReservations {
  int? totalWaiting;
  int? totalAll;

  DataTotalReservations({
    this.totalWaiting,
    this.totalAll,
  });

  DataTotalReservations copyWith({
    int? totalWaiting,
    int? totalAll,
  }) =>
      DataTotalReservations(
        totalWaiting: totalWaiting ?? this.totalWaiting,
        totalAll: totalAll ?? this.totalAll,
      );

  factory DataTotalReservations.fromJson(Map<String, dynamic> json) =>
      DataTotalReservations(
        totalWaiting: json["total_waiting"],
        totalAll: json["total_all"],
      );

  Map<String, dynamic> toJson() => {
        "total_waiting": totalWaiting,
        "total_all": totalAll,
      };
}
