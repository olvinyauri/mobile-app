import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/string_extensions.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: ColorConst.primary900,
        automaticallyImplyLeading: false,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        onRefresh: () => controller.getUserProfileChallenge(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Obx(
                    () =>
                        controller.userProfileState.value.whenOrNull(
                          success: (data) => Stack(
                            children: [
                              Container(
                                width: 80.w,
                                height: 80.w,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: ColorConst.primary900,
                                  borderRadius: BorderRadius.circular(40.r),
                                ),
                                child: Center(
                                  child: Text(
                                    data.name.toAbbreviation(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  width: 24.w,
                                  height: 24.w,
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.edit_outlined,
                                      size: 16,
                                      color: ColorConst.primary900,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ) ??
                        CustomShimmerWidget.buildShimmerWidget(
                          width: 80.w,
                          height: 80.w,
                          radius: 40.r,
                        ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Obx(
                    () =>
                        controller.userProfileState.value.whenOrNull(
                          success: (data) => Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.name,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  data.phone,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ) ??
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomShimmerWidget.buildShimmerWidget(
                              width: 100.w,
                              height: 16.h,
                              radius: 8.r,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            CustomShimmerWidget.buildShimmerWidget(
                              width: 100.w,
                              height: 16.h,
                              radius: 8.r,
                            ),
                          ],
                        ),
                  ),
                ],
              ),
              SizedBox(
                height: 32.h,
              ),
              Obx(
                () =>
                    controller.userProfileState.value.whenOrNull(
                      loading: () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 8.r,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 8.r,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 8.r,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 8.r,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 8.r,
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 50.r,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CustomShimmerWidget.buildShimmerWidget(
                            width: 1.sw,
                            height: 40.h,
                            radius: 50.r,
                          ),
                        ],
                      ),
                    ) ??
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller: controller.nameTextController,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorConst.primary900,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              hintText: 'Nama',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.account_circle_outlined,
                                color: ColorConst.primary500,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GetBuilder<ProfileController>(
                            id: 'birthDateText',
                            builder: (state) {
                              return TextFormField(
                                controller: controller.birthDateTextController,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConst.primary900,
                                ),
                                readOnly: true,
                                onTap: () {
                                  controller.selectDate(context);
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  hintText: 'Tanggal Lahir',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorConst.primary500,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorConst.primary500,
                                    ),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: ColorConst.primary500,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: ColorConst.primary500,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          GetBuilder<ProfileController>(
                            id: 'genderText',
                            builder: (state) {
                              return TextFormField(
                                controller: controller.genderTextController,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConst.primary900,
                                ),
                                readOnly: true,
                                onTap: () {
                                  controller.selectGender(context);
                                },
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 16,
                                  ),
                                  hintText: 'Jenis Kelamin',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorConst.primary500,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    borderSide: BorderSide(
                                      color: ColorConst.primary500,
                                    ),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.arrow_drop_down_rounded,
                                    color: ColorConst.primary500,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.wc_outlined,
                                    color: ColorConst.primary500,
                                  ),
                                ),
                                textInputAction: TextInputAction.next,
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.phoneTextController,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorConst.primary900,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              hintText: 'No HP.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.phone_outlined,
                                color: ColorConst.primary500,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.emailTextController,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorConst.primary900,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: ColorConst.primary500,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            controller: controller.addressTextController,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: ColorConst.primary900,
                            ),
                            decoration: const InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              hintText: 'Alamat',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                borderSide: BorderSide(
                                  color: ColorConst.primary500,
                                ),
                              ),
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: ColorConst.primary500,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                          ),
                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // TextFormField(
                          //   controller: controller.passwordTextController,
                          //   style: TextStyle(
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w400,
                          //     color: ColorConst.primary900,
                          //   ),
                          //   decoration: const InputDecoration(
                          //     contentPadding: EdgeInsets.symmetric(
                          //       horizontal: 16,
                          //       vertical: 16,
                          //     ),
                          //     hintText: 'Password',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(8),
                          //       ),
                          //       borderSide: BorderSide(
                          //         color: ColorConst.primary500,
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(8),
                          //       ),
                          //       borderSide: BorderSide(
                          //         color: ColorConst.primary500,
                          //       ),
                          //     ),
                          //     prefixIcon: Icon(
                          //       Icons.lock_outline,
                          //       color: ColorConst.primary500,
                          //     ),
                          //   ),
                          //   textInputAction: TextInputAction.done,
                          //   obscureText: true,
                          // ),

                          // const SizedBox(
                          //   height: 16,
                          // ),
                          // // pin
                          // TextFormField(
                          //   controller: controller.pinTextController,
                          //   style: TextStyle(
                          //     fontSize: 12.sp,
                          //     fontWeight: FontWeight.w400,
                          //     color: ColorConst.primary900,
                          //   ),
                          //   maxLength: 6,
                          //   decoration: const InputDecoration(
                          //     contentPadding: EdgeInsets.symmetric(
                          //       horizontal: 16,
                          //       vertical: 16,
                          //     ),
                          //     hintText: 'Pin',
                          //     border: OutlineInputBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(8),
                          //       ),
                          //       borderSide: BorderSide(
                          //         color: ColorConst.primary500,
                          //       ),
                          //     ),
                          //     enabledBorder: OutlineInputBorder(
                          //       borderRadius: BorderRadius.all(
                          //         Radius.circular(8),
                          //       ),
                          //       borderSide: BorderSide(
                          //         color: ColorConst.primary500,
                          //       ),
                          //     ),
                          //     prefixIcon: Icon(
                          //       Icons.lock_outline,
                          //       color: ColorConst.primary500,
                          //     ),
                          //   ),
                          //   textInputAction: TextInputAction.done,
                          //   obscureText: true,
                          // ),
                          const SizedBox(
                            height: 48,
                          ),

                          GestureDetector(
                            onTap: () {
                              controller.updateProfile();
                            },
                            child: Container(
                              width: 1.sw,
                              height: 48,
                              decoration: BoxDecoration(
                                color: ColorConst.primary500,
                                borderRadius: BorderRadius.circular(24.r),
                              ),
                              child: const Center(
                                child: Text(
                                  'Edit',
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
                              controller.logout();
                            },
                            child: Container(
                              width: 1.sw,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24.r),
                                border: Border.all(
                                  color: Colors.redAccent.shade200,
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
