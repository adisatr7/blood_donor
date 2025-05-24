import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/auth_service.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/models/api/auth/signup_request.dart';
import 'package:blood_donor/models/api/auth/signup_response.dart';
import 'package:blood_donor/models/api/auth/login_request.dart';
import 'package:blood_donor/models/api/auth/login_response.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/app_routes.dart';

class SignupController extends GetxController {
  final GetStorage _storageClient = GetStorage();
  final AuthService _authService = AuthService.instance;

  final Rx<File?> selectedPhoto = Rx<File?>(null);
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final Rx<DateTime> birthDateController = Rx<DateTime>(DateTime.now());
  final TextEditingController jobController = TextEditingController();
  final RxString gender = ''.obs;
  final RxString bloodType = ''.obs;
  final RxString rhesus = ''.obs;
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();

  final RxBool isSubmitDisabled = true.obs;
  final RxBool isLoading = false.obs;

  /// Method untuk mengecek apakah kolom inputan sudah valid. Untuk dipasangkan
  /// ke prop `onChanged` pada kolom inputan yang wajib diisi
  void validateInput(String _) {
    // Cek apakah inputan wajib ada yang kosong
    bool isEmpty = nikController.text.isEmpty ||
        nameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty;

    // Cek apakah inputan NIK dan password terlalu pendek
    // - NIK: minimal 16 karakter
    // - Password: minimal 8 karakter
    bool isTooShort = nikController.text.length < 16 ||
        passwordController.text.length < 8 ||
        confirmPasswordController.text.length < 8;

    // Jika ada salah satu saja yang `true`, maka tombol Daftar akan dimatikan
    isSubmitDisabled.value = (isEmpty || isTooShort);
  }

  /// Method handler untuk dipasangkan ke tombol Daftar Akun
  Future<void> handleSignup() async {
    // Cek apakah password dan konfirmasi password sama
    if (passwordController.text != confirmPasswordController.text) {
      showAppDialog(
        title: 'Gagal Mendaftarkan Akun',
        message: 'Konfirmasi kata sandi tidak sesuai',
      );
      return;
    }

    try {
      // Ambil data dari semua kolom inputan
      String nik = nikController.text.trim();
      String name = nameController.text.trim();
      String password = passwordController.text.trim();
      String birthPlace = birthPlaceController.text.trim();
      DateTime birthDate = birthDateController.value;
      String job = jobController.text.trim();
      String bloodTypeString = bloodType.value;
      String weightKg = weightKgController.text.trim();
      String heightCm = heightCmController.text.trim();

      // Untuk data berikut perlu dikonversi karena di MySQL disimpan dengan tipe data Enumerasi
      // Enumerasi digunakan untuk memastikan tidak ada data yang aneh-aneh (cth: golongan darah `C++`)
      String genderEnum = User.genderStringToEnum(gender.value);
      String rhesusEnum = User.rhesusStringToEnum(rhesus.value);

      // Siapkan request payload untuk dikirim ke server
      final SignupRequest signupReq = SignupRequest(
        user: User(
          nik: nik,
          name: name,
          password: password,
          profilePicture: selectedPhoto.value,
          birthPlace: birthPlace,
          birthDate: birthDate,
          job: job,
          gender: genderEnum,
          bloodType: bloodTypeString,
          rhesus: rhesusEnum,
          weightKg: double.tryParse(weightKg) ?? 0.0,
          heightCm: double.tryParse(heightCm) ?? 0.0,
        ),
      );

      // Mulai animasi loading
      isLoading.value = true;

      // Jalankan method signup dari AuthService
      final SignupResponse signupRes = await _authService.signup(signupReq);

      // Periksa apakah pendaftaran berhasil
      if (!signupRes.success) {
        // Jika gagal, tampilkan pesan error dan hentikan proses
        showAppError('Gagal Mendaftarkan Akun', 'Pendaftaran tidak berhasil. Silakan coba lagi.');
        return;
      }
      // Jika pendaftaran berhasil, lakukan login untuk mendapatkan JWT token
      final LoginRequest loginReq = LoginRequest(nik: nik, password: password);
      final LoginResponse loginRes = await _authService.login(loginReq);

      // Ambil JWT token dari data response login dan simpan ke penyimpanan lokal
      final String token = loginRes.token;
      _storageClient.write('token', token);

      // Lanjut ke halaman input alamat
      _goToAddressSignup(signupRes.userId);
    } on DioException catch (e) {
      // Jika terjadi error, tampilkan pesan error
      showAppError('Gagal Mendaftarkan Akun', e);
    } finally {
      // Baik berhasil maupun gagal, hentikan animasi loading
      isLoading.value = false;
    }
  }

  /// Method internal untuk membuka halaman input alamat. Parameter `userId` digunakan
  /// untuk menentukan user mana yang alamatnya akan dimasukkan
  void _goToAddressSignup(int userId) {
    Get.toNamed('${AppRoutes.addressSignup}/$userId');
  }
}
