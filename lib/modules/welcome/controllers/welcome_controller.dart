import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController{
  static WelcomeController get to => Get.find();

  void login() {
    Get.offNamed(AppRoutes.login);
  }

  void register() {
    Get.offNamed(AppRoutes.register);
  }
}