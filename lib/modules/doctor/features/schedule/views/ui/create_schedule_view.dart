import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/widget/custom_input_text_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/schedule/controllers/create_schedule_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CreateScheduleView extends StatelessWidget {
  const CreateScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CreateScheduleController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => controller.isEdit.value
              ? const Text('Edit Jadwal')
              : const Text('Tambah Jadwal'),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomInputTextWidget(
                controller: controller.placeNameTextController,
                readOnly: true,
                onTap: () {
                  controller.selectPlaces(context);
                },
                title: 'Nama Tempat',
                hintText: 'Nama Tempat',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                suffixIcon: Icons.arrow_drop_down,
                prefixIcon: Icons.location_on_outlined,
              ),
              CustomInputTextWidget(
                controller: controller.dateTextController,
                readOnly: true,
                onTap: () {
                  controller.selectDate(context);
                },
                title: 'Tanggal',
                hintText: 'Tanggal',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.calendar_today_outlined,
              ),
              CustomInputTextWidget(
                controller: controller.startTimeTextController,
                readOnly: true,
                onTap: () {
                  controller.selectTimw(context, true);
                },
                title: 'Jam Mulai',
                hintText: 'Jam Mulai',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.access_time_outlined,
              ),
              CustomInputTextWidget(
                controller: controller.endTimeTextController,
                readOnly: true,
                onTap: () {
                  controller.selectTimw(context, false);
                },
                title: 'Jam Selesai',
                hintText: 'Jam Selesai',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.access_time_outlined,
              ),
              CustomInputTextWidget(
                controller: controller.quotaTextController,
                keyboardType: TextInputType.number,
                title: 'Kuota',
                hintText: 'Kuota',
                margin: EdgeInsets.only(
                  bottom: 16.w,
                ),
                prefixIcon: Icons.people_alt_outlined,
              ),
              SizedBox(
                height: 16.w,
              ),
              GestureDetector(
                onTap: () {
                  controller.createSchedule();
                },
                child: Container(
                  width: 1.sw,
                  height: 48,
                  decoration: BoxDecoration(
                    color: ColorConst.primary900,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: const Center(
                    child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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
