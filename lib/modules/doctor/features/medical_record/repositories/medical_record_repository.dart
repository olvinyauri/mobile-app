import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/models/response/get_all_icds_response.dart';

class MedicalRecordRepository extends GlobalRepositoryService {
  Future<GetAllIcdsResponse> getAllIcds({
    int? page,
    int? limit,
    String? search,
  }) async {
    try {
      var query = {
        'page': page,
        'limit': limit,
        'search': search,
      };

      Response res = await ApiServices.call().get(
        ApiConst.medicalRecordIcds,
        queryParameters: query,
      );
      return GetAllIcdsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetAllIcdsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetAllIcdsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetAllIcdsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetAllIcdsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DefaultResponseHelper> createMedicalRecord({
    required int reservationId,
    required String icdCode,
    required String action,
    required String complaint,
    required String physicalExam,
    required String diagnosis,
    required String recommendation,
    required String recipe,
    required String desc,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'reservation_id': reservationId,
        'icd_code': icdCode,
        'action': action,
        'complaint': complaint,
        'physical_exam': physicalExam,
        'diagnosis': diagnosis,
        'recommendation': recommendation,
        'recipe': recipe,
        'desc': desc,
      });

      Response res = await ApiServices.call().post(
        ApiConst.medicalRecordAdd,
        data: formData,
      );
      return DefaultResponseHelper.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return DefaultResponseHelper(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return DefaultResponseHelper.fromJson(dioError.response?.data);
        } catch (e) {
          return DefaultResponseHelper(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return DefaultResponseHelper(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
