import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/modules/settings/views/ui/privacy_policies_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 8.h,
            ),
            ListTile(
              onTap: () {
                Get.to(
                  () => const PrivacyPoliciesView(),
                );
              },
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                "Kebijakan Privasi",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                Get.toNamed(AppRoutes.privateInformation);
              },
              contentPadding: EdgeInsets.zero,
              dense: true,
              title: Text(
                "Informasi Pribadi",
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
              ),
            ),
            const Divider(
              thickness: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
