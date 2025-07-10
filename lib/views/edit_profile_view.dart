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
        onPressed: controller.handleSubmit,
        isLoading: controller.isLoading,
        isDisabled: controller.isSubmitDisabled,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Photo Picker
          PhotoPicker(
            selectedPhoto: controller.selectedImage,
            initialPhotoUrl: controller.currentProfilePictureUrl,
            onChanged: controller.handleUpdatePicture,
          ),

          // TextInput: NIK
          TextInput(
            label: 'NIK',
            placeholder: 'Masukkan NIK...',
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

          Row(
            children: [
              // TextInput: Birth Place
              Expanded(
                child: TextInput(
                  label: 'Tempat Lahir',
                  placeholder: 'Kota kelahiran...',
                  controller: controller.birthPlaceController,
                  onChanged: controller.validateInput,
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
            onChanged: controller.validateInput,
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
                  onChanged: controller.validateInput,
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
                  onChanged: controller.validateInput,
                ),
              ),
            ],
          ),

          // SelectInput: Blood Type
          SelectInput(
            label: 'Golongan Darah',
            options: ['A', 'B', 'AB', 'O'],
            selectedValue: controller.bloodType,
            onChanged: controller.validateInput,
            allowDeselect: true,
          ),

          // SelectInput: Rhesus
          SelectInput(
            label: 'Rhesus',
            options: ['Positif', 'Negatif'],
            selectedValue: controller.rhesus,
            onChanged: controller.validateInput,
            allowDeselect: true,
          ),
        ],
      ),
    );
  }
}
