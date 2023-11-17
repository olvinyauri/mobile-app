import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/controllers/medical_report_controller.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/views/components/medical_report_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MedicalReportView extends StatelessWidget {
  const MedicalReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MedicalReportController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekam Medis'),
        elevation: 0,
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        scrollController: controller.scrollController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () => controller.onRefresh(),
        onLoading: () async {
          controller.getMyMedicalReportChallenge(
            isLoadMore: true,
          );
        },
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Obx(
            () => controller.myMedicalRecordState.value.when(
              success: (data) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        PatientsRoutesConst.detailMedicalReport,
                        arguments: data.data?[index],
                      );
                    },
                    child: MedicalReportCardWidget(
                      data: data.data?[index],
                    ),
                  );
                },
                itemCount: data.data?.length ?? 0,
              ),
              empty: (message) => SizedBox(
                height: 0.5.sh,
                child: Center(
                  // child: GeneralEmptyErrorWidget(
                  //   descText: message,
                  // ),
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
