import 'package:doctor_mobile/core/constants/asset_const.dart';
import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/modules/welcome/controllers/welcome_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = WelcomeController.to;

    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        decoration: const BoxDecoration(
          gradient: ColorConst.gradient2,
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Selamat Datang di\nDoctor Mobile',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w600,
                  color: ColorConst.primary500,
                ),
              ),
              SizedBox(
                height: 48.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.login();
                },
                child: Container(
                  width: 0.5.sw,
                  height: 48,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: ColorConst.primary500,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: () {
                  controller.register();
                },
                child: Container(
                  width: 0.5.sw,
                  height: 48,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: ColorConst.primary500,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100.h,
              ),
              SizedBox(
                width: 1.sw,
                child: Image.asset(
                  AssetConst.drawDoctorIllustration,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
