import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/user.dart';
import 'package:blood_donor/utils/simulate_wait.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/app_routes.dart';

class LoginController extends GetxController {
  final UserService _userService = UserService.instance;
  final GlobalController _globalController = Get.find<GlobalController>();

  final TextEditingController nikController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool obscureText = true.obs;
  final isLoading = false.obs;

  /// Login method to authenticate the user
  Future<void> login() async {
    String nik = nikController.text.trim();
    String password = passwordController.text.trim();

    // Simulate API call delay
    isLoading.value = true;
    await simulateWait();

    // Fetch user from the database
    User? user = await _userService.getUserByNikAndPassword(nik, password);
    isLoading.value = false;

    // If user not found, show error message
    if (user == null) {
      showAppDialog(
        title: 'Gagal Masuk',
        message: 'NIK atau kata sandi salah!',
      );
      return;
    }

    // Save user to global controller
    _globalController.currentUser = user;

    // Navigate to home page
    goToHomePage();
  }

  /// Go to the registration page
  void goToSignUpPage() {
    Get.toNamed(AppRoutes.signUp);
  }

  /// Go to home page
  void goToHomePage() {
    Get.offAllNamed(AppRoutes.home);
  }
}

class LoginResponse {
  final bool success;
  final String message;

  LoginResponse({required this.success, required this.message});
}
