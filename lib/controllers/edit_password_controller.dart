import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPasswordController extends GetxController {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  /// Sign up method to register a new user
  Future<void> handleSubmit() async {
    // TODO: Implement the logic to change the password
  }
}
