import 'dart:io';

import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/helpers/ask_permission_helper.dart';
import 'package:doctor_mobile/core/helpers/default_response_helper.dart';
import 'package:doctor_mobile/core/helpers/file_helper.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/core/widget/drawer_content_choose_file_widget.dart';
import 'package:doctor_mobile/modules/announcement/models/responses/get_all_announcements_response.dart';
import 'package:doctor_mobile/modules/announcement/repositories/announcement_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAnnouncementController extends GetxController {
  static CreateAnnouncementController get to => Get.find();

  final AnnouncementRepository _repository = AnnouncementRepository();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  File? image;
  File? toUpload;

  RxBool isEdit = false.obs;
  RxBool isLoading = false.obs;

  ItemAnnouncement? announcement;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      if (args is ItemAnnouncement) {
        announcement = args;
        _setInitialData();
      }
    }
  }

  void _setInitialData() async {
    titleController.text = announcement!.title ?? '';
    descriptionController.text = announcement!.content ?? '';

    if (announcement!.image != null) {
      var foto = await FileHelper.urlToFile(announcement!.image!);
      image = foto;
      imageController.text = image!.path.split('/').last;
    }

    isEdit.value = true;
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

  void dialogShowSelectedImage() {
    Get.defaultDialog(
      title: 'Gambar',
      content: Image.file(
        image!,
        fit: BoxFit.cover,
      ),
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
          image = null;
          toUpload = null;
          imageController.clear();
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

  void selectImage() {
    if (image != null) {
      dialogShowSelectedImage();
    } else {
      selectImagePicker();
    }
  }

  Future<void> selectImagePicker() async {
    final pickedFile = await checkGalleryPermission();
    if (pickedFile != null) {
      image = File(pickedFile.path);
      toUpload = image;
      imageController.text = image!.path.split('/').last;
    }
  }

  Future<void> createAnnouncementChallenge() async {
    DialogService.showLoading();

    late DefaultResponseHelper res;

    if (isEdit.value) {
      res = await _repository.updateAnnouncement(
        title: titleController.text,
        description: descriptionController.text,
        image: toUpload,
        id: announcement!.id!,
      );
    } else {
      res = await _repository.createAnnouncement(
        title: titleController.text,
        description: descriptionController.text,
        image: toUpload,
      );
    }

    DialogService.closeLoading();

    if (res.statusCode != 200) {
      DialogService.showDialogProblem(
        title: isEdit.value
            ? 'Gagal Mengubah Pengumuman'
            : 'Gagal Membuat Pengumuman',
        description: res.message ?? '',
      );

      return;
    }

    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: isEdit.value
            ? 'Berhasil Mengubah Pengumuman'
            : 'Berhasil Membuat Pengumuman',
        description: res.message ?? '',
        barrierDismissible: false,
        buttonOnTap: () {
          isEdit.value = false;
          Get.offNamedUntil(
            AppRoutes.announcement,
            (route) => route.settings.name == AppRoutes.dashboard,
          );
        },
      );
    }
  }

  void createAnnouncement() {
    if (titleController.text.isEmpty) {
      DialogService.showDialogProblem(
        title: isEdit.value
            ? 'Gagal Mengubah Pengumuman'
            : 'Gagal Membuat Pengumuman',
        description: 'Judul tidak boleh kosong',
      );

      return;
    }

    if (descriptionController.text.isEmpty) {
      DialogService.showDialogProblem(
        title: isEdit.value
            ? 'Gagal Mengubah Pengumuman'
            : 'Gagal Membuat Pengumuman',
        description: 'Deskripsi tidak boleh kosong',
      );

      return;
    }

    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: isEdit.value
          ? 'Apakah anda yakin ingin mengubah pengumuman?'
          : 'Apakah anda yakin ingin membuat pengumuman?',
      textPositiveButton: 'Ya',
      textNegativeButton: 'Tidak',
      onTapPositiveButton: () {
        Get.back();
        createAnnouncementChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }
}
