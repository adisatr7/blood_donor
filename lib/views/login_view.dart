import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/controllers/login_controller.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // TextInput: NIK
              TextInput(
                label: 'NIK',
                placeholder: 'Masukkan NIK...',
                controller: controller.nikController,
              ),
              const SizedBox(height: 16),

              // TextInput: Password
              TextInput(
                label: 'Kata Sandi',
                placeholder: 'Masukkan kata sandi...',
                isPassword: true,
                controller: controller.passwordController,
              ),
              const SizedBox(height: 20),

              // Button: Login
              WideButton(
                label: 'Masuk',
                onPressed: () {
                  controller.login();
                },
                isLoading: controller.isLoading,
              ),
              WideButton(
                label: 'Isi Nanti',
                type: ButtonType.secondary,
                onPressed: () {
                  controller.login();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
