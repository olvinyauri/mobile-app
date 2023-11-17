import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_today_reservations_total_response.dart';

class DoctorDashboardRepository extends GlobalRepositoryService {
  Future<GetTodayReservationsTotalResponse> getTodayTotalReservations() async {
    try {
      Response res = await ApiServices.call().get(
        ApiConst.reservationTodayTotal,
      );

      return GetTodayReservationsTotalResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetTodayReservationsTotalResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetTodayReservationsTotalResponse.fromJson(
              dioError.response?.data);
        } catch (e) {
          return GetTodayReservationsTotalResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetTodayReservationsTotalResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<GetDoctorScheduleResponse> getDoctorSchedule({
    int? doctorId,
  }) async {
    try {
      var query = {
        'employee_id': doctorId,
      };
      Response res = await ApiServices.call().get(
        ApiConst.doctorSchedule,
        queryParameters: query,
      );

      return GetDoctorScheduleResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetDoctorScheduleResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetDoctorScheduleResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetDoctorScheduleResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetDoctorScheduleResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
