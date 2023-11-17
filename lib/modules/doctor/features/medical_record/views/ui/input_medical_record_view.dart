import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_input_text_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/controllers/medical_record_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class InputMedicalRecordView extends StatelessWidget {
  const InputMedicalRecordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      MedicalRecordController(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Rekam Medis'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomInputTextWidget(
                controller: controller.complaintController,
                title: 'Keluhan',
                hintText: 'Masukkan Keluhan',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
              ),
              CustomInputTextWidget(
                controller: controller.handlingController,
                title: 'Pemeriksaan Fisik',
                hintText: 'Masukkan Hasil Pemeriksaan Fisik',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
              ),
              CustomInputTextWidget(
                controller: controller.physicalExaminationController,
                title: 'Diagnosa',
                hintText: 'Masukkan Hasil Diagnosa',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
              ),
              CustomInputTextWidget(
                controller: controller.diagnosisController,
                title: 'Anjuran',
                hintText: 'Masukkan Anjuran',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
              ),
              CustomInputTextWidget(
                controller: controller.recommendationController,
                title: 'Resep',
                hintText: 'Masukkan Resep',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
              ),
              CustomInputTextWidget(
                controller: controller.icdController,
                title: 'Tindakan',
                hintText: 'Masukkan Tindakan',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                suffixIcon: Icons.search,
                readOnly: true,
                onTap: () {
                  controller.selectIcdCode();
                },
              ),
              CustomInputTextWidget(
                controller: controller.recipeController,
                title: 'Keterangan (Opsional)',
                hintText: 'Masukkan Keterangan',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                maxLines: 8,
              ),
              // CustomInputTextWidget(
              //   controller: controller.noteController,
              //   title: 'Deskripsi',
              //   hintText: 'Deskripsi',
              //   margin: EdgeInsets.only(
              //     bottom: 16.w,
              //   ),
              //   maxLines: 8,
              // ),
              SizedBox(
                height: 16.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.createMedicalRecord();
                },
                child: Container(
                  width: double.infinity,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: ColorConst.primary900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                    child: Text(
                      'Tambah Rekam Medis',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
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
