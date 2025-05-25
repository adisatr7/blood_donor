import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:blood_donor/services/profile_service.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/theme.dart';

class EditProfileController extends GetxController {
  final ProfileService _profileService = ProfileService.instance;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString currentProfilePictureUrl = ''.obs;

  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final Rx<DateTime> birthDate = Rx<DateTime>(DateTime.now());
  final TextEditingController jobController = TextEditingController();
  final RxString gender = ''.obs;
  final RxString bloodType = ''.obs;
  final RxString rhesus = ''.obs;
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _fetchUserData(); // Ambil data dari server untuk mengisi form dengan data saat ini
  }

  /// Method internal untuk mengambil data pengguna dari server
  Future<void> _fetchUserData() async {
    final User user = await _profileService.getProfile();

    // Isi TextController dengan data pengguna saat ini
    currentProfilePictureUrl.value = user.profilePicture!.path;
    nikController.text = user.nik;
    nameController.text = user.name;
    birthPlaceController.text = user.birthPlace;
    birthDate.value = user.birthDate;
    jobController.text = user.job;
    gender.value = user.gender;
    bloodType.value = user.bloodType;
    rhesus.value = user.rhesus;
    weightKgController.text = user.weightKg.toString();
    heightCmController.text = user.heightCm.toString();
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
        Get.snackbar(
          'Gagal Memuat Gambar',
          'Ukuran gambar terlalu besar. Maksimal 2 MB.',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 2),
          colorText: AppColors.black,
          backgroundColor: AppColors.white,
          boxShadows: [AppStyles.cardShadow],
        );
        selectedImage.value = null;
        return;
      }

      // Set gambar yang dipilih
      selectedImage.value = image;

      // Kirim gambar ke server
      await _profileService.updateProfilePicture(image);
    } on DioException catch (e) {
      // Jika ada error, tampilkan notifikasi error
      showAppError('Gagal Memperbarui Foto Profil', e);
    } finally {
      // Selesaikan animasi loading
      isLoading.value = false;
    }
  }

  /// Method untuk handle tombol submit
  Future<void> handleSubmit() async {
    try {
      // Siapkan request data
      final User request = User(
        nik: nikController.text,
        name: nameController.text,
        birthPlace: birthPlaceController.text,
        birthDate: birthDate.value,
        job: jobController.text,
        gender: User.genderStringToEnum(gender.value),
        bloodType: bloodType.value,
        rhesus: User.rhesusStringToEnum(rhesus.value),
        weightKg: double.tryParse(weightKgController.text) ?? 0,
        heightCm: double.tryParse(heightCmController.text) ?? 0,
      );

      // Mulai animasi loading
      isLoading.value = true;

      // Kirim request update ke server
      await _profileService.updateProfile(request);

      // Kembali ke halaman sebelumnya
      Get.back();

      // Tampilkan notifikasi sukses
      Get.snackbar(
        'Berhasil',
        'Data diri berhasil diperbarui',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        colorText: AppColors.black,
        backgroundColor: AppColors.white,
        boxShadows: [AppStyles.cardShadow],
      );
    } on DioException catch (e) {
      // Jika ada error, tampilkan notifikasi error
      showAppError('Gagal Memperbarui Data Diri', e);
    } finally {
      // Selesai animasi loading
      isLoading.value = false;
    }
  }
}
