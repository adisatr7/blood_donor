import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/auth_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/models/api/login_request.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final TextEditingController nikController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoginDisabled = true.obs;
  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();

    // Cek apakah server dapat dijangkau saat controller diinisialisasi
    _checkServerReadiness();
  }

  /// Method untuk mengecek apakah kolom inputan sudah valid. Untuk dipasangkan
  /// ke prop `onChanged` pada kolom inputan yang wajib diisi
  void validateInput(String _) {
    // Cek apakah inputan NIK dan password kosong
    bool isEmpty = nikController.text.isEmpty || passwordController.text.isEmpty;

    // Cek apakah inputan NIK dan password terlalu pendek
    // - NIK: minimal 16 karakter
    // - Password: minimal 8 karakter
    bool isTooShort = nikController.text.length < 16 || passwordController.text.length < 8;

    // Jika ada salah satu saja yang `true`, maka tombol Login akan dimatikan
    isLoginDisabled.value = (isEmpty || isTooShort);
  }

  /// Method handler untuk dipasangkan ke tombol Login
  Future<void> handleLogin() async {
    try {
      // Ambil data dari inputan NIK dan password
      String nik = nikController.text.trim();
      String password = passwordController.text.trim();

      // Mulai animasi loading
      isLoading.value = true;

      // Siapkan request payload untuk dikirim ke server
      final LoginRequest request = LoginRequest(nik: nik, password: password);

      // Kirim request ke server
      await _authService.login(request);

      // Simpan data user yang berhasil login ke GlobalController
      global.refreshCurrentUser();

      // Jika login berhasil, buka halaman utama (Home)
      _goToHomePage();
    } on DioException catch (e) {
      // Jika login gagal, tampilkan dialog error
      showAppError('Login Gagal', e);
    } finally {
      // Baik berhasil maupun gagal, hentikan animasi loading
      isLoading.value = false;
    }
  }

  /// Handler method untuk dipasangkan ke tombol Daftar Akun
  void handleSignup() {
    _goToSignupPage();
  }

  /// Method internal untuk mengecek apakah server dapat dijangkau
  void _checkServerReadiness() async {
    try {
      isLoading.value = true;
      await _authService.isServerUp();
    } catch (_) {
      // Jika tidak dapat dijangkau, tampilkan dialog error
      showAppDialog(
        title: 'Aplikasi Tidak Dapat Terhubung ke Server',
        message: 'Periksa koneksi internet Anda atau coba lagi nanti.',
      );
    } finally {
      isLoading.value = false;
    }
  }

  /// Method internal untuk membuka halaman Sign Up (Daftar Akun)
  void _goToSignupPage() {
    Get.toNamed(AppRoutes.signup);
  }

  /// Method internal untuk membuka halaman utama (Home)
  void _goToHomePage() {
    Get.offAllNamed(AppRoutes.home);
  }
}
