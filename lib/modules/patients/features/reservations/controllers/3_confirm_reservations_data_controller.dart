import 'package:doctor_mobile/modules/doctor/features/dashboard/models/responses/get_doctor_schedule_response.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_all_doctor_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/models/responses/get_doctor_places_response.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/repositories/reservation_repository.dart';
import 'package:get/get.dart';

class ConfirmReservationsDataController extends GetxController {
  static ConfirmReservationsDataController get to => Get.find();

  ReservationRepository repository = ReservationRepository();

  ItemDoctor? doctor;
  ItemDoctorPlaces? doctorPlace;
  ItemDoctorSchedule? doctorSchedule;
  String? time;
  User? user;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments;
    if (args != null) {
      doctor = args['doctor'];
      doctorPlace = args['place'];
      doctorSchedule = args['schedule'];
      time = args['time'];
      user = args['patient'];
    }
  }

  void toPaymentMethod() {
    Get.toNamed(
      PatientsRoutesConst.paymentMethod,
      arguments: {
        'doctor': doctor,
        'place': doctorPlace,
        'schedule': doctorSchedule,
        'time': time,
        'patient': user,
      },
    );
  }
}
