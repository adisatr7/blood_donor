import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/widgets/popups/snackbar.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class EditAddressController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final TextEditingController addressController = TextEditingController();
  final TextEditingController rtController = TextEditingController();
  final TextEditingController rwController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final RxString province = ''.obs;

  final isSubmitDisabled = true.obs;
  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _populateTextInputs(); // Isi inputan dengan data user saat ini
  }

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

  /// Method untuk menyimpan alamat baru ke database
  Future<void> handleSubmit() async {
    try {
      // Siapkan request untuk dikirim ke server
      final User request = global.currentUser.value!;
      request.address = addressController.text.trim();
      request.noRt = int.tryParse(rtController.text.trim()) ?? 0;
      request.noRw = int.tryParse(rwController.text.trim()) ?? 0;
      request.village = villageController.text.trim();
      request.district = districtController.text.trim();
      request.city = cityController.text.trim();
      request.province = province.value;

      // Mulai animasi loading
      isLoading.value = true;

      // Kirim request update ke server
      await _profileService.updateProfile(request);

      // Kembali ke halaman sebelumnya
      Get.back();

      // Tampilkan notifikasi sukses
      showSnackbar(title: 'Berhasil', message: 'Alamat berhasil diperbarui');
    } on DioException catch (e) {
      // Jika ada error, tampilkan pesan error
      showAppError('Gagal Menyimpan Alamat Baru', e);
    } finally {
      // Update data user di GlobalController
      global.refreshCurrentUser();
      // Hentikan animasi loading
      isLoading.value = false;
    }
  }

  /// Method internal untuk mengisi TextController dengan data user dari GlobalController
  Future<void> _populateTextInputs() async {
    // Ambil data user yang sedang login dari GlobalController
    final User user = global.currentUser.value!;

    // Isi TextController dengan data user saat ini
    addressController.text = user.address;
    rtController.text = user.noRt.toString();
    rwController.text = user.noRw.toString();
    villageController.text = user.village;
    districtController.text = user.district;
    cityController.text = user.city;
    province.value = user.province;

    validateInput('');
  }
}
