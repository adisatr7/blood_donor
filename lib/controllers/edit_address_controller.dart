import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/models/user.dart';
import 'package:blood_donor/utils/simulate_wait.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/core/app_routes.dart';

class EditAddressController extends GetxController {
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

  // TODO: Implement a method to fetch user data and populate the fields
  Future<void> fetchUserData() async {
    // TODO: Use url parameter to fetch user data
  }

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

    // TODO: Implement the actual update function in UserService

    // Show success message
    Get.snackbar(
      'Berhasil',
      'Alamat domisili Anda berhasil disimpan.',
      backgroundColor: AppColors.success,
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );

    Get.back(); // Navigate back to the previous page
  }

  /// Skip the address input
  void skip() {
    Get.offNamed(AppRoutes.home);
  }
}
