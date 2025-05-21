import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/gestures.dart';

import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/controllers/login_controller.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Padding(
        padding: const EdgeInsets.only(top: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ⬇️ Kolom input NIK
            TextInput(
              label: 'NIK',
              placeholder: 'Masukkan NIK...',
              controller: controller.nikController,
            ),

            // ⬇️ Kolom input Password
            TextInput(
              label: 'Kata Sandi',
              placeholder: 'Masukkan kata sandi...',
              isPassword: true,
              controller: controller.passwordController,
            ),
            const SizedBox(height: 18),

            // ⬇️ Tombol Login
            WideButton(
              label: 'Masuk',
              onPressed: controller.handleLogin,
              isLoading: controller.isLoading,
            ),
            const SizedBox(height: 12),

            // ⬇️ Komponen berisi text-text di bawah tombol Login
            Text.rich(
              TextSpan(
                text: 'Belum punya akun? ', // 💬 Text biasa
                style: AppTextStyles.body,
                children: [
                  TextSpan(
                    text: 'Daftar Sekarang', // 💬 Text yang bisa diklik
                    style: AppTextStyles.bodyBoldPrimary,
                    // 🔗 Apa yang terjadi saat diklik
                    recognizer:
                        TapGestureRecognizer()..onTap = controller.handleSignup,
                  ),
                  TextSpan(text: '!', style: AppTextStyles.body),
                ],
              ),
              textAlign: TextAlign.center, // 🖊️ Agar text di tengah
            ),
          ],
        ),
      ),
    );
  }
}
