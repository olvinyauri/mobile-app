import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/pages/get_pages.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Doctor Mobile',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: ColorConst.primary900,
            ),
            textTheme: GoogleFonts.interTextTheme(
              Theme.of(context).textTheme,
            ),
          ),
          getPages: GetPages.getPages(),
          initialRoute: AppRoutes.splash,
          builder: (context, child) {
            return GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: child,
            );
          },
        );
      },
    );
  }
}
