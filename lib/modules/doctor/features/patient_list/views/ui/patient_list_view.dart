import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/extensions/date_extensions.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/constants/doctor_routes_const.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/controllers/patient_list_controller.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/models/responses/get_all_patient_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PatientListView extends StatelessWidget {
  const PatientListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      PatientListController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pasien'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: TextField(
              controller: controller.searchController,
              decoration: InputDecoration(
                hintText: 'Cari Pasien',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.searchController.clear();
                    controller.getPatientChallenge();
                  },
                  child: const Icon(
                    Icons.clear,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onSubmitted: (value) {
                controller.getPatientChallenge(
                  search: value,
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Expanded(
            child: SmartRefresher(
              controller: controller.refreshController,
              scrollController: controller.scrollController,
              enablePullUp: true,
              enablePullDown: true,
              onRefresh: () => controller.onRefresh(
                value: controller.searchController.text,
              ),
              onLoading: () async {
                controller.getPatientChallenge(
                  isLoadMore: true,
                  search: controller.searchController.text,
                );
              },
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Obx(
                  () => controller.getPatientState.value.when(
                    success: (data) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              DoctorRoutesConst.patientDetail,
                              arguments: data.data?[index],
                            );
                          },
                          child: _PatientListCardWidget(
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
          ),
        ],
      ),
    );
  }
}

class _PatientListCardWidget extends StatelessWidget {
  const _PatientListCardWidget({
    this.data,
  });

  final ItemAllPatient? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: ColorConst.primary100,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: const Icon(
              Icons.person,
              color: ColorConst.primary900,
            ),
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data?.userName ?? '-',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  data?.gender ?? '-',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${(DateTime.tryParse(data?.birthDate ?? '') ?? DateTime.now()).getAge()} Tahun',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
