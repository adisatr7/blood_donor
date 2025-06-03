import 'package:get/get.dart';

import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/constants/appointment_status.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:intl/intl.dart';

class AppointmentDetailController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final Rxn<Appointment> appointment = Rxn<Appointment>();

  final RxBool isLoading = true.obs;
  final RxBool isPrintButtonShown = true.obs;

  @override
  void onReady() {
    super.onReady();

    _fetchAppointment();
  }

  /// Format waktu donor menjadi format yang mudah dibaca
  String get appointmentDate {
    if (appointment.value == null) {
      return 'Memuat...';
    }

    final DateTime startTime = appointment.value!.location.time.start;
    final DateTime endTime = appointment.value!.location.time.end;

    final String date = DateFormat('dd MMMM yyyy', 'id').format(endTime);
    final String startHour = DateFormat('HH:mm', 'id').format(startTime);
    final String endHour = DateFormat('HH:mm', 'id').format(endTime);

    return '$date | $startHour-$endHour';
  }

  /// Handler untuk dipasangkan ke tombol Cetak PDF
  void handlePrintPdf() {
    // TODO: Implement
  }

  /// Method internal untuk mengambil data sesi kunjungan dari server
  void _fetchAppointment() async {
    try {
      // Ambil ID sesi kunjungan dari data yang dipilih
      final appointmentId = Get.arguments as int;

      // Ambil sesi kunjungan dari server
      appointment.value = await _appointmentService.getById(appointmentId);

      if (appointment.value!.status != AppointmentStatus.missed) {
        // Jika status kunjungan bukan 'missed', tampilkan tombol print
        isPrintButtonShown.value = true;
      } else {
        // Jika status kunjungan 'missed', sembunyikan tombol print
        isPrintButtonShown.value = false;
      }
    } catch (e) {
      // Tangani error jika gagal mengambil data
      Get.snackbar(
        'Gagal Memuat Data',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        colorText: AppColors.white,
        backgroundColor: AppColors.danger,
        boxShadows: [AppStyles.cardShadow],
      );
    } finally {
      // Hentikan animasi loading
      isLoading.value = false;
    }
  }
}
