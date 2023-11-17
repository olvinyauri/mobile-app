import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/controllers/select_icds_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SelectICDSView extends StatelessWidget {
  const SelectICDSView({super.key});

  @override
  Widget build(BuildContext context) {
    final SelectIcdsController controller = Get.put(
      SelectIcdsController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih ICD'),
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
                hintText: 'Cari ICD',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.searchController.clear();
                    controller.getAllIcdsChallenge();
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
                controller.getAllIcdsChallenge(
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
                controller.getAllIcdsChallenge(
                  isLoadMore: true,
                  search: controller.searchController.text,
                );
              },
              child: SingleChildScrollView(
                controller: controller.scrollController,
                child: Obx(
                  () => controller.allIcdsState.value.when(
                    success: (data) => ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.onSelectIcds(
                              data.data?[index],
                            );
                          },
                          child: ListTile(
                            title: Text(
                              data.data?[index].nameId ?? '',
                            ),
                            subtitle: Text(
                              data.data?[index].code ?? '',
                            ),
                            trailing: const Icon(
                              Icons.add,
                            ),
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
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(
          //         'ICD 10',
          //       ),
          //       subtitle: Text(
          //         'Kode ICD 10',
          //       ),
          //       trailing: const Icon(
          //         Icons.add,
          //       ),
          //     );
          //   },
          //   itemCount: 10,
          // ),
        ],
      ),
    );
  }
}
