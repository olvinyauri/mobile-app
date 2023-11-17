import 'package:doctor_mobile/core/constants/asset_const.dart';
import 'package:doctor_mobile/core/routes/app_routes.dart';
import 'package:doctor_mobile/core/state/ui_state_model/ui_state_model.dart';
import 'package:doctor_mobile/modules/login/models/response/login_response.dart';
import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/home/models/responses/get_my_reservation_reponse.dart';
import 'package:doctor_mobile/modules/patients/features/home/repositories/patient_home_repository.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class PatientsHomeController extends GetxController {
  static PatientsHomeController get to => Get.find();

  PatientHomeRepository repository = PatientHomeRepository();

  Rx<UIStateModel<List<MyReservationItem>>> myReservationState =
      const UIStateModel<List<MyReservationItem>>.idle().obs;

  User? user;

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  List<Map<String, dynamic>> get listMenu => [
        {
          'title': 'Buat Janji Temu',
          'icon': AssetConst.icMakeAppointment,
          'route': PatientsRoutesConst.makeAppointment,
        },
        {
          'title': 'Jadwal Dokter',
          'icon': AssetConst.icDoctorSchedule,
          'route': PatientsRoutesConst.doctorSchedule,
        },
        {
          'title': 'Rekam Medis Pasien',
          'icon': AssetConst.icMedicalReport,
          'route': PatientsRoutesConst.enterPasscode,
        },
        {
          'title': 'Pengumuman',
          'icon': AssetConst.icNotification,
          'route': AppRoutes.announcement,
        },
      ];

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onReady() {
    super.onReady();
    getMyReservation();
  }

  void onRefresh() async {
    Future.wait([
      getUser(),
      getMyReservation(),
    ]);
    refreshController.refreshCompleted();
  }

  Future<void> getUser() async {
    user = await repository.getCurrentUser();
    update(['name']);
  }

  Future<void> getMyReservation({
    int? patientId,
  }) async {
    myReservationState.value =
        const UIStateModel<List<MyReservationItem>>.loading();
    var res = await repository.getMyReservation(
      patientId: patientId,
    );
    if (res.statusCode == 200) {
      if (res.data == null || res.data!.isEmpty) {
        myReservationState.value =
            const UIStateModel<List<MyReservationItem>>.empty(
          message: 'Anda belum membuat reservasi.',
        );
        return;
      }
      myReservationState.value = UIStateModel<List<MyReservationItem>>.success(
        data: res.data ?? [],
      );
    } else {
      myReservationState.value = UIStateModel<List<MyReservationItem>>.error(
        message: res.message ??
            'Terjadi kesalahan saat menerima data, silahkan coba lagi.',
      );
    }
  }

  void onTapMenu(int index) {
    Get.toNamed(
      listMenu[index]['route'],
    );
  }
}
