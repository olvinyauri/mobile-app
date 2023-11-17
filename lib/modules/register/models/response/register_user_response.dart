// To parse this JSON data, do
//
//     final registerUserResponse = registerUserResponseFromJson(jsonString);

import 'dart:convert';

RegisterUserResponse registerUserResponseFromJson(String str) =>
    RegisterUserResponse.fromJson(json.decode(str));

String registerUserResponseToJson(RegisterUserResponse data) =>
    json.encode(data.toJson());

class RegisterUserResponse {
  int? statusCode;
  String? message;
  Data? data;

  RegisterUserResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  RegisterUserResponse copyWith({
    int? statusCode,
    String? message,
    Data? data,
  }) =>
      RegisterUserResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) =>
      RegisterUserResponse(
        statusCode: json["status_code"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  dynamic roleId;
  String? name;
  String? email;
  dynamic phone;
  String? address;
  String? birthDate;
  String? gender;
  String? username;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data({
    this.roleId,
    this.name,
    this.email,
    this.phone,
    this.address,
    this.birthDate,
    this.gender,
    this.username,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Data copyWith({
    dynamic roleId,
    String? name,
    String? email,
    dynamic phone,
    String? address,
    String? birthDate,
    String? gender,
    String? username,
    String? updatedAt,
    String? createdAt,
    int? id,
  }) =>
      Data(
        roleId: roleId ?? this.roleId,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        username: username ?? this.username,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        roleId: json["role_id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        username: json["username"],
        updatedAt: json["updated_at"],
        createdAt: json["created_at"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "role_id": roleId,
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "birth_date": birthDate,
        "gender": gender,
        "username": username,
        "updated_at": updatedAt,
        "created_at": createdAt,
        "id": id,
      };
}
