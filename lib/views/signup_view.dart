import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/signup_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/inputs/photo_picker.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/inputs/date_input.dart';
import 'package:blood_donor/widgets/inputs/select_input.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class SignupView extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());

  SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Pendaftaran Akun',
      showBackButton: true,
      // Footer: Sign Up Button
      footer: WideButton(
        label: 'Daftar',
        onPressed: controller.handleSignup,
        isLoading: controller.isLoading,
        isDisabled: controller.isSubmitDisabled,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Photo Picker
          PhotoPicker(selectedPhoto: controller.selectedPhoto),

          // TextInput: NIK
          TextInput(
            label: 'NIK',
            placeholder: 'Masukkan NIK...',
            isNumeric: true,
            controller: controller.nikController,
            onChanged: controller.validateInput,
          ),

          // TextInput: Full Name
          TextInput(
            label: 'Nama Lengkap',
            placeholder: 'Masukkan nama sesuai KTP...',
            controller: controller.nameController,
            onChanged: controller.validateInput,
          ),

          // TextInput: Password
          TextInput(
            label: 'Kata Sandi',
            placeholder: 'Masukkan minimal 8 digit...',
            isPassword: true,
            controller: controller.passwordController,
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

          Row(
            children: [
              // TextInput: Birth Place
              Expanded(
                child: TextInput(
                  label: 'Tempat Lahir',
                  placeholder: 'Kota kelahiran...',
                  controller: controller.birthPlaceController,
                ),
              ),
              const SizedBox(width: 16),

              // TextInput: Birth Date
              Expanded(
                child: DateInput(
                  label: 'Tanggal Lahir',
                  placeholder: 'DD/MM/YYYY',
                  selectedDate: controller.birthDateController,
                ),
              ),
            ],
          ),

          // SelectInput: Gender
          SelectInput(
            label: 'Jenis Kelamin',
            options: ['Laki-laki', 'Perempuan'],
            selectedValue: controller.gender,
            allowDeselect: true,
          ),

          // TextInput: Job
          TextInput(
            label: 'Pekerjaan',
            placeholder: 'Masukkan pekerjaan Anda...',
            controller: controller.jobController,
          ),

          // TextInput: Phone Number
          TextInput(
            label: 'Nomor Telepon',
            placeholder: '08...',
            isNumeric: true,
            controller: controller.phoneNumberController,
          ),

          Row(
            children: [
              // TextInput: Weight
              Expanded(
                child: TextInput(
                  label: 'Berat Badan',
                  placeholder: 'Berat badan (kg)...',
                  isNumeric: true,
                  controller: controller.weightKgController,
                ),
              ),
              const SizedBox(width: 16),

              // TextInput: Height
              Expanded(
                child: TextInput(
                  label: 'Tinggi Badan',
                  placeholder: 'Tinggi badan (cm)...',
                  isNumeric: true,
                  controller: controller.heightCmController,
                ),
              ),
            ],
          ),

          // SelectInput: Blood Type
          SelectInput(
            label: 'Golongan Darah',
            options: ['A', 'B', 'AB', 'O'],
            selectedValue: controller.bloodType,
            allowDeselect: true,
          ),

          // SelectInput: Rhesus
          SelectInput(
            label: 'Rhesus',
            options: ['Positif', 'Negatif'],
            selectedValue: controller.rhesus,
            allowDeselect: true,
          ),
        ],
      ),
    );
  }
}
