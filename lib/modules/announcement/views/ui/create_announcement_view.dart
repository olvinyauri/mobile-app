import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_input_text_widget.dart';
import 'package:doctor_mobile/modules/announcement/controllers/create_announcement_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateAnnouncementView extends StatelessWidget {
  const CreateAnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreateAnnouncementController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.isEdit.value
              ? const Text('Edit Pengumuman')
              : const Text('Buat Pengumuman'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomInputTextWidget(
                title: 'Judul',
                hintText: 'Judul',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.title,
                controller: controller.titleController,
              ),
              CustomInputTextWidget(
                controller: controller.descriptionController,
                title: 'Isi Pengumuman',
                hintText: 'Isi Pengumuman',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
                prefixIcon: Icons.description,
              ),
              CustomInputTextWidget(
                title: 'Gambar',
                hintText: 'Gambar',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.image_outlined,
                controller: controller.imageController,
                readOnly: true,
                onTap: () {
                  controller.selectImage();
                },
              ),
              SizedBox(
                height: 16.w,
              ),
              GestureDetector(
                onTap: () {
                  controller.createAnnouncement();
                },
                child: Container(
                  width: 1.sw,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ColorConst.primary500,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  child: Center(
                    child: Obx(
                      () => controller.isEdit.value
                          ? const Text(
                              'Ubah',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const Text(
                              'Simpan',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
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
