import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/modules/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 32.h,
                ),
                const Text(
                  'Daftar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: ColorConst.primary500),
                ),
                SizedBox(
                  height: 72.h,
                ),
                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: controller.nameController,
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
                      TextFormField(
                        controller: controller.dateOfBirthController,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: ColorConst.primary900,
                        ),
                        readOnly: true,
                        onTap: () => controller.datePicker(context),
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.genderController,
                        readOnly: true,
                        onTap: () => controller.selectGender(context),
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
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.phoneController,
                        keyboardType: TextInputType.phone,
                        maxLength: 13,
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
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
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
                          hintText: 'Surel',
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
                        controller: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
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
                          hintText: 'Kata Sandi',
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
                            Icons.lock_outline,
                            color: ColorConst.primary500,
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.addressController,
                        keyboardType: TextInputType.streetAddress,
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
                            Icons.home_outlined,
                            color: ColorConst.primary500,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.heightController,
                        keyboardType: TextInputType.number,
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
                          hintText: 'Tinggi Badan',
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
                            Icons.person,
                            color: ColorConst.primary500,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: controller.weightController,
                        keyboardType: TextInputType.number,
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
                          hintText: 'Berat Badan',
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
                            Icons.person,
                            color: ColorConst.primary500,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      TextFormField(
                        controller: controller.accessCodeController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        obscureText: true,
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
                          hintText: 'PIN',
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
                            Icons.lock_outline,
                            color: ColorConst.primary500,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.registerChallenge();
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
                              'Daftar',
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
                          Get.back();
                        },
                        child: RichText(
                          text: const TextSpan(
                            text: 'Sudah punya akun? ',
                            style: TextStyle(
                                color: ColorConst.primary500,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                            children: [
                              TextSpan(
                                text: 'Masuk',
                                style: TextStyle(
                                    color: ColorConst.primary500,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
