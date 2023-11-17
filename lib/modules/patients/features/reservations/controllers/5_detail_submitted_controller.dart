import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/detail_reservation_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/repositories/reservation_repository.dart';
import 'package:get/get.dart';

class DetailSubmittedController extends GetxController {
  static DetailSubmittedController get to => Get.find();

  ReservationRepository repository = ReservationRepository();

  Rx<UIStateModel<DetailReservationResponse>> detailReservationState =
      const UIStateModel<DetailReservationResponse>.idle().obs;

  int? reservationId;

  DateTime latestUpdate = DateTime.now();

  void getDetailReservation({
    required int reservationId,
  }) async {
    detailReservationState.value =
        const UIStateModel<DetailReservationResponse>.loading();
    var res = await repository.getDetailReservation(
      reservationId: reservationId,
    );
    if (res.statusCode == 200) {
      detailReservationState.value =
          UIStateModel<DetailReservationResponse>.success(
        data: res,
      );
      latestUpdate = DateTime.now();
    } else {
      detailReservationState.value =
          UIStateModel<DetailReservationResponse>.error(
        message: res.message ??
            'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      reservationId = args['reservationId'];
      getDetailReservation(
        reservationId: reservationId!,
      );
    }
  }
}
