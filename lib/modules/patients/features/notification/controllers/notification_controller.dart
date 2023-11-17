import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/patients/features/notification/models/responses/getl_all_notification_response.dart';
import 'package:doctor_mobile/modules/patients/features/notification/repositories/notification_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class NotificationController extends GetxController {
  static NotificationController get to => Get.find();

  Rx<UIStateModel<MetaAllNotifications>> allNotifState =
      const UIStateModel<MetaAllNotifications>.idle().obs;

  NotificationRepository repository = NotificationRepository();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  void onRefresh({String? value}) async {
    await getAnnouncementsChallenge();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getAnnouncementsChallenge({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      allNotifState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getAllNotif(
      page: isLoadMore
          ? allNotifState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 10,
    );

    if (isLoadMore) {
      if (res.statusCode != 200) {
        refreshController.loadFailed();
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        refreshController.loadNoData();
        return;
      }

      var prevData = allNotifState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaAllNotifications();

      allNotifState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.data?.data ?? []),
        currentPage: res.data?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        allNotifState.value = UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        allNotifState.value = const UIStateModel.empty();
        return;
      }

      allNotifState.value = UIStateModel.success(
        data: res.data ?? MetaAllNotifications(),
      );
    }
  }

  Future<void> readNotif({
    required String id,
  }) async {
    var res = await repository.readNotif(
      id: id,
    );

    if (res.statusCode != 200) {
      return;
    }

    await getAnnouncementsChallenge();
  }

  Future<void> showBottomSheetDetailNotif({
    required BuildContext context,
    required String title,
    required String desc,
  }) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 0.2.sw,
                height: 0.2.sw,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.white,
                  size: 0.1.sw,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                title,
                style: Get.textTheme.titleLarge,
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                desc,
                style: Get.textTheme.bodyMedium,
              ),
              const SizedBox(
                height: 16,
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void onInit() async {
    await getAnnouncementsChallenge();
    super.onInit();
  }
}
