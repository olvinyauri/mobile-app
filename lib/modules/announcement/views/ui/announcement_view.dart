import 'package:doctor_mobile/core/constants/color_const.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/announcement/controllers/announcement_controller.dart';
import 'package:doctor_mobile/modules/announcement/views/components/announcement_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      AnnouncementController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pengumuman',
        ),
        elevation: 0,
      ),
      floatingActionButton: GetBuilder<AnnouncementController>(
        id: 'fab',
        builder: (state) {
          return Conditional.single(
            context: context,
            conditionBuilder: (_) => state.user?.employeeId != null,
            fallbackBuilder: (_) {
              return const SizedBox();
            },
            widgetBuilder: (_) => FloatingActionButton(
              onPressed: () async {
                Get.toNamed(
                  AppRoutes.createAnnouncement,
                );
              },
              backgroundColor: ColorConst.primary900,
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
      body: SmartRefresher(
        controller: controller.refreshController,
        scrollController: controller.scrollController,
        enablePullUp: true,
        enablePullDown: true,
        onRefresh: () => controller.onRefresh(),
        onLoading: () async {
          controller.getAnnouncementsChallenge(
            isLoadMore: true,
          );
        },
        child: SingleChildScrollView(
          controller: controller.scrollController,
          child: Obx(
            () => controller.getAnnouncemetsState.value.when(
              success: (data) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        AppRoutes.detailAnnouncement,
                        arguments: data.data?[index],
                      );
                    },
                    child: AnnouncementCardWidget(
                      item: data.data?[index],
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
