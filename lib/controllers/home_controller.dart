import 'package:blood_donor/constants/appointment_status.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/models/db/user.dart';

class HomeController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final RxList<Appointment> appointments = <Appointment>[].obs;
  final RxInt totalSuccess = 0.obs;
  final RxInt totalMissed = 0.obs;

  @override
  void onReady() async {
    super.onReady();
    await _fetchAppointments();
  }

  /// Method untuk mengarahkan ke halaman chat
  void goToChat() {
    Get.toNamed(AppRoutes.aiChat);
  }

  /// Method untuk mengarahkan ke halaman pengaturan
  void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  /// Method untuk mengarahkan ke halaman Map
  void goToMap() {
    // Cek terlebih dahulu apakah user sudah mengisi alamat
    if (_isAddressIncomplete) {
      // Jika belum, arahkan ke halaman edit alamat
      Get.toNamed(AppRoutes.editAddress);

      // Tampilkan dialog peringatan
      showAppDialog(
        title: 'Anda Belum Mengisi Alamat',
        message:
            'Harap isi alamat Anda terlebih dahulu sebelum menggunakan fitur peta.',
      );
      return;
    }

    // Jika sudah, arahkan ke halaman Map
    Get.toNamed(AppRoutes.map);
  }

  /// Method untuk mengarahkan ke halaman AI Chat
  void goToAiChat() {
    Get.toNamed(AppRoutes.aiChat);
  }

  void goToAppointmentDetail(int appointmentId) {
    // Arahkan ke halaman detail janji temu dengan ID yang diberikan
    Get.toNamed(AppRoutes.appointmentDetail, arguments: appointmentId);
  }

  Future<void> _fetchAppointments() async {
    final List<Appointment> responseData = await _appointmentService.getAll();

    appointments.assignAll(responseData);

    // Hitung total hadir dan tidak hadir
    if (responseData.isNotEmpty) {
      totalSuccess.value = appointments.where((item) => item.status == AppointmentStatus.attended).length;
      totalMissed.value = appointments.where((item) => item.status == AppointmentStatus.missed).length;
    }
  }

  /// Method internal untuk mengecek apakah user sudah mengisi alamat
  /// atau belum. Jika belum, akan mengembalikan `true`. Jika sudah,
  /// akan mengembalikan `false`.
  bool get _isAddressIncomplete {
    User? user = global.currentUser.value;

    // Jika user tidak ada, anggap alamat belum diisi
    if (user == null) {
      return true;
    }

    return user.address.isEmpty ||
        user.noRt == 0 ||
        user.noRw == 0 ||
        user.village.isEmpty ||
        user.district.isEmpty ||
        user.city.isEmpty ||
        user.province.isEmpty;
  }
}
