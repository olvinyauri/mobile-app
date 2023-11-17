import 'dart:convert';

GetCurrentUserResponse getCurrentUserResponseFromJson(String str) =>
    GetCurrentUserResponse.fromJson(json.decode(str));

String getCurrentUserResponseToJson(GetCurrentUserResponse data) =>
    json.encode(data.toJson());

class GetCurrentUserResponse {
  int? statusCode;
  String? message;
  Data? data;

  GetCurrentUserResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  GetCurrentUserResponse copyWith({
    int? statusCode,
    String? message,
    Data? data,
  }) =>
      GetCurrentUserResponse(
        statusCode: statusCode ?? this.statusCode,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetCurrentUserResponse.fromJson(Map<String, dynamic> json) =>
      GetCurrentUserResponse(
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
  int? id;
  int? roleId;
  String? name;
  String? phone;
  String? address;
  String? birthDate;
  String? gender;
  String? email;
  String? username;
  dynamic emailVerifiedAt;
  dynamic createdAt;
  dynamic updatedAt;
  EmployeeData? employeeData;
  PatientData? patientData;

  Data({
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
    this.employeeData,
    this.patientData,
  });

  Data copyWith({
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
    dynamic createdAt,
    dynamic updatedAt,
    EmployeeData? employeeData,
    PatientData? patientData,
  }) =>
      Data(
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
        employeeData: employeeData ?? this.employeeData,
        patientData: patientData ?? this.patientData,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
        employeeData: json["employee_data"] == null
            ? null
            : EmployeeData.fromJson(json["employee_data"]),
        patientData: json["patient_data"] == null
            ? null
            : PatientData.fromJson(json["patient_data"]),
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
        "employee_data": employeeData?.toJson(),
        "patient_data": patientData?.toJson(),
      };
}

class EmployeeData {
  int? id;
  int? userId;
  String? qualification;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  EmployeeData({
    this.id,
    this.userId,
    this.qualification,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  EmployeeData copyWith({
    int? id,
    int? userId,
    String? qualification,
    dynamic deletedAt,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      EmployeeData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        qualification: qualification ?? this.qualification,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory EmployeeData.fromJson(Map<String, dynamic> json) => EmployeeData(
        id: json["id"],
        userId: json["user_id"],
        qualification: json["qualification"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "qualification": qualification,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class PatientData {
  int? id;
  int? userId;
  int? height;
  int? weight;
  dynamic accessCode;
  dynamic deletedAt;
  dynamic createdAt;
  dynamic updatedAt;

  PatientData({
    this.id,
    this.userId,
    this.height,
    this.weight,
    this.accessCode,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  PatientData copyWith({
    int? id,
    int? userId,
    int? height,
    int? weight,
    dynamic accessCode,
    dynamic deletedAt,
    dynamic createdAt,
    dynamic updatedAt,
  }) =>
      PatientData(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        accessCode: accessCode ?? this.accessCode,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PatientData.fromJson(Map<String, dynamic> json) => PatientData(
        id: json["id"],
        userId: json["user_id"],
        height: json["height"],
        weight: json["weight"],
        accessCode: json["access_code"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "height": height,
        "weight": weight,
        "access_code": accessCode,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
