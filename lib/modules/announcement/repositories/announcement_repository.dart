import 'dart:io';

import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/announcement/models/responses/get_all_announcements_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';

class AnnouncementRepository extends GlobalRepositoryService {
  Future<GetAllAnnouncementsResponse> getAnnouncements({
    int? page,
    int? limit,
  }) async {
    try {
      var query = {
        'page': page,
        'limit': limit,
      };
      Response res = await ApiServices.call().get(
        ApiConst.announcementAll,
        queryParameters: query,
      );
      return GetAllAnnouncementsResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetAllAnnouncementsResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetAllAnnouncementsResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetAllAnnouncementsResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetAllAnnouncementsResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DefaultResponseHelper> createAnnouncement({
    String? title,
    String? description,
    File? image,
  }) async {
    User user = await getCurrentUser();

    FormData formData = FormData.fromMap({
      'title': title,
      'content': description,
      'image': image != null
          ? await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            )
          : null,
      'employee_id': user.employeeId,
    });

    try {
      Response res = await ApiServices.call().post(
        ApiConst.announcementCreate,
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

  Future<DefaultResponseHelper> updateAnnouncement({
    String? title,
    String? description,
    File? image,
    required int id,
  }) async {
    FormData formData = FormData.fromMap({
      'title': title,
      'content': description,
      'image': image != null
          ? await MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            )
          : '',
      'id': id,
    });

    try {
      Response res = await ApiServices.call().post(
        ApiConst.announcementUpdate,
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

  Future<DefaultResponseHelper> deleteAnnouncement({
    required int id,
  }) async {
    FormData formData = FormData.fromMap({
      'id': id,
    });

    try {
      Response res = await ApiServices.call().post(
        ApiConst.announcementDelete,
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
