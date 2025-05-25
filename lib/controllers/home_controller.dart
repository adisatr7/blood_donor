import 'package:get/get.dart';

import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/core/app_routes.dart';

class HomeController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;
  final AppointmentService _appointmentService = AppointmentService.instance;

  final Rxn<User> currentUser = Rxn<User>();
  final RxList<Appointment> appointments = <Appointment>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await fetchCurrentUser();
    await fetchAppointments();
  }

  Future<void> fetchCurrentUser() async {
    currentUser.value = await _profileService.getProfile();
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
