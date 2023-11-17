import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/modules/register/repositories/register_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  static RegisterController get to => Get.find();

  RxInt role = 3.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController accessCodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final RegisterRepository _registerRepository = RegisterRepository();

  DateTime? selectedBirthDate;

  bool checkIfAllFieldIsFilled() {
    if (role.value == 2) {
      return nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          dateOfBirthController.text.isNotEmpty &&
          genderController.text.isNotEmpty &&
          qualificationController.text.isNotEmpty &&
          addressController.text.isNotEmpty;
    } else if (role.value == 3) {
      return nameController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          dateOfBirthController.text.isNotEmpty &&
          genderController.text.isNotEmpty &&
          heightController.text.isNotEmpty &&
          weightController.text.isNotEmpty &&
          accessCodeController.text.isNotEmpty &&
          addressController.text.isNotEmpty;
    } else {
      return false;
    }
  }

  Future<void> registerChallenge() async {
    if (!checkIfAllFieldIsFilled()) {
      DialogService.showDialogProblem(
        title: 'Perhatian',
        description: 'Silahkan isi semua field terlebih dahulu',
      );
      return;
    }

    DialogService.showLoading();

    var res = await _registerRepository.registerUser(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      address: addressController.text,
      birthDate: selectedBirthDate.toString(),
      gender: genderController.text,
      username: emailController.text.split('@').first,
      roleId: role.value,
      qualification: qualificationController.text,
      weight: weightController.text,
      height: heightController.text,
      pin: accessCodeController.text,
    );

    DialogService.closeLoading();

    if ((res.statusCode ?? 0) >= 200 && (res.statusCode ?? 0) < 300) {
      // clear
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      phoneController.clear();
      dateOfBirthController.clear();
      genderController.clear();
      qualificationController.clear();
      heightController.clear();
      weightController.clear();
      accessCodeController.clear();
      addressController.clear();

      DialogService.showDialogSuccess(
        title: 'Berhasil',
        description: 'Berhasil mendaftar, silahkan login',
      );
    } else {
      DialogService.showDialogProblem(
        title: 'Gagal',
        description: res.message ?? 'Terjadi kesalahan saat mendaftar',
      );
    }
  }

  void datePicker(BuildContext context) async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorConst.primary500,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null) {
      dateOfBirthController.text = date.toHumanReadableDateString();
      selectedBirthDate = date;
      update(['dateOfBirthText']);
    }
  }

  void selectGender(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 180.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 48.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  gradient: ColorConst.gradient3,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.r),
                    topRight: Radius.circular(16.r),
                  ),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Jenis Kelamin',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text('Pria'),
                onTap: () {
                  genderController.text = 'Pria';
                  update(['genderText']);
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Wanita'),
                onTap: () {
                  genderController.text = 'Wanita';
                  update(['genderText']);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}
