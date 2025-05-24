import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/auth_service.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/models/api/auth/login_request.dart';
import 'package:blood_donor/models/api/auth/login_response.dart';

class LoginController extends GetxController {
  final GetStorage _storageClient = GetStorage();
  final AuthService _authService = AuthService.instance;

  final TextEditingController nikController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoginDisabled = true.obs;
  final RxBool isLoading = false.obs;

  /// Method untuk mengecek apakah kolom inputan sudah valid. Untuk dipasangkan
  /// ke prop `onChanged` pada kolom inputan yang wajib diisi
  void validateInput(String value) {
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

      // Kirim request ke server dan terima response data
      final LoginResponse response = await _authService.login(request);

      // Ambil JWT token dari response data dan simpan ke penyimpanan lokal
      final String token = response.token;
      _storageClient.write('token', token);

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

  /// Method internal untuk membuka halaman Sign Up (Daftar Akun)
  void _goToSignupPage() {
    Get.toNamed(AppRoutes.signUp);
  }

  /// Method internal untuk membuka halaman utama (Home)
  void _goToHomePage() {
    Get.offAllNamed(AppRoutes.home);
  }
}
