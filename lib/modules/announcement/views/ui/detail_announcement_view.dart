import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/services/dialog_service.dart';
import 'package:doctor_mobile/modules/announcement/models/responses/get_all_announcements_response.dart';
import 'package:doctor_mobile/modules/announcement/repositories/announcement_repository.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailAnnouncementView extends StatefulWidget {
  const DetailAnnouncementView({super.key});

  @override
  State<DetailAnnouncementView> createState() => _DetailAnnouncementViewState();
}

class _DetailAnnouncementViewState extends State<DetailAnnouncementView> {
  ItemAnnouncement? item;
  User? user;
  AnnouncementRepository repository = AnnouncementRepository();

  bool isMyPost = false;

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    if (args != null) {
      if (args is ItemAnnouncement) {
        item = args;
      }
    }
    setIsMyPost();
  }

  Future<void> setIsMyPost() async {
    user = await repository.getCurrentUser();
    if (user?.employeeId != null) {
      if (item?.employeeId == user?.employeeId) {
        setState(() {
          isMyPost = true;
        });
      }
    }
  }

  void deleteAnnouncement() {
    DialogService.showDialogChoice(
      title: 'Konfirmasi',
      description: 'Apakah anda yakin ingin menghapus pengumuman?',
      textPositiveButton: 'Ya',
      textNegativeButton: 'Tidak',
      onTapPositiveButton: () async {
        Get.back();
        await deleteAnnouncementChallenge();
      },
      onTapNegativeButton: () {
        Get.back();
      },
    );
  }

  Future<void> deleteAnnouncementChallenge() async {
    DialogService.showLoading();
    var res = await repository.deleteAnnouncement(
      id: item!.id!,
    );
    DialogService.closeLoading();
    if (res.statusCode == 200) {
      DialogService.showDialogSuccess(
        title: 'Berhasil Menghapus Pengumuman',
        description: res.message ?? '',
        barrierDismissible: false,
        buttonOnTap: () {
          Get.offNamedUntil(
            AppRoutes.announcement,
            (route) => route.settings.name == AppRoutes.dashboard,
          );
        },
      );
    } else {
      DialogService.showDialogProblem(
        title: 'Gagal Menghapus Pengumuman',
        description: res.message ?? '',
      );
    }
  }

  void showBottomSheetUpdateOrDelete() {
    Get.bottomSheet(
      Container(
        height: 150.h,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilihan',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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
            GestureDetector(
              onTap: () async {
                Get.toNamed(
                  AppRoutes.createAnnouncement,
                  arguments: item,
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.edit,
                      color: ColorConst.primary900,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      'Edit',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorConst.primary900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                deleteAnnouncement();
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                ),
                height: 48.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.delete,
                      color: ColorConst.primary900,
                    ),
                    SizedBox(
                      width: 16.w,
                    ),
                    Text(
                      'Hapus',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: ColorConst.primary900,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pengumuman'),
        actions: [
          Conditional.single(
            context: context,
            conditionBuilder: (BuildContext context) => isMyPost,
            widgetBuilder: (BuildContext context) => IconButton(
              onPressed: () async {
                showBottomSheetUpdateOrDelete();
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
            fallbackBuilder: (BuildContext context) => const SizedBox(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 16.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item?.title ?? "",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: ColorConst.primary900,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(
              height: 16.h,
            ),
            Text(
              (DateTime.tryParse(item?.createdAt ?? "") ?? DateTime.now())
                  .extToFormattedString(
                      outputDateFormat: 'EEEE, dd MMMM yyyy HH:mm'),
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: const Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 12.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              child: Conditional.single(
                context: context,
                conditionBuilder: (BuildContext context) => item?.image != null,
                widgetBuilder: (BuildContext context) => GestureDetector(
                  onTap: () {
                    Get.dialog(
                      Dialog(
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 1.sw,
                              child: InteractiveViewer(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: Image.network(
                                    item?.image ?? "",
                                    width: 1.sw,
                                    height: 1.sh,
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      width: 1.sw,
                                      height: 1.sw,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: ColorConst.analogous100,
                                        borderRadius:
                                            BorderRadius.circular(16.r),
                                      ),
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 64.h,
                              right: 16.w,
                              child: GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Container(
                                  width: 32.w,
                                  height: 32.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.r),
                    child: Image.network(
                      item?.image ?? "",
                      width: 1.sw,
                      height: 1.sw,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 1.sw,
                        height: 1.sw,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConst.analogous100,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                fallbackBuilder: (BuildContext context) => const SizedBox(),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ),
              width: 1.sw,
              child: Text(
                item?.content ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
