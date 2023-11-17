import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';

part 'login_response.g.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  int? statusCode;
  String? message;
  String? accessToken;
  User? user;
  String? tokenType;

  LoginResponse({
    this.statusCode,
    this.message,
    this.accessToken,
    this.user,
    this.tokenType,
  });

  LoginResponse copyWith({
    int? statusCode,
    String? message,
    String? accessToken,
    User? user,
    String? tokenType,
  }) =>
      LoginResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        accessToken: accessToken ?? this.accessToken,
        user: user ?? this.user,
        tokenType: tokenType ?? this.tokenType,
      );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        statusCode: json["status_code"],
        message: json["message"],
        accessToken: json["access_token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "message": message,
        "access_token": accessToken,
        "user": user?.toJson(),
        "token_type": tokenType,
      };
}

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  int? id;
  @HiveField(1)
  int? roleId;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? phone;
  @HiveField(4)
  String? address;
  @HiveField(5)
  String? birthDate;
  @HiveField(6)
  String? gender;
  @HiveField(7)
  String? email;
  @HiveField(8)
  String? username;
  @HiveField(9)
  dynamic emailVerifiedAt;
  @HiveField(10)
  String? createdAt;
  @HiveField(11)
  String? updatedAt;
  @HiveField(12)
  int? employeeId;
  @HiveField(13)
  int? patientId;
  @HiveField(14)
  int? accessCode;

  User({
    this.id,
    this.roleId,
    this.name,
    this.phone,
    this.address,
    this.birthDate,
    this.gender,
    this.email,
    this.username,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.employeeId,
    this.patientId,
    this.accessCode,
  });

  User copyWith({
    int? id,
    int? roleId,
    String? name,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
    String? email,
    String? username,
    dynamic emailVerifiedAt,
    String? createdAt,
    String? updatedAt,
    int? employeeId,
    int? patientId,
    int? accessCode,
  }) =>
      User(
        id: id ?? this.id,
        roleId: roleId ?? this.roleId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender,
        email: email ?? this.email,
        username: username ?? this.username,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        employeeId: employeeId ?? this.employeeId,
        patientId: patientId ?? this.patientId,
        accessCode: accessCode ?? this.accessCode,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        roleId: json["role_id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        birthDate: json["birth_date"],
        gender: json["gender"],
        email: json["email"],
        username: json["username"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        employeeId: json["employee_id"],
        patientId: json["patient_id"],
        accessCode: json["access_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "role_id": roleId,
        "name": name,
        "phone": phone,
        "address": address,
        "birth_date": birthDate,
        "gender": gender,
        "email": email,
        "username": username,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "employee_id": employeeId,
        "patient_id": patientId,
        "access_code": accessCode,
      };
}
