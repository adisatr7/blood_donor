import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/models/api/edit_password_request.dart';
import 'package:blood_donor/widgets/popups/snackbar.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class EditPasswordController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final RxBool isSubmitDisabled = true.obs;
  final RxBool isLoading = false.obs;

  /// Method untuk mengecek apakah masih ada inputan kosong atau terlalu pendek
  void validateInput(String _) {
    // Cek apakah inputan wajib ada yang kosong
    bool isEmpty =
        oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty;

    // Cek apakah kata sandi terlalu pendek (minimal 8 karakter)
    bool isTooShort =
        oldPasswordController.text.length < 8 ||
        newPasswordController.text.length < 8 ||
        confirmPasswordController.text.length < 8;

    // Jika ada salah satu saja yang `true`, maka tombol Simpan akan dimatikan
    isSubmitDisabled.value = (isEmpty || isTooShort);
  }

  /// Method untuk mengirim kata sandi baru ke server
  Future<void> handleSubmit() async {
    try {
      // Siapkan request untuk dikirim ke server
      final EditPasswordRequest request = EditPasswordRequest(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      // Mulai animasi loading
      isLoading.value = true;

      // Kirim request ke server
      await _profileService.updatePassword(request);

      // Jika berhasil, kembali ke halaman sebelumnya
      Get.back();

      // Tampilkan notifikasi sukses
      showSnackbar(title: 'Berhasil', message: 'Kata sandi berhasil diubah');
    } on DioException catch (e) {
      // Jika ada error, tampilkan pesan error
      showAppError('Gagal Menyimpan Kata Sandi Baru', e);
    } finally {
      // Hentikan animasi loading
      isLoading.value = false;
    }
  }
}
