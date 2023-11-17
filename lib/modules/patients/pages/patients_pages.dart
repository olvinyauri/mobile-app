import 'package:doctor_mobile/modules/patients/constants/patients_routes_const.dart';
import 'package:doctor_mobile/modules/patients/features/doctor_schedule/views/ui/doctor_schedule_choose_view.dart';
import 'package:doctor_mobile/modules/patients/features/doctor_schedule/views/ui/doctor_schedule_view.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/views/ui/detail_medical_report_view.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/views/ui/enter_passcode_view.dart';
import 'package:doctor_mobile/modules/patients/features/medical_report/views/ui/medical_report_view.dart';
import 'package:doctor_mobile/modules/patients/features/notification/views/ui/notification_view.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/views/ui/1_select_doctor_view.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/views/ui/2_make_appointment_view.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/views/ui/3_confirm_reservations_data_view.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/views/ui/4_choose_payment_method_view.dart';
import 'package:doctor_mobile/modules/patients/features/reservations/views/ui/5_detail_submitted_view.dart';
import 'package:get/get.dart';

class PatientsPages {
  PatientsPages._();

  static List<GetPage> getPages() {
    return [
      GetPage(
        name: PatientsRoutesConst.makeAppointment,
        page: () => const SelectDoctorView(),
      ),
      GetPage(
        name: PatientsRoutesConst.makeAppointmentCreate,
        page: () => const MakeAppointmentView(),
      ),
      GetPage(
        name: PatientsRoutesConst.confirmReservationDetail,
        page: () => const ConfirmReservationsDataView(),
      ),
      GetPage(
        name: PatientsRoutesConst.paymentMethod,
        page: () => const ChoosePaymentMethod(),
      ),
      GetPage(
        name: PatientsRoutesConst.detailReservation,
        page: () => const DetailSubmittedView(),
      ),
      GetPage(
        name: PatientsRoutesConst.doctorSchedule,
        page: () => const DoctorScheduleChooseView(),
      ),
      GetPage(
        name: PatientsRoutesConst.doctorScheduleDetail,
        page: () => const DoctorScheduleView(),
      ),
      GetPage(
        name: PatientsRoutesConst.medicalReport,
        page: () => const MedicalReportView(),
      ),
      GetPage(
        name: PatientsRoutesConst.detailMedicalReport,
        page: () => const DetailMedicalReportView(),
      ),
      GetPage(
        name: PatientsRoutesConst.notification,
        page: () => const NotificationView(),
      ),
      GetPage(
        name: PatientsRoutesConst.enterPasscode,
        page: () => const EnterPasscodeView(),
      ),
    ];
  }
}
