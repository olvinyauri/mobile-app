import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/models/response/get_all_icds_response.dart';
import 'package:doctor_mobile/modules/doctor/features/medical_record/repositories/medical_record_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SelectIcdsController extends GetxController {
  static SelectIcdsController get to => Get.find();

  Rx<UIStateModel<MetaAllIcds>> allIcdsState =
      const UIStateModel<MetaAllIcds>.idle().obs;

  final MedicalRecordRepository _repository = MedicalRecordRepository();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();

  void onRefresh({String? value}) async {
    await getAllIcdsChallenge(
      search: value,
    );
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getAllIcdsChallenge({
    bool isLoadMore = false,
    String? search,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      allIcdsState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await _repository.getAllIcds(
      page: isLoadMore
          ? allIcdsState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 20,
      search: search,
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

      var prevData = allIcdsState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaAllIcds();

      allIcdsState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.data?.data ?? []),
        currentPage: res.data?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        allIcdsState.value = UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        allIcdsState.value = const UIStateModel.empty();
        return;
      }

      allIcdsState.value = UIStateModel.success(
        data: res.data ?? MetaAllIcds(),
      );
    }
  }

  void onSelectIcds(ItemIcds? icds) {
    Get.back(result: icds);
  }

  @override
  void onInit() async {
    super.onInit();
    await getAllIcdsChallenge();
  }
}
