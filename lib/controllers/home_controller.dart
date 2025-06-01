import 'package:blood_donor/models/db/user.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class HomeController extends GetxController {
  final AppointmentService _appointmentService = AppointmentService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final RxList<Appointment> appointments = <Appointment>[].obs;

  @override
  void onReady() async {
    super.onReady();
    await _fetchAppointments();
  }

  void goToSettings() {
    Get.toNamed(AppRoutes.settings);
  }

  /// Method untuk mengarahkan ke Map
  void goToMap() {
    // Cek terlebih dahulu apakah user sudah mengisi alamat
    if (_isAddressIncomplete) {
      // Jika belum, arahkan ke halaman edit alamat
      Get.toNamed(AppRoutes.editAddress);

      // Tampilkan dialog peringatan
      showAppDialog(
        title: 'Anda Belum Mengisi Alamat',
        message: 'Harap isi alamat Anda terlebih dahulu sebelum menggunakan fitur peta.',
      );
      return;
    }

    // Jika sudah, arahkan ke halaman Map
    Get.toNamed(AppRoutes.map);
  }

  Future<void> _fetchAppointments() async {
    appointments.value = await _appointmentService.getAppointments();
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
        user.rt == 0 ||
        user.rw > 0 ||
        user.village.isEmpty ||
        user.district.isEmpty ||
        user.city.isEmpty ||
        user.province.isEmpty;
  }
}
