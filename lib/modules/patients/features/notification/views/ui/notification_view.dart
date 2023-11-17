import 'package:doctor_mobile/core/widget/custom_shimmer_widget.dart';
import 'package:doctor_mobile/core/widget/general_empty_error_widget.dart';
import 'package:doctor_mobile/modules/patients/features/notification/controllers/notification_controller.dart';
import 'package:doctor_mobile/modules/patients/features/notification/models/data_notification_model.dart';
import 'package:doctor_mobile/modules/patients/features/notification/views/components/notification_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      NotificationController(),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
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
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          child: Obx(
            () => controller.allNotifState.value.when(
              success: (data) => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await controller.showBottomSheetDetailNotif(
                        context: context,
                        title: DataNotificationModel.fromJson(
                              data.data?[index].data ?? '',
                            ).title ??
                            '',
                        desc: DataNotificationModel.fromJson(
                              data.data?[index].data ?? '',
                            ).message ??
                            '',
                      );
                      if (data.data?[index].readAt == null) {
                        controller.readNotif(
                          id: data.data?[index].id ?? '',
                        );
                      }
                    },
                    child: NotificationCardWidget(
                      item: data.data?[index],
                      isRead: data.data?[index].readAt != null,
                    ),
                  );
                },
                itemCount: data.data?.length ?? 0,
              ),
              empty: (message) => SizedBox(
                height: 0.5.sh,
                // child: Center(
                //   child: GeneralEmptyErrorWidget(
                //     descText: message,
                //   ),
                // ),
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
