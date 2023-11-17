import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/models/response/get_my_medical_record_response.dart';

class MedicalReportRepository extends GlobalRepositoryService {
  Future<GetMyMedicalRecordResponse> getMyMedicalRecord({
    int? page,
    int? limit,
    int? patientId,
  }) async {
    try {
      User? user = await getCurrentUser();

      var query = {
        'page': page,
        'limit': limit,
        'patient_id': patientId ?? user.patientId,
      };

      Response res = await ApiServices.call().get(
        ApiConst.medicalRecordMy,
        queryParameters: query,
      );

      return GetMyMedicalRecordResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetMyMedicalRecordResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetMyMedicalRecordResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetMyMedicalRecordResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetMyMedicalRecordResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
