import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/core/theme.dart';
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

  final isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _populateTextInputs(); // Isi inputan dengan data user saat ini
  }

  /// Method untuk menyimpan alamat baru ke database
  Future<void> handleSubmit() async {
    try {
      // Siapkan request untuk dikirim ke server
      final User request = global.currentUser.value!;
      request.address = addressController.text;
      request.rt = int.tryParse(rtController.text) ?? 0;
      request.rw = int.tryParse(rwController.text) ?? 0;
      request.village = villageController.text;
      request.district = districtController.text;
      request.city = cityController.text;
      request.province = province.value;

      // Mulai animasi loading
      isLoading.value = true;

      // Kirim request update ke server
      await _profileService.updateProfile(request);

      // Kembali ke halaman sebelumnya
      Get.back();

      // Tampilkan notifikasi sukses
      Get.snackbar(
        'Berhasil',
        'Alamat berhasil diperbarui',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        colorText: AppColors.black,
        backgroundColor: AppColors.white,
        boxShadows: [AppStyles.cardShadow],
      );
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
    rtController.text = user.rt.toString();
    rwController.text = user.rw.toString();
    villageController.text = user.village;
    districtController.text = user.district;
    cityController.text = user.city;
    province.value = user.province;
  }
}
