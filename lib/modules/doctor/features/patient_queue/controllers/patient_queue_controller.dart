import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/models/responses/get_all_reservations_response.dart';
import 'package:doctor_mobile/modules/doctor/features/patient_queue/repositories/patient_queue_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

abstract class PatientQueueController extends GetxController {
  Rx<UIStateModel<MetaAllReservations>> allReservationsState =
      const UIStateModel<MetaAllReservations>.idle().obs;

  final PatientQueueRepository repository = PatientQueueRepository();

  late RefreshController refreshController;
  late ScrollController scrollController;

  @override
  void onInit() {
    super.onInit();
    getAllReservationsChallenge();
  }

  void onRefresh({String? value}) async {
    await getAllReservationsChallenge();
    refreshController.refreshCompleted(resetFooterState: true);
  }

  Future<void> getAllReservationsChallenge({
    bool isLoadMore = false,
  });
}
