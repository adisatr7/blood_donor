import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/edit_profile_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/inputs/photo_picker.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/inputs/date_input.dart';
import 'package:blood_donor/widgets/inputs/select_input.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class EditProfileView extends StatelessWidget {
  EditProfileView({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Perbarui Data Diri',
      showBackButton: true,
      backButtonLabel: 'Batal',
      // Footer: Sign Up Button
      footer: WideButton(
        label: 'Simpan',
        onPressed: controller.submit,
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
          const SizedBox(height: 16),

          // TextInput: Full Name
          TextInput(
            label: 'Nama Lengkap',
            placeholder: 'Masukkan nama sesuai KTP...',
            controller: controller.nameController,
          ),
          const SizedBox(height: 16),

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
          const SizedBox(height: 16),

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
          const SizedBox(height: 16),

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
          const SizedBox(height: 16),

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
