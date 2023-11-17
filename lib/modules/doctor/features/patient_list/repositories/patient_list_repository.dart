import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/models/responses/get_all_patient_response.dart';

class PatientListRepository extends GlobalRepositoryService {
  Future<GetAllPatientsResponse> getPatientResponse({
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
        ApiConst.patientAll,
        queryParameters: query,
      );
      return GetAllPatientsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetAllPatientsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetAllPatientsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetAllPatientsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetAllPatientsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
