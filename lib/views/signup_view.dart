import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/signup_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/inputs/photo_picker.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/inputs/date_input.dart';
import 'package:blood_donor/widgets/inputs/select_input.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class SignUpView extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Pendaftaran Akun',
      showBackButton: true,
      // Footer: Sign Up Button
      footer: WideButton(
        label: 'Daftar',
        onPressed: controller.signUp,
        isLoading: controller.isLoading,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Photo Picker
          PhotoPicker(selectedImage: controller.selectedImage),

          // TextInput: NIK
          TextInput(
            label: 'NIK',
            placeholder: 'Masukkan NIK...',
            controller: controller.nikController,
          ),

          // TextInput: Full Name
          TextInput(
            label: 'Nama Lengkap',
            placeholder: 'Masukkan nama sesuai KTP...',
            controller: controller.nameController,
          ),

          // TextInput: Password
          TextInput(
            label: 'Kata Sandi',
            placeholder: 'Masukkan minimal 8 digit...',
            isPassword: true,
            controller: controller.passwordController,
          ),

          // TextInput: Confirm Password
          TextInput(
            label: 'Ulangi Kata Sandi',
            placeholder: 'Masukkankan ulang kata sandi...',
            isPassword: true,
            controller: controller.confirmPasswordController,
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
                  selectedDate: controller.birthDate,
                ),
              ),
            ],
          ),

          // SelectInput: Gender
          SelectInput(
            label: 'Jenis Kelamin',
            options: ['Laki-laki', 'Perempuan'],
            selectedValue: controller.gender,
          ),

          // TextInput: Job
          TextInput(
            label: 'Pekerjaan',
            placeholder: 'Masukkan pekerjaan Anda...',
            controller: controller.jobController,
          ),

          Row(
            children: [
              // TextInput: Weight
              Expanded(
                child: TextInput(
                  label: 'Berat Badan',
                  placeholder: 'Berat badan (kg)...',
                  controller: controller.weightKgController,
                  isNumeric: true,
                ),
              ),
              const SizedBox(width: 16),

              // TextInput: Height
              Expanded(
                child: TextInput(
                  label: 'Tinggi Badan',
                  placeholder: 'Tinggi badan (cm)...',
                  controller: controller.heightCmController,
                  isNumeric: true,
                ),
              ),
            ],
          ),
          

          // SelectInput: Blood Type
          SelectInput(
            label: 'Golongan Darah',
            options: ['A', 'B', 'AB', 'O'],
            selectedValue: controller.bloodType,
          ),

          // SelectInput: Rhesus
          SelectInput(
            label: 'Rhesus',
            options: ['Positif', 'Negatif'],
            selectedValue: controller.rhesus,
          ),
        ],
      ),
    );
  }
}
