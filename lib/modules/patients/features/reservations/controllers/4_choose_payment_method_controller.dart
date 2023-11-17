import 'dart:io';

import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/helpers/ask_permission_helper.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/core/widget/drawer_content_choose_file_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/enum/payment_type_enum.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_doctor_places_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/repositories/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChoosePaymentMethodController extends GetxController {
  static ChoosePaymentMethodController get to => Get.find();

  ReservationRepository repository = ReservationRepository();

  ItemDoctor? doctor;
  ItemDoctorPlaces? doctorPlace;
  ItemDoctorSchedule? doctorSchedule;
  String? time;
  User? user;

  Rx<PaymentTypeEnum> paymentType = PaymentTypeEnum.transfer.obs;

  TextEditingController paymentMethodTextController =
      TextEditingController(text: "TRANSFER");
  TextEditingController paymentProofTextController = TextEditingController();
  TextEditingController ktpTextController = TextEditingController();
  TextEditingController bpjsTextController = TextEditingController();
  TextEditingController referringLetterTextController = TextEditingController();

  File? paymentProofFile;
  File? ktpFile;
  File? bpjsFile;
  File? referringLetterFile;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      doctor = args['doctor'];
      doctorPlace = args['place'];
      doctorSchedule = args['schedule'];
      time = args['time'];
      user = args['patient'];
    }
  }

  void bookDoctor() {
    if (paymentType.value == PaymentTypeEnum.transfer) {
      if (paymentProofFile == null) {
        Get.snackbar(
          'Peringatan',
          'Bukti pembayaran tidak boleh kosong',
          backgroundColor: ColorConst.complementary500,
          colorText: Colors.white,
        );
        return;
      }
    } else {
      if (ktpFile == null) {
        Get.snackbar(
          'Peringatan',
          'KTP tidak boleh kosong',
          backgroundColor: ColorConst.complementary500,
          colorText: Colors.white,
        );
        return;
      }
      if (bpjsFile == null) {
        Get.snackbar(
          'Peringatan',
          'Kartu BPJS tidak boleh kosong',
          backgroundColor: ColorConst.complementary500,
          colorText: Colors.white,
        );
        return;
      }
      if (referringLetterFile == null) {
        Get.snackbar(
          'Peringatan',
          'Surat rujukan tidak boleh kosong',
          backgroundColor: ColorConst.complementary500,
          colorText: Colors.white,
        );
        return;
      }
    }

    DialogService.showDialogChoice(
      title: 'Konfirmasi Reservasi',
      description: 'Apakah anda yakin ingin membuat reservasi?',
      textPositiveButton: 'Ya',
      textNegativeButton: 'Tidak',
      onTapPositiveButton: () {
        Get.back();
        bookDoctorChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> bookDoctorChallenge() async {
    DialogService.showLoading();

    var res = await repository.bookDoctor(
      scheduleId: doctorSchedule?.id ?? 0,
      patientId: user?.patientId ?? 0,
      isBpjs: paymentType.value == PaymentTypeEnum.bpjs ? 1 : 0,
      imagePaymentProof: paymentProofFile,
      imageKtp: ktpFile,
      imageBpjsCard: bpjsFile,
      imageReferralLetter: referringLetterFile,
    );

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: 'Gagal Untuk Membuat Reservasi',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Membuat Reservasi',
        description: res.message ?? '',
        buttonOnTap: () {
          Get.offNamedUntil(
            PatientsRoutesConst.detailReservation,
            arguments: {
              'reservationId': res.data?.id,
            },
            (route) => route.settings.name == AppRoutes.dashboard,
          );
        },
      );
    }
  }

  Future<File?> checkGalleryPermission() async {
    return await AskPermissionHelper.storage(
      onGranted: () {
        return getImage();
      },
    );
  }

  Future<File?> getImage() async {
    var res = await showModalBottomSheet<File>(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 160.h,
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
                  Expanded(
                    child: Text(
                      'Pilih File',
                      style: TextStyle(
                        fontSize: 14.sp,
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
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 16.h,
              ),
              child: const DrawerContentChooseFileWidget(
                sourceFiles: [
                  SourceFileEnum.gallery,
                  SourceFileEnum.camera,
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return res;
  }

  void selectImage(String type) {
    switch (type) {
      case 'paymentProof':
        if (paymentProofFile != null) {
          dialogShowSelectedImage(type);
        } else {
          selectImagePicker(type);
        }
        break;
      case 'ktp':
        if (ktpFile != null) {
          dialogShowSelectedImage(type);
        } else {
          selectImagePicker(type);
        }
        break;
      case 'bpjs':
        if (bpjsFile != null) {
          dialogShowSelectedImage(type);
        } else {
          selectImagePicker(type);
        }
        break;
      case 'suratRujukan':
        if (referringLetterFile != null) {
          dialogShowSelectedImage(type);
        } else {
          selectImagePicker(type);
        }
        break;
      default:
    }
  }

  Future<void> selectImagePicker(String type) async {
    final pickedFile = await checkGalleryPermission();
    if (pickedFile != null) {
      switch (type) {
        case 'paymentProof':
          paymentProofFile = File(pickedFile.path);
          paymentProofTextController.text = paymentProofFile!.path;
          break;
        case 'ktp':
          ktpFile = File(pickedFile.path);
          ktpTextController.text = ktpFile!.path;
          break;
        case 'bpjs':
          bpjsFile = File(pickedFile.path);
          bpjsTextController.text = bpjsFile!.path;
          break;
        case 'suratRujukan':
          referringLetterFile = File(pickedFile.path);
          referringLetterTextController.text = referringLetterFile!.path;
          break;
        default:
      }
    }
  }

  void dialogShowSelectedImage(String type) {
    switch (type) {
      case 'paymentProof':
        if (paymentProofFile != null) {
          Get.defaultDialog(
            title: 'Bukti Pembayaran',
            content: Image.file(paymentProofFile!),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
            cancel: TextButton(
              onPressed: () {
                paymentProofFile = null;
                paymentProofTextController.text = '';
                Get.back();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
          );
        }
        break;
      case 'ktp':
        if (ktpFile != null) {
          Get.defaultDialog(
            title: 'KTP',
            content: Image.file(ktpFile!),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
            cancel: TextButton(
              onPressed: () {
                ktpFile = null;
                ktpTextController.text = '';
                Get.back();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
          );
        }
        break;
      case 'bpjs':
        if (bpjsFile != null) {
          Get.defaultDialog(
            title: 'Kartu BPJS',
            content: Image.file(bpjsFile!),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
            cancel: TextButton(
              onPressed: () {
                bpjsFile = null;
                bpjsTextController.text = '';
                Get.back();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
          );
        }
        break;
      case 'suratRujukan':
        if (referringLetterFile != null) {
          Get.defaultDialog(
            title: 'Surat Rujukan',
            content: Image.file(referringLetterFile!),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
            cancel: TextButton(
              onPressed: () {
                referringLetterFile = null;
                referringLetterTextController.text = '';
                Get.back();
              },
              child: const Text(
                'Hapus',
                style: TextStyle(
                  color: ColorConst.primary500,
                ),
              ),
            ),
          );
        }
        break;
      default:
    }
  }

  void toPaymentMethod() {
    Get.toNamed(
      PatientsRoutesConst.paymentMethod,
      arguments: {
        'doctor': doctor,
        'place': doctorPlace,
        'schedule': doctorSchedule,
        'time': time,
        'patient': user,
      },
    );
  }

  void showPaymentChooser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _showPaymentChooser(context);
      },
    );
  }

  Container _showPaymentChooser(BuildContext context) {
    return Container(
      height: 0.5.sh,
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
                    'Pilih Metode Pembayaran',
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
          Expanded(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    paymentType.value = PaymentTypeEnum.transfer;
                    paymentMethodTextController.text =
                        paymentType.value.name.toUpperCase();
                    Get.back();
                  },
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.payment,
                          color: ColorConst.primary500,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        const Expanded(
                          child: Text(
                            'Transfer',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.primary500,
                            ),
                          ),
                        ),
                        Obx(
                          () => paymentType.value == PaymentTypeEnum.transfer
                              ? const Icon(
                                  Icons.check,
                                  color: ColorConst.primary500,
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    paymentType.value = PaymentTypeEnum.bpjs;
                    paymentMethodTextController.text =
                        paymentType.value.name.toUpperCase();
                    Get.back();
                  },
                  child: Container(
                    height: 48.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.payment,
                          color: ColorConst.primary500,
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        const Expanded(
                          child: Text(
                            'BPJS',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: ColorConst.primary500,
                            ),
                          ),
                        ),
                        Obx(
                          () => paymentType.value == PaymentTypeEnum.bpjs
                              ? const Icon(
                                  Icons.check,
                                  color: ColorConst.primary500,
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
