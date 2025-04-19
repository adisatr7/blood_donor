import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/utils/simulate_wait.dart';
import 'package:blood_donor/core/app_routes.dart';

class EditPasswordController extends GetxController {
  final UserService _userService = UserService.instance;

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  /// Sign up method to register a new user
  Future<void> signUp() async {
    // Get all the input values
    String oldPassword = oldPasswordController.text.trim();
    String newPassword = newPasswordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Validate input values
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      _showPopupWarning('Kesalahan', 'Semua kolom harus diisi!');
      return;
    }
    if (newPassword != confirmPassword) {
      _showPopupWarning(
        'Kesalahan',
        'Password baru dan konfirmasi password tidak cocok!',
      );
      return;
    }
    if (newPassword.length < 8) {
      _showPopupWarning(
        'Kesalahan',
        'Password harus memiliki setidaknya 8 karakter!',
      );
      return;
    }
    if (oldPassword == newPassword) {
      _showPopupWarning(
        'Kesalahan',
        'Password baru tidak boleh sama dengan password lama!',
      );
      return;
    }

    // Simulate API call delay
    isLoading.value = true;
    await simulateWait();

    // TODO: Actually implement edit password function!

    isLoading.value = false;
    goToAddressSignUp(0); // Navigate to address sign up page
  }

  /// Go to address sign up page.
  /// [userId] is the ID of the user to be passed to the address sign up page
  void goToAddressSignUp(int userId) {
    Get.toNamed('${AppRoutes.addressSignUp}/$userId');
  }

  /// Private helper method to show a styled snackbar warning message
  void _showPopupWarning(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.danger,
      colorText: AppColors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
