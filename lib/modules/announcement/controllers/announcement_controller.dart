import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/announcement/models/responses/get_all_announcements_response.dart';
import 'package:doctor_mobile/modules/announcement/repositories/announcement_repository.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class AnnouncementController extends GetxController {
  static AnnouncementController get to => Get.find();

  Rx<UIStateModel<MetaGetAnnouncements>> getAnnouncemetsState =
      const UIStateModel<MetaGetAnnouncements>.idle().obs;

  AnnouncementRepository repository = AnnouncementRepository();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  User? user;

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
      getAnnouncemetsState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getAnnouncements(
      page: isLoadMore
          ? getAnnouncemetsState.value.whenOrNull(
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
      if ((res.meta?.data ?? []).isEmpty) {
        refreshController.loadNoData();
        return;
      }

      var prevData = getAnnouncemetsState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaGetAnnouncements();

      getAnnouncemetsState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.meta?.data ?? []),
        currentPage: res.meta?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        getAnnouncemetsState.value =
            UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.meta?.data ?? []).isEmpty) {
        getAnnouncemetsState.value = const UIStateModel.empty();
        return;
      }

      getAnnouncemetsState.value = UIStateModel.success(
        data: res.meta ?? MetaGetAnnouncements(),
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await _setUser();
    getAnnouncementsChallenge();
  }

  Future<void> _setUser() async {
    user = await repository.getCurrentUser();
    update(['fab']);
  }
}
