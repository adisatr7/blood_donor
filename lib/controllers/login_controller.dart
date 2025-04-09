import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/services/user_service.dart';
import 'package:blood_donor/models/user.dart';
import 'package:blood_donor/utils/simulate_wait.dart';

class LoginController extends GetxController {
  final UserService _userService = UserService.instance;

  final TextEditingController nikController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool obscureText = true.obs;
  final isLoading = false.obs;

  /// Login method to authenticate the user
  Future<LoginResponse> login() async {
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
      return LoginResponse(success: false, message: 'NIK atau password salah');
    }

    return LoginResponse(success: true, message: 'Login berhasil');
  }
}

class LoginResponse {
  final bool success;
  final String message;

  LoginResponse({required this.success, required this.message});
}
