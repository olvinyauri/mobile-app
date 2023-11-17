import 'package:dio/dio.dart';
import 'package:doctor_mobile/core/constants/api_const.dart';
import 'package:doctor_mobile/core/helpers/dio_error_helper.dart';
import 'package:doctor_mobile/core/services/global_repository_service.dart';
import 'package:doctor_mobile/core/services/network_service.dart';
import 'package:doctor_mobile/modules/register/models/response/register_user_response.dart';

class RegisterRepository extends GlobalRepositoryService {
  Future<RegisterUserResponse> registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String birthDate,
    required String gender,
    required String username,
    required int roleId,
    String? pin,
    String? weight,
    String? height,
    String? qualification,
  }) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,
        "address": address,
        "birth_date": birthDate,
        "gender": gender,
        "username": username,
        "password": password,
        "role_id": roleId,
        if (qualification != null && qualification.isNotEmpty)
          "qualification": qualification,
        if (weight != null && weight.isNotEmpty) "weight": weight,
        if (height != null && height.isNotEmpty) "height": height,
        if (pin != null && pin.isNotEmpty) "access_code": pin,
      });

      Response res = await ApiServices.call().post(
        ApiConst.register,
        data: data,
      );
      return RegisterUserResponse.fromJson(res.data);
    } on DioException catch (dioError) {
      if (dioError.response == null || dioError.response?.data == null) {
        return RegisterUserResponse(
          statusCode: dioError.response?.statusCode ?? 400,
          message: DioErrorHelper.fromDioError(dioError),
        );
      } else {
        try {
          return RegisterUserResponse.fromJson(dioError.response?.data);
        } catch (e) {
          return RegisterUserResponse(
            statusCode: dioError.response?.statusCode ?? 400,
            message: DioErrorHelper.fromDioError(dioError),
          );
        }
      }
    } catch (err) {
      print(err);
      return RegisterUserResponse(
        message: 'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }
}
