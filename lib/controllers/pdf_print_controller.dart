import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class PdfPrintController extends GetxController {
  final int appointmentId = Get.arguments ?? -1;

  final AppointmentService _appointmentService = AppointmentService.instance;
  final GlobalController global = Get.find<GlobalController>();
  final Rxn<Appointment> appointment = Rxn<Appointment>();
  final RxInt totalSuccess = 0.obs;
  final RxString lastDonorDate = ''.obs;

  @override
  void onInit() async {
    super.onInit();

    global.refreshCurrentUser(); // Ambil data user terkini
    _fetchAppointment(); // Ambil data appointment
    _getCountAndLastDonorDate(); // Hitung jumlah sesi berhasil dan ambil tanggal terakhir donor
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

  /// Method internal untuk menghitung jumlah sesi berhasil dan mengambil tanggal terakhir donor
  Future<void> _getCountAndLastDonorDate() async {
    try {
      // Hitung jumlah sesi berhasil dari appointment
      final List<Appointment> appointments = await _appointmentService.getAll();
      totalSuccess.value = appointments.where((a) => a.status == 'ATTENDED').length;

      // Ambil tanggal donor terakhir (jika ada)
      if (appointments.isEmpty) {
        lastDonorDate.value = 'Belum ada donor';
        return;
      }

      final lastAttended = appointments
          .where((a) => a.status == 'ATTENDED')
          .map((a) => a.location.time.start)
          .reduce((a, b) => a.isAfter(b) ? a : b);

      lastDonorDate.value = DateFormat('d MMMM yyyy', 'id_ID').format(lastAttended);
    } on DioException catch (e) {
      // Tampilkan error jika gagal menghitung
      showAppError('Gagal Mengambil Riwayat Donor', e);
    }
  }
}
