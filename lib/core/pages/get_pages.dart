import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/modules/announcement/views/ui/announcement_view.dart';
import 'package:doctor_mobile/modules/announcement/views/ui/create_announcement_view.dart';
import 'package:doctor_mobile/modules/announcement/views/ui/detail_announcement_view.dart';
import 'package:doctor_mobile/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:doctor_mobile/modules/dashboard/views/ui/dashboard_view.dart';
import 'package:doctor_mobile/modules/doctor/pages/doctor_pages.dart';
import 'package:doctor_mobile/modules/login/views/ui/login_view.dart';
import 'package:doctor_mobile/modules/patients/pages/patients_pages.dart';
import 'package:doctor_mobile/modules/register/views/ui/register_view.dart';
import 'package:doctor_mobile/modules/settings/views/ui/private_information_view.dart';
import 'package:doctor_mobile/modules/welcome/controllers/welcome_controller.dart';
import 'package:doctor_mobile/modules/welcome/views/ui/welcome_view.dart';
import 'package:doctor_mobile/modules/splash/controllers/splash_controller.dart';
import 'package:doctor_mobile/modules/splash/views/ui/splash_view.dart';
import 'package:get/get.dart';

class GetPages {
  GetPages._();

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: AppRoutes.splash,
        page: () => const SplashView(),
        binding: BindingsBuilder(
          () {
            Get.put(
              SplashController(),
            );
          },
        ),
      ),
      GetPage(
        name: AppRoutes.welcome,
        page: () => const WelcomeView(),
        binding: BindingsBuilder(
          () {
            Get.put(
              WelcomeController(),
            );
          },
        ),
      ),
      GetPage(
        name: AppRoutes.login,
        page: () => const LoginView(),
      ),
      GetPage(
        name: AppRoutes.register,
        page: () => const RegisterView(),
      ),
      GetPage(
        name: AppRoutes.dashboard,
        page: () => const DashboardView(),
        binding: BindingsBuilder(
          () {
            Get.put(
              DashboardController(),
            );
          },
        ),
      ),
      GetPage(
        name: AppRoutes.announcement,
        page: () => const AnnouncementView(),
      ),
      GetPage(
        name: AppRoutes.detailAnnouncement,
        page: () => const DetailAnnouncementView(),
      ),
      GetPage(
        name: AppRoutes.createAnnouncement,
        page: () => const CreateAnnouncementView(),
      ),

      GetPage(
        name: AppRoutes.privateInformation,
        page: () => const PrivateInformationView(),
      ),

      /// ================== Patients ==================
      ...PatientsPages.getPages(),

      /// ================== Doctors ==================
      ...DoctorPages.getPages(),
    ];
  }
}
