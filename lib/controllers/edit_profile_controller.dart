import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/utils/simulate_wait.dart';

class EditProfileController extends GetxController {
  // Retrieve the user ID from the URL parameters via `onInit` method
  late final int userId;

  @override
  void onInit() {
    super.onInit();

    userId = int.parse(Get.parameters['userId'] ?? '0');
  }

  final UserService _userService = UserService.instance;

  final Rx<File?> selectedImage = Rx<File?>(null);
  final TextEditingController nikController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final Rx<DateTime> birthDate = Rx<DateTime>(DateTime.now());
  final TextEditingController jobController = TextEditingController();
  final RxString gender = ''.obs;
  final RxString bloodType = ''.obs;
  final TextEditingController weightKgController = TextEditingController();
  final TextEditingController heightCmController = TextEditingController();

  final isLoading = false.obs;

  // TODO: Implement a method to fetch user data and populate the fields
  Future<void> fetchUserData() async {
    // TODO: Use url parameter to fetch user data
  }

  /// Save new user data to the database
  Future<void> submit() async {
    // Get all the input values
    String nik = nikController.text.trim();
    String name = nameController.text.trim();
    String birthPlace = birthPlaceController.text.trim();
    String job = jobController.text.trim();

    String weightKg = weightKgController.text.trim();
    String heightCm = heightCmController.text.trim();

    // Simulate API call delay
    isLoading.value = true;
    await simulateWait();

    // TODO: Actually implement update profile function!

    isLoading.value = false;
    Get.back(); // Navigate back to the previous page
  }
}
