// To parse this JSON data, do
//
//     final detailReservationResponse = detailReservationResponseFromJson(jsonString);

import 'dart:convert';

DetailReservationResponse detailReservationResponseFromJson(String str) =>
    DetailReservationResponse.fromJson(json.decode(str));

String detailReservationResponseToJson(DetailReservationResponse data) =>
    json.encode(data.toJson());

class DetailReservationResponse {
  int? statusCode;
  DetailReservation? data;
  String? message;

  DetailReservationResponse({
    this.statusCode,
    this.data,
    this.message,
  });

  DetailReservationResponse copyWith({
    int? statusCode,
    DetailReservation? data,
    String? message,
  }) =>
      DetailReservationResponse(
        statusCode: statusCode ?? this.statusCode,
        data: data ?? this.data,
        message: message ?? this.message,
      );

  factory DetailReservationResponse.fromJson(Map<String, dynamic> json) =>
      DetailReservationResponse(
        statusCode: json["status_code"],
        data: json["data"] == null
            ? null
            : DetailReservation.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "data": data?.toJson(),
        "message": message,
      };
}

class DetailReservation {
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
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  int? placeId;
  int? employeeId;
  String? scheduleDate;
  String? scheduleTime;
  String? scheduleTimeEnd;
  int? qty;
  String? doctorName;
  String? qualification;
  String? placeName;
  int? aheadReservation;
  int? currentActiveReservation;

  DetailReservation({
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
    this.placeId,
    this.employeeId,
    this.scheduleDate,
    this.scheduleTime,
    this.scheduleTimeEnd,
    this.qty,
    this.doctorName,
    this.qualification,
    this.placeName,
    this.aheadReservation,
    this.currentActiveReservation,
  });

  DetailReservation copyWith({
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
    String? deletedAt,
    String? createdAt,
    String? updatedAt,
    int? placeId,
    int? employeeId,
    String? scheduleDate,
    String? scheduleTime,
    String? scheduleTimeEnd,
    int? qty,
    String? doctorName,
    String? qualification,
    String? placeName,
    int? aheadReservation,
    int? currentActiveReservation,
  }) =>
      DetailReservation(
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
        placeId: placeId ?? this.placeId,
        employeeId: employeeId ?? this.employeeId,
        scheduleDate: scheduleDate ?? this.scheduleDate,
        scheduleTime: scheduleTime ?? this.scheduleTime,
        scheduleTimeEnd: scheduleTimeEnd ?? this.scheduleTimeEnd,
        qty: qty ?? this.qty,
        doctorName: doctorName ?? this.doctorName,
        qualification: qualification ?? this.qualification,
        placeName: placeName ?? this.placeName,
        aheadReservation: aheadReservation ?? this.aheadReservation,
        currentActiveReservation:
            currentActiveReservation ?? this.currentActiveReservation,
      );

  factory DetailReservation.fromJson(Map<String, dynamic> json) =>
      DetailReservation(
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
        placeId: json["place_id"],
        employeeId: json["employee_id"],
        scheduleDate: json["schedule_date"],
        scheduleTime: json["schedule_time"],
        scheduleTimeEnd: json["schedule_time_end"],
        qty: json["qty"],
        doctorName: json["doctor_name"],
        qualification: json["qualification"],
        placeName: json["place_name"],
        aheadReservation: json["ahead_reservation"],
        currentActiveReservation: json["current_active_reservation"],
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
        "place_id": placeId,
        "employee_id": employeeId,
        "schedule_date": scheduleDate,
        "schedule_time": scheduleTime,
        "schedule_time_end": scheduleTimeEnd,
        "qty": qty,
        "doctor_name": doctorName,
        "qualification": qualification,
        "place_name": placeName,
        "ahead_reservation": aheadReservation,
        "current_active_reservation": currentActiveReservation,
      };
}
