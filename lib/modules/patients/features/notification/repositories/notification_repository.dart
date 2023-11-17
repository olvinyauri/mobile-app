import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/patients/features/notification/models/responses/getl_all_notification_response.dart';

class NotificationRepository extends GlobalRepositoryService {
  Future<GetAllNotificationsResponse> getAllNotif({
    int? page,
    int? limit,
  }) async {
    try {
      var query = {
        'page': page,
        'limit': limit,
      };
      Response res = await ApiServices.call().get(
        ApiConst.notificationAll,
        queryParameters: query,
      );
      return GetAllNotificationsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetAllNotificationsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetAllNotificationsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetAllNotificationsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetAllNotificationsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DefaultResponseHelper> readNotif({
    required String id,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'id': id,
      });

      Response res = await ApiServices.call().post(
        ApiConst.notificationRead,
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
