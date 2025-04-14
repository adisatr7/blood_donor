import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/models/user.dart';
import 'package:blood_donor/utils/simulate_wait.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/core/app_routes.dart';

class AddressSignUpController extends GetxController {
  // Retrieve the user ID from the URL parameters via `onInit` method
  late final int userId;

  @override
  void onInit() {
    super.onInit();

    userId = int.parse(Get.parameters['userId'] ?? '0');
  }

  final UserService _userService = UserService.instance;

  final TextEditingController addressController = TextEditingController();
  final TextEditingController rtController = TextEditingController();
  final TextEditingController rwController = TextEditingController();
  final TextEditingController villageController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final RxString province = ''.obs;

  final isLoading = false.obs;

  /// Save the address data to the database
  Future<void> submit() async {
    String address = addressController.text.trim();
    String noRtString = rtController.text.trim(); // Needs to convert to int
    String noRwString = rwController.text.trim(); // Needs to convert to int
    String village = villageController.text.trim();
    String district = districtController.text.trim();
    String city = cityController.text.trim();

    // Simulate API call delay
    isLoading.value = true;
    await simulateWait();

    // Get user object
    User? user = await _userService.getById(userId);
    if (user == null) {
      isLoading.value = false;
      return;
    }

    // Update user object with new data
    final User updatedUser = User(
      id: user.id,
      nik: user.nik,
      name: user.name,
      password: user.password,
      birthPlace: user.birthPlace,
      birthDate: user.birthDate,
      gender: user.gender,
      job: user.job,
      weightKg: user.weightKg,
      heightCm: user.heightCm,
      bloodType: user.bloodType,
      address: address,
      rt: int.tryParse(noRtString) ?? 0,
      rw: int.tryParse(noRwString) ?? 0,
      village: village,
      district: district,
      city: city,
      province: province.value,
    );

    int response = await _userService.insertUser(updatedUser);

    // If there's an error while inserting the user, return an error message
    if (response == 0) {
      isLoading.value = false;
      return;
    }

    // Show success message
    Get.snackbar(
      'Berhasil',
      'Alamat domisili Anda berhasil disimpan.',
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );

    // Navigate to the home page after successful sign up
    Get.offNamed(AppRoutes.home);
  }

  /// Skip the address input
  void skip() {
    Get.offNamed(AppRoutes.home);
  }
}
