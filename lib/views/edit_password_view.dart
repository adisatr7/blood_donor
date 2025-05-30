import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/edit_password_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class EditPasswordView extends StatelessWidget {
  final EditPasswordController controller = Get.put(EditPasswordController());

  EditPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Ubah Kata Sandi',
      showBackButton: true,
      backButtonLabel: 'Batal',
      // Footer: Sign Up Button
      footer: WideButton(
        label: 'Simpan',
        onPressed: controller.handleSubmit,
        isLoading: controller.isLoading,
        isDisabled: controller.isSubmitDisabled,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // TextInput: Password
          TextInput(
            label: 'Kata Sandi Lama',
            placeholder: 'Masukkan kata sandi lama...',
            isPassword: true,
            controller: controller.oldPasswordController,
            onChanged: controller.validateInput,
          ),

          // TextInput: Password
          TextInput(
            label: 'Kata Sandi Baru',
            placeholder: 'Masukkan minimal 8 digit...',
            isPassword: true,
            controller: controller.newPasswordController,
            onChanged: controller.validateInput,
          ),

          // TextInput: Confirm Password
          TextInput(
            label: 'Ulangi Kata Sandi',
            placeholder: 'Masukkankan ulang kata sandi...',
            isPassword: true,
            controller: controller.confirmPasswordController,
            onChanged: controller.validateInput,
          ),
        ],
      ),
    );
  }
}
