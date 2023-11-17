import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/profile/models/responses/get_current_user_response.dart';

class ProfileRepository extends GlobalRepositoryService {
  Future<GetCurrentUserResponse> getUserProfile() async {
    try {
      Response res = await ApiServices.call().get(
        ApiConst.currentLoginUser,
      );

      var data = GetCurrentUserResponse.fromJson(res.data);

      User updateUser = User.fromJson(data.data?.toJson() ?? {}).copyWith(
        employeeId: data.data?.employeeData?.id,
        patientId: data.data?.patientData?.id,
        accessCode: data.data?.patientData?.accessCode,
      );

      HiveService().putData(
        HiveConst.userBox,
        HiveConst.userKey,
        updateUser,
      );

      return data;
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return GetCurrentUserResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return GetCurrentUserResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return GetCurrentUserResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      return GetCurrentUserResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  Future<DefaultResponseHelper> logout() async {
    try {
      Response res = await ApiServices.call().post(
        ApiConst.logout,
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

  Future<DefaultResponseHelper> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? address,
    String? birthDate,
    String? gender,
  }) async {
    try {
      Map<String, dynamic> data = {};
      if (name != null && name.isNotEmpty) data['name'] = name;
      if (email != null && email.isNotEmpty) data['email'] = email;
      if (phone != null && phone.isNotEmpty) data['phone'] = phone;
      if (address != null && address.isNotEmpty) data['address'] = address;
      if (birthDate != null && birthDate.isNotEmpty) {
        data['birth_date'] = birthDate;
      }
      if (gender != null && gender.isNotEmpty) data['gender'] = gender;

      FormData formData = FormData.fromMap(data);

      Response res = await ApiServices.call().post(
        ApiConst.updateProfile,
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
