import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_list/models/responses/get_all_patient_response.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/models/response/get_my_medical_record_response.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/repositories/medical_report_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class MedicalReportController extends GetxController {
  static MedicalReportController get to => Get.find();

  Rx<UIStateModel<MetaMyMedicalRecord>> myMedicalRecordState =
      const UIStateModel<MetaMyMedicalRecord>.idle().obs;

  MedicalReportRepository repository = MedicalReportRepository();

  RefreshController refreshController =
      RefreshController(initialRefresh: false);
  ScrollController scrollController = ScrollController();

  ItemAllPatient? patient;

  void onRefresh({String? value}) async {
    await getMyMedicalReportChallenge();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getMyMedicalReportChallenge({
    bool isLoadMore = false,
  }) async {
    if (isLoadMore) {
      refreshController.requestLoading();
    } else {
      myMedicalRecordState.value = const UIStateModel.loading();
      refreshController.resetNoData();
    }

    var res = await repository.getMyMedicalRecord(
      page: isLoadMore
          ? myMedicalRecordState.value.whenOrNull(
                success: (data) => (data.currentPage ?? 0) + 1,
              ) ??
              1
          : 1,
      limit: 10,
      patientId: patient?.id,
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

      var prevData = myMedicalRecordState.value.whenOrNull(
            success: (data) => data,
          ) ??
          MetaMyMedicalRecord();

      myMedicalRecordState.value = UIStateModel.success(
          data: prevData.copyWith(
        data: (prevData.data ?? []) + (res.data?.data ?? []),
        currentPage: res.data?.currentPage ?? 0,
      ));

      refreshController.loadComplete();
    } else {
      if (res.statusCode != 200) {
        myMedicalRecordState.value =
            UIStateModel.error(message: res.message ?? '');
        return;
      }
      if ((res.data?.data ?? []).isEmpty) {
        myMedicalRecordState.value = const UIStateModel.empty();
        return;
      }

      myMedicalRecordState.value = UIStateModel.success(
        data: res.data ?? MetaMyMedicalRecord(),
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      if (args is ItemAllPatient) {
        patient = args;
      }
    }
    await getMyMedicalReportChallenge();
  }
}
