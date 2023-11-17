import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/helpers/logger_helper.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static HiveService? _instance;
  factory HiveService() => _instance ??= HiveService._();
  HiveService._();

  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(UserAdapter());

    await openBox(HiveConst.tokenBox);
    await openBox(HiveConst.accessBox);
    await openBox(HiveConst.userBox);
  }

  Future<void> openBox(String boxName) async {
    await Hive.openBox(boxName);
  }

  Future<void> putData(String boxName, String key, dynamic value) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        await Hive.openBox(boxName);
      }
      await Hive.box(boxName).put(key, value);
    } catch (e) {
      LoggerHelper.printMessage('Error put data to hive: $e');
    }
  }

  dynamic getData(String boxName, String key) {
    return Hive.box(boxName).get(key);
  }

  Future<void> deleteData(String boxName, String key) async {
    await Hive.box(boxName).delete(key);
  }

  Future<void> clear() async {
    Hive.isBoxOpen(HiveConst.tokenBox)
        ? Hive.box(HiveConst.tokenBox).clear()
        : null;
    Hive.isBoxOpen(HiveConst.accessBox)
        ? Hive.box(HiveConst.accessBox).clear()
        : null;
    Hive.isBoxOpen(HiveConst.userBox)
        ? Hive.box(HiveConst.userBox).clear()
        : null;
  }
}
