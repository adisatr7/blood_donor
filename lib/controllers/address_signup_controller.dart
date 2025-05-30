import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/app_routes.dart';

class AddressSignupController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController rtController = TextEditingController();
  final TextEditingController rwController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final RxString province = ''.obs;

  final RxBool isSubmitDisabled = true.obs;
  final RxBool isLoading = false.obs;

  /// Method untuk mengecek apakah semua inputan sudah diisi
  void validateInput(String _) {
    // Cek apakah semua inputan wajib diisi
    bool isEmpty =
        addressController.text.isEmpty ||
        rtController.text.isEmpty ||
        rwController.text.isEmpty ||
        villageController.text.isEmpty ||
        districtController.text.isEmpty ||
        cityController.text.isEmpty ||
        province.value.isEmpty;

    // Jika ada yang kosong, maka tombol Submit akan dimatikan
    isSubmitDisabled.value = isEmpty;
  }

  /// Method untuk mengirimkan data alamat
  Future<void> handleSubmit() async {
    try {
      // Ambil data profil pengguna yang sudah ada
      final User user = await _profileService.getProfile();

      // Perbarui data alamat pengguna
      user.address = addressController.text;
      user.rt = int.tryParse(rtController.text) ?? 0;
      user.rw = int.tryParse(rwController.text) ?? 0;
      user.village = villageController.text;
      user.district = districtController.text;
      user.city = cityController.text;
      user.province = province.value;

      // Mulai animasi loading
      isLoading.value = true;

      // Kirim request ke server
      await _profileService.updateProfile(user);

      // Jika berhasil, bawa user ke halaman utama (Home)
      _goToHome();
    } on DioException catch (e) {
      // Tampilakn pesan error jika ada
      showAppError('Gagal saat menyimpan alamat', e);
    } finally {
      // Hentikan animasi loading
      isLoading.value = false;
    }
  }

  /// Method untuk melewati proses memasukkan alamat
  void handleSkip() {
    // Bawa user ke home screen
    _goToHome();

    // Tampilkan pesan bahwa sebaiknya ia mengisi alamat sebelum melakukan donor
    showAppDialog(
      title: 'Pengisian Alamat Dilewati',
      message: 'Mohon lakukan pengisian alamat sebelum melakukan donor darah.',
    );
  }

  /// Method internal untuk membuka halaman utama (Home)
  void _goToHome() {
    Get.offAllNamed(AppRoutes.home);
  }
}
