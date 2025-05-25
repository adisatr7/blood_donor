import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  Future<void> handleSubmit() async {
    // TODO: Implement the actual update function in UserService
  }
}
