import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/edit_address_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';
import 'package:blood_donor/widgets/inputs/dropdown.dart';
import 'package:blood_donor/constants/province.dart';

class EditAddressView extends StatelessWidget {
  final EditAddressController controller = Get.put(EditAddressController());

  EditAddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Perbarui Alamat',
      showBackButton: true,
      backButtonLabel: 'Batal',
      // Footer: Buttons
      footer: Column(
        children: [
          // Button: Submit
          WideButton(
            label: 'Simpan',
            onPressed: controller.handleSubmit,
            isLoading: controller.isLoading,
            isDisabled: controller.isSubmitDisabled,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // TextInput: NIK
          TextInput(
            label: 'Alamat',
            placeholder: 'Jalan Sesame 123...',
            controller: controller.addressController,
            onChanged: controller.validateInput,
          ),

          Row(
            children: [
              // TextInput: RT
              Expanded(
                child: TextInput(
                  label: 'Nomor RT',
                  placeholder: 'RT 001',
                  isNumeric: true,
                  controller: controller.rtController,
                  onChanged: controller.validateInput,
                ),
              ),
              const SizedBox(width: 16),

              // TextInput: RW
              Expanded(
                child: TextInput(
                  label: 'Nomor RW',
                  placeholder: 'RW 001...',
                  isNumeric: true,
                  controller: controller.rwController,
                  onChanged: controller.validateInput,
                ),
              ),
            ],
          ),

          // TextInput: Village
          TextInput(
            label: 'Kelurahan/Desa',
            placeholder: 'Masukkan nama kelurahan/desa...',
            controller: controller.villageController,
            onChanged: controller.validateInput,
          ),

          // TextInput: District
          TextInput(
            label: 'Kecamatan',
            placeholder: 'Masukkan nama kecamatan...',
            controller: controller.districtController,
            onChanged: controller.validateInput,
          ),

          // TextInput: City
          TextInput(
            label: 'Kabupaten/Kota',
            placeholder: 'Masukkan nama kabupaten/kota...',
            onChanged: controller.validateInput,
            controller: controller.cityController,
          ),

          // TextInput: Province
          Dropdown(
            label: 'Provinsi',
            placeholder: 'Pilih provinsi...',
            options: Province.list,
            selectedValue: controller.province,
            onChanged: controller.validateInput,
          ),
        ],
      ),
    );
  }
}
