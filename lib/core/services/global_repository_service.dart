import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';

class GlobalRepositoryService {
  Future<User> getCurrentUser() async {
    try {
      User user = HiveService().getData(HiveConst.userBox, HiveConst.userKey);
      return user;
    } catch (e) {
      return User();
    }
  }

  Future<String> getCurrentUserName() async {
    try {
      User user = HiveService().getData(HiveConst.userBox, HiveConst.userKey);
      return user.name ?? '';
    } catch (e) {
      return '';
    }
  }
}
