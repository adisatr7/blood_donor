import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  // Retrieve the user ID from the URL parameters via `onInit` method
  late final int userId;

  @override
  void onInit() {
    super.onInit();

    userId = int.parse(Get.parameters['userId'] ?? '0');
  }

  final Rx<File?> selectedImage = Rx<File?>(null);
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

  // TODO: Implement a method to fetch user data and populate the fields
  Future<void> fetchUserData() async {
    // TODO: Use url parameter to fetch user data
  }

  /// Save new user data to the database
  Future<void> submit() async {
    // TODO: Implement the logic to save the user data
  }
}
