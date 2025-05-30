import 'package:get/get.dart';

import 'package:blood_donor/services/auth_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/core/theme.dart';

class SettingsController extends GetxController {
  final AuthService _authService = AuthService.instance;
  final GlobalController global = Get.find<GlobalController>();

  /// Method untuk dipasangkan ke tombol ubah profil
  void goToEditProfile() {
    Get.toNamed(AppRoutes.editProfile);
  }

  /// Method untuk dipasangkan ke tombol ubah alamat
  void goToEditAddress() {
    Get.toNamed(AppRoutes.editAddress);
  }

  /// Method untuk dipasangkan ke tombol ubah kata sandi
  void goToEditPassword() {
    Get.toNamed(AppRoutes.editPassword);
  }

  /// Method untuk dipasangkan ke tombol tentang PMI
  void goToAbout() {
    Get.toNamed(AppRoutes.about);
  }

  /// Method untuk dipasangkan ke tombol Logout
  void handleLogout() {
    // Hapus token dari penyimpanan lokal
    _authService.logout();

    // Kembalikan user ke halaman login
    Get.offAllNamed(AppRoutes.login);

    // Hapus data user yang sedang login dari GlobalController
    global.clearCurrentUser();

    // Tampilkan pemberitahuan logout
    Get.snackbar(
      'Terima Kasih Telah Menggunakan Aplikasi Ini',
      'Anda telah berhasil keluar dari akun Anda.',
      snackPosition: SnackPosition.TOP,
      duration: Duration(seconds: 2),
      colorText: AppColors.black,
      backgroundColor: AppColors.white,
      boxShadows: [AppStyles.cardShadow],
    );
  }
}
