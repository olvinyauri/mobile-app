import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';

class PrivateInformationRepository extends GlobalRepositoryService {
  Future<DefaultResponseHelper> updateAccessCode({
    int? accessCode,
    int? oldAccessCode,
    int? birthDate,
    bool isForgetPin = false,
  }) async {
    try {
      User? user = await getCurrentUser();

      if (isForgetPin) {
        DateTime? birth = DateTime.tryParse(user.birthDate ?? '');

        // birth to yyyymmdd
        String? birthString = (birth?.year.toString() ?? "") +
            (birth?.month.toString().padLeft(2, '0') ?? "") +
            (birth?.day.toString().padLeft(2, '0') ?? "");

        int? birthInt = int.tryParse(birthString);

        if (birthInt != birthDate) {
          return DefaultResponseHelper(
            message: 'Tanggal lahir tidak sesuai.',
          );
        }
      } else {
        if (oldAccessCode != user.accessCode) {
          if (user.accessCode != null) {
            return DefaultResponseHelper(
              message: 'Kode akses tidak sesuai.',
            );
          }
        }
      }

      FormData formData = FormData.fromMap({
        'id': user.patientId,
        'access_code': accessCode,
      });

      Response res = await ApiServices.call().post(
        ApiConst.patientUpdateAccessCode,
        data: formData,
      );

      var data = DefaultResponseHelper.fromJson(res.data);

      if (data.statusCode == 200) {
        User updateUser = user.copyWith(
          accessCode: accessCode,
        );

        HiveService().putData(
          HiveConst.userBox,
          HiveConst.userKey,
          updateUser,
        );
      }

      return data;
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

  Future<DefaultResponseHelper> updatePassword({
    String? oldPassword,
    String? newPassword,
  }) async {
    try {
      FormData formData = FormData.fromMap({
        'old_password': oldPassword,
        'new_password': newPassword,
      });

      Response res = await ApiServices.call().post(
        ApiConst.updatePassword,
        data: formData,
      );

      var data = DefaultResponseHelper.fromJson(res.data);

      return data;
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
