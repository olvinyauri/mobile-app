import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/models/responses/get_all_patient_response.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/repositories/patient_list_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PatientListController extends GetxController {
  static PatientListController get to => Get.find();

  TextEditingController searchController = TextEditingController();

  Rx<UIStateModel<MetaAllPatient>> getPatientState =
      const UIStateModel<MetaAllPatient>.idle().obs;

  PatientListRepository repository = PatientListRepository();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  void onRefresh({String? value}) async {
    await getPatientChallenge(
      search: value,
    );
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getPatientChallenge({
    bool isLoadMore = false,
    String? search,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      getPatientState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getPatientResponse(
      page: isLoadMore
          ? getPatientState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 10,
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

      var prevData = getPatientState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaAllPatient();

      getPatientState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.data?.data ?? []),
        currentPage: res.data?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        getPatientState.value = UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        getPatientState.value = const UIStateModel.empty();
        return;
      }

      getPatientState.value = UIStateModel.success(
        data: res.data ?? MetaAllPatient(),
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    getPatientChallenge();
  }
}
