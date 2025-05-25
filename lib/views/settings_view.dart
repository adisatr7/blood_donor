import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/settings_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/core/theme.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Pengaturan',
      showBackButton: true,
      footer: Center(
        // Footer Text: App Version
        child: const Text('Versi 1.0.0', style: AppTextStyles.bodyGray),
      ),
      child: Column(
        children: [
          // Button: Edit Profile
          ListTile(
            leading: Icon(
              Icons.manage_accounts_rounded,
              color: AppColors.black,
            ),
            title: Text('Perbarui Data Diri', style: AppTextStyles.body),
            onTap: controller.goToEditProfile,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.gray),

          // Button: Edit Address
          ListTile(
            leading: Icon(Icons.edit_location_rounded, color: AppColors.black),
            title: Text('Perbarui Alamat', style: AppTextStyles.body),
            onTap: controller.goToEditAddress,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.gray),

          // Button: Edit Password
          ListTile(
            leading: Icon(Icons.key_rounded, color: AppColors.black),
            title: Text('Ubah kata Sandi', style: AppTextStyles.body),
            onTap: controller.goToEditPassword,
          ),
          const Divider(height: 1, thickness: 1, color: AppColors.gray),

          // Button: Logout
          ListTile(
            leading: Icon(Icons.logout, color: AppColors.danger),
            title: Text('Keluar', style: AppTextStyles.bodyDanger),
            onTap: controller.handleLogout,
          ),
        ],
      ),
    );
  }
}
