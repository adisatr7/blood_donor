import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/widgets/popups/snackbar.dart';
import 'package:blood_donor/core/theme.dart';

class EditProfileController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;
  final GlobalController global = Get.find<GlobalController>();

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString currentProfilePictureUrl = ''.obs;

  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final Rx<DateTime> birthDate = Rx<DateTime>(DateTime.now());
  final TextEditingController jobController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final RxString gender = ''.obs;
  final RxString bloodType = ''.obs;
  final RxString rhesus = ''.obs;
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();

  final RxBool isSubmitDisabled = true.obs;
  final RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    _populateTextInputs(); // Isi inputan dengan data user saat ini
  }

  /// Method untuk mengecek apakah kolom inputan sudah valid. Untuk dipasangkan
  /// ke prop `onChanged` pada kolom inputan yang wajib diisi Jika ada salah satu
  /// saja yang kosong, maka tombol Simpan akan dimatikan
  void validateInput(String _) {
    isSubmitDisabled.value =
        nikController.text.trim().isEmpty ||
        nameController.text.trim().isEmpty ||
        birthPlaceController.text.trim().isEmpty ||
        gender.value.isEmpty ||
        bloodType.value.isEmpty ||
        rhesus.value.isEmpty ||
        weightKgController.text.trim().isEmpty ||
        heightCmController.text.trim().isEmpty;
  }

  /// Method untuk handle update foto profil
  Future<void> handleUpdatePicture(File? image) async {
    try {
      // Skip jika tidak ada gambar yang dipilih
      if (image == null) {
        selectedImage.value = null;
        return;
      }

      isLoading.value = true; // Mulai animasi loading

      // Validasi ukuran file gambar
      final int maxSizeInBytes = 2 * 1024 * 1024; // 2 MB
      if (image.lengthSync() > maxSizeInBytes) {
        showSnackbar(
          title: 'Gagal Memuat Gambar',
          message: 'Ukuran gambar terlalu besar. Maksimal 2 MB.',
          colorText: AppColors.white,
          backgroundColor: AppColors.danger,
        );
        selectedImage.value = null;
        return;
      }

      // Set gambar yang dipilih
      selectedImage.value = image;

      // Kirim gambar ke server
      await _profileService.updateProfilePicture(image);

      // Tampilkan notifikasi sukses
      showSnackbar(title: 'Berhasil', message: 'Foto profil berhasil diperbarui');
    } on DioException catch (e) {
      // Jika ada error, tampilkan notifikasi error
      showAppError('Gagal Memperbarui Foto Profil', e);
    } finally {
      // Update data user di GlobalController
      global.refreshCurrentUser();
      // Selesaikan animasi loading
      isLoading.value = false;
    }
  }

  /// Method untuk handle tombol submit
  Future<void> handleSubmit() async {
    try {
      // Siapkan request untuk dikirim ke server
      final User request = global.currentUser.value!;
      request.nik = nikController.text.trim();
      request.name = nameController.text.trim();
      request.birthPlace = birthPlaceController.text.trim();
      request.birthDate = birthDate.value;
      request.job = jobController.text.trim();
      request.phoneNumber = phoneNumberController.text.trim();
      request.gender = gender.value;
      request.bloodType = bloodType.value;
      request.rhesus = rhesus.value;
      request.weightKg = double.tryParse(weightKgController.text.trim()) ?? 0;
      request.heightCm = double.tryParse(heightCmController.text.trim()) ?? 0;

      // Mulai animasi loading
      isLoading.value = true;

      // Kirim request update ke server
      await _profileService.updateProfile(request);

      // Kembali ke halaman sebelumnya
      Get.back();

      // Tampilkan notifikasi sukses
      showSnackbar(title: 'Berhasil', message: 'Data diri berhasil diperbarui');
    } on DioException catch (e) {
      // Jika ada error, tampilkan notifikasi error
      showAppError('Gagal Memperbarui Data Diri', e);
    } finally {
      // Update data user di GlobalController
      global.refreshCurrentUser();
      // Selesai animasi loading
      isLoading.value = false;
    }
  }

  /// Method internal untuk mengisi TextController dengan data user dari GlobalController
  Future<void> _populateTextInputs() async {
    // Ambil data user yang sedang login dari GlobalController
    final User user = global.currentUser.value!;

    // Isi TextController dengan data user saat ini
    currentProfilePictureUrl.value = user.profilePicture!.path;
    nikController.text = user.nik;
    nameController.text = user.name;
    birthPlaceController.text = user.birthPlace;
    birthDate.value = user.birthDate;
    jobController.text = user.job;
    phoneNumberController.text = user.phoneNumber;
    gender.value = user.gender;
    bloodType.value = user.bloodType;
    rhesus.value = user.rhesus;
    weightKgController.text = user.weightKg.toString();
    heightCmController.text = user.heightCm.toString();

    validateInput('');
  }
}
