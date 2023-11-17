// To parse this JSON data, do
//
//     final bookDoctorResponse = bookDoctorResponseFromJson(jsonString);

import 'dart:convert';

BookDoctorResponse bookDoctorResponseFromJson(String str) =>
    BookDoctorResponse.fromJson(json.decode(str));

String bookDoctorResponseToJson(BookDoctorResponse data) =>
    json.encode(data.toJson());

class BookDoctorResponse {
  int? statusCode;
  DataBookDoctor? data;
  String? message;

  BookDoctorResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  BookDoctorResponse copyWith({
    int? statusCode,
    DataBookDoctor? data,
    String? message,
  }) =>
      BookDoctorResponse(
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory BookDoctorResponse.fromJson(Map<String, dynamic> json) =>
      BookDoctorResponse(
        statusCode: json["status_code"],
        data:
            json["data"] == null ? null : DataBookDoctor.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
        "message": message,
      };
}

class DataBookDoctor {
  int? id;
  int? patientId;
  int? scheduleId;
  String? reservationCode;
  int? bpjs;
  String? buktiPembayaran;
  String? ktp;
  String? suratRujukan;
  String? bpjsCard;
  int? nomorUrut;
  int? approve;
  int? status;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  DataBookDoctor({
    this.id,
    this.patientId,
    this.scheduleId,
    this.reservationCode,
    this.bpjs,
    this.buktiPembayaran,
    this.ktp,
    this.suratRujukan,
    this.bpjsCard,
    this.nomorUrut,
    this.approve,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  DataBookDoctor copyWith({
    int? id,
    int? patientId,
    int? scheduleId,
    String? reservationCode,
    int? bpjs,
    String? buktiPembayaran,
    String? ktp,
    String? suratRujukan,
    String? bpjsCard,
    int? nomorUrut,
    int? approve,
    int? status,
    dynamic deletedAt,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataBookDoctor(
        id: id ?? this.id,
        patientId: patientId ?? this.patientId,
        scheduleId: scheduleId ?? this.scheduleId,
        reservationCode: reservationCode ?? this.reservationCode,
        bpjs: bpjs ?? this.bpjs,
        buktiPembayaran: buktiPembayaran ?? this.buktiPembayaran,
        ktp: ktp ?? this.ktp,
        suratRujukan: suratRujukan ?? this.suratRujukan,
        bpjsCard: bpjsCard ?? this.bpjsCard,
        nomorUrut: nomorUrut ?? this.nomorUrut,
        approve: approve ?? this.approve,
        status: status ?? this.status,
        deletedAt: deletedAt ?? this.deletedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataBookDoctor.fromJson(Map<String, dynamic> json) => DataBookDoctor(
        id: json["id"],
        patientId: json["patient_id"],
        scheduleId: json["schedule_id"],
        reservationCode: json["reservation_code"],
        bpjs: json["bpjs"],
        buktiPembayaran: json["bukti_pembayaran"],
        ktp: json["ktp"],
        suratRujukan: json["surat_rujukan"],
        bpjsCard: json["bpjs_card"],
        nomorUrut: json["nomor_urut"],
        approve: json["approve"],
        status: json["status"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patient_id": patientId,
        "schedule_id": scheduleId,
        "reservation_code": reservationCode,
        "bpjs": bpjs,
        "bukti_pembayaran": buktiPembayaran,
        "ktp": ktp,
        "surat_rujukan": suratRujukan,
        "bpjs_card": bpjsCard,
        "nomor_urut": nomorUrut,
        "approve": approve,
        "status": status,
        "deleted_at": deletedAt,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
