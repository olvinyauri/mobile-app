import 'package:doctor_mobile/core/constants/hive_const.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/hive_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _setInitialPage();
  }

  void _setInitialPage() {
    String routes = _setRoute();

    Future.delayed(const Duration(seconds: 3), () {
      Get.offNamed(
        routes,
      );
    });
  }

  String _setRoute() {
    String routes = AppRoutes.welcome;

    HiveService().getData(HiveConst.tokenBox, HiveConst.tokenKey) != null
        ? routes = AppRoutes.dashboard
        : routes = AppRoutes.welcome;
    return routes;
  }
}
