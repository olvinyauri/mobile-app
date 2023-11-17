import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/views/ui/doctor_dashboard_view.dart';
import 'package:doctor_mobile/modules/patients/features/home/views/ui/patients_home_view.dart';
import 'package:doctor_mobile/modules/profile/views/ui/profile_view.dart';
import 'package:doctor_mobile/modules/settings/views/ui/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.to;

    return Scaffold(
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: (index) {
              controller.currentIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Icon(
                    Icons.home_outlined,
                    color: controller.currentIndex.value == 0
                        ? ColorConst.primary900
                        : Colors.grey,
                  ),
                ),
                label: 'Beranda',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Icon(
                    Icons.account_circle_outlined,
                    color: controller.currentIndex.value == 1
                        ? ColorConst.primary900
                        : Colors.grey,
                  ),
                ),
                label: 'Profil',
              ),
              BottomNavigationBarItem(
                icon: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: Icon(
                    Icons.settings_outlined,
                    color: controller.currentIndex.value == 2
                        ? ColorConst.primary900
                        : Colors.grey,
                  ),
                ),
                label: 'Pengaturan',
              ),
            ],
          ),
        ),
        body: Obx(
          () => ConditionalSwitch.single(
            context: context,
            valueBuilder: (context) => controller.currentIndex.value,
            caseBuilders: {
              0: (context) => controller.isDoctor.value
                  ? DoctorHomeView()
                  : const PatientsHomeView(),
              1: (context) => const ProfileView(),
              2: (context) => const SettingsView()
            },
            fallbackBuilder: (context) => const PatientsHomeView(),
          ),
        ));
  }
}
