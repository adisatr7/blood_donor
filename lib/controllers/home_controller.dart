import 'package:get/get.dart';

import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/core/app_routes.dart';

class HomeController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final RxList<Appointment> appointments = <Appointment>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await fetchAppointments();
  }

  Future<void> fetchAppointments() async {
    appointments.value = await _appointmentService.getAppointments();
  }

  void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  void goToMap() {
    Get.toNamed(AppRoutes.map);
  }
}
