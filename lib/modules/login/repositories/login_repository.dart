import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/helpers/logger_helper.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';

class LoginRepository {
  Future<LoginResponse> login(
    String email,
    String password,
  ) async {
    try {
      Response res = await ApiServices.call().post(
        ApiConst.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      var response = LoginResponse.fromJson(res.data);

      HiveService().putData(
        HiveConst.tokenBox,
        HiveConst.tokenKey,
        response.accessToken,
      );

      HiveService().putData(
        HiveConst.accessBox,
        HiveConst.accessKey,
        response.user?.roleId,
      );

      HiveService().putData(
        HiveConst.userBox,
        HiveConst.userKey,
        response.user,
      );

      return response;
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return LoginResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return LoginResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return LoginResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      LoggerHelper.printMessage('Error: $err', tag: 'LoginRepository');
      return LoginResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
