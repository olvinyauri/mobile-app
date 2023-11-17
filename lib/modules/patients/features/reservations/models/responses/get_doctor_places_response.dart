// To parse this JSON data, do
//
//     final getDoctorPlacesResponse = getDoctorPlacesResponseFromJson(jsonString);

import 'dart:convert';

GetDoctorPlacesResponse getDoctorPlacesResponseFromJson(String str) =>
    GetDoctorPlacesResponse.fromJson(json.decode(str));

String getDoctorPlacesResponseToJson(GetDoctorPlacesResponse data) =>
    json.encode(data.toJson());

class GetDoctorPlacesResponse {
  int? statusCode;
  String? message;
  List<ItemDoctorPlaces>? data;

  GetDoctorPlacesResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetDoctorPlacesResponse copyWith({
    int? statusCode,
    String? message,
    List<ItemDoctorPlaces>? data,
  }) =>
      GetDoctorPlacesResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetDoctorPlacesResponse.fromJson(Map<String, dynamic> json) =>
      GetDoctorPlacesResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<ItemDoctorPlaces>.from(
                json["data"]!.map((x) => ItemDoctorPlaces.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ItemDoctorPlaces {
  int? id;
  String? name;
  String? address;
  int? reservationable;
  int? employeeId;
  String? doctorName;

  ItemDoctorPlaces({
    this.id,
    this.name,
    this.address,
    this.reservationable,
    this.employeeId,
    this.doctorName,
  });

  ItemDoctorPlaces copyWith({
    int? id,
    String? name,
    String? address,
    int? reservationable,
    int? employeeId,
    String? doctorName,
  }) =>
      ItemDoctorPlaces(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        reservationable: reservationable ?? this.reservationable,
        employeeId: employeeId ?? this.employeeId,
        doctorName: doctorName ?? this.doctorName,
      );

  factory ItemDoctorPlaces.fromJson(Map<String, dynamic> json) =>
      ItemDoctorPlaces(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        reservationable: json["reservationable"],
        employeeId: json["employee_id"],
        doctorName: json["doctor_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "reservationable": reservationable,
        "employee_id": employeeId,
        "doctor_name": doctorName,
      };
}
