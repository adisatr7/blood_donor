import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/utils/simulate_wait.dart';
import 'package:blood_donor/core/app_routes.dart';

class SignUpController extends GetxController {
  final UserService _userService = UserService.instance;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final Rx<DateTime> birthDate = Rx<DateTime>(DateTime.now());
  final TextEditingController jobController = TextEditingController();
  final RxString gender = ''.obs;
  final RxString bloodType = ''.obs;
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();

  final isLoading = false.obs;

  /// Sign up method to register a new user
  Future<void> signUp() async {
    // Get all the input values
    String nik = nikController.text.trim();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String birthPlace = birthPlaceController.text.trim();
    String job = jobController.text.trim();

    String weightKg = weightKgController.text.trim();
    String heightCm = heightCmController.text.trim();

    // Simulate API call delay
    isLoading.value = true;
    await simulateWait();

    // TODO: Actually implement sign up function!

    isLoading.value = false;
    goToAddressSignUp(0); // Navigate to address sign up page
  }

  /// Go to address sign up page.
  /// [userId] is the ID of the user to be passed to the address sign up page
  void goToAddressSignUp(int userId) {
    Get.toNamed('${AppRoutes.addressSignUp}/$userId');
  }
}
