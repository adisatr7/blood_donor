import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class PdfPrintController extends GetxController {
  final int appointmentId = Get.arguments ?? -1;

  final AppointmentService _appointmentService = AppointmentService.instance;
  final GlobalController global = Get.find<GlobalController>();
  final Rxn<Appointment> appointment = Rxn<Appointment>();

  @override
  void onInit() async {
    super.onInit();

    global.refreshCurrentUser(); // Ambil data user terkini
    _fetchAppointment(); // Ambil data appointment
  }

  /// Method internal untuk mengabil data appointment
  Future<void> _fetchAppointment() async {
    try {
      // Ambil data dari server melalui AppointmentService
      appointment.value = await _appointmentService.getById(appointmentId);
    } on DioException catch (e) {
      // Kembali ke halaman sebelumnya
      Get.back();
      // Tampilkan error
      showAppError('Gagal Memuat Data', e);
    }
  }
}
