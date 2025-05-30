import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/auth_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/models/api/auth/signup_request.dart';
import 'package:blood_donor/models/api/auth/signup_response.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/app_routes.dart';

class SignupController extends GetxController {
  final AuthService _authService = AuthService.instance;
  final GlobalController global = Get.find<GlobalController>();

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
      final SignupRequest request = SignupRequest(
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
      final SignupResponse response = await _authService.signup(request);

      // Jika berhasil, simpan data user ke GlobalController
      global.refreshCurrentUser();

      // Lanjut ke halaman input alamat
      _goToAddressSignup(response.userId);
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
