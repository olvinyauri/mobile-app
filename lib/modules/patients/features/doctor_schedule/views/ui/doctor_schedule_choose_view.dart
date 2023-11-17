import 'package:doctor_mobile/core/extensions/string_extensions.dart';
import 'package:doctor_mobile/core/helpers/background_color_helper.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/patients/features/doctor_schedule/controllers/doctor_schedule_choose_controller.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DoctorScheduleChooseView extends StatelessWidget {
  const DoctorScheduleChooseView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DoctorScheduleChooseController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Dokter'),
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        scrollController: controller.scrollController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () => controller.onRefresh(),
        onLoading: () async {
          controller.getAllDoctorChallenge(
            isLoadMore: true,
          );
        },
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Obx(
            () => controller.getAllDoctorState.value.when(
              success: (data) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.toDetailDoctor(
                        data.data?[index] ?? ItemDoctor(),
                      );
                    },
                    child: _DoctorCard(
                      data: data.data?[index],
                    ),
                  );
                },
                itemCount: data.data?.length ?? 0,
              ),
              empty: (message) => SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: GeneralEmptyErrorWidget(
                    descText: message,
                  ),
                ),
              ),
              loading: () => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: CustomShimmerWidget().list(
                  length: 10,
                ),
              ),
              error: (message) => SizedBox(
                height: 0.5.sh,
                child: Center(
                  child: GeneralEmptyErrorWidget(
                    descText: message,
                  ),
                ),
              ),
              idle: () => const SizedBox(),
            ),
          ),
        ),
      ),
    );
  }
}

class _DoctorCard extends StatelessWidget {
  const _DoctorCard({
    this.data,
  });

  final ItemDoctor? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
        top: 16,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color:
                  BackgroundColorHelper.stringToPastelColor(data?.name ?? ''),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(
                (data?.name ?? '').toAbbreviation(),
                style: Get.textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.name ?? '',
                  style: Get.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data?.qualification ?? '',
                  style: Get.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
