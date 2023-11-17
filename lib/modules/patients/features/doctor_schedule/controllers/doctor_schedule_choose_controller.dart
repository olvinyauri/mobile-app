import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/repositories/reservation_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class DoctorScheduleChooseController extends GetxController {
  static DoctorScheduleChooseController get to => Get.find();

  ReservationRepository repository = ReservationRepository();

  Rx<UIStateModel<MetaGetAllDoctor>> getAllDoctorState =
      const UIStateModel<MetaGetAllDoctor>.idle().obs;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  void onRefresh({String? value}) async {
    await getAllDoctorChallenge();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getAllDoctorChallenge({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      getAllDoctorState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getAllDoctor(
      page: isLoadMore
          ? getAllDoctorState.value.whenOrNull(
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

      var prevData = getAllDoctorState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaGetAllDoctor();

      getAllDoctorState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.meta?.data ?? []),
        currentPage: res.meta?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        getAllDoctorState.value =
            UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.meta?.data ?? []).isEmpty) {
        getAllDoctorState.value = const UIStateModel.empty();
        return;
      }

      getAllDoctorState.value = UIStateModel.success(
        data: res.meta ?? MetaGetAllDoctor(),
      );
    }
  }

  void toDetailDoctor(ItemDoctor? data) {
    Get.toNamed(
      PatientsRoutesConst.doctorScheduleDetail,
      arguments: data,
    );
  }

  @override
  void onInit() {
    super.onInit();
    getAllDoctorChallenge();
  }
}
