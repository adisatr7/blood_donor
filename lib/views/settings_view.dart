import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/settings_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/core/theme.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final SettingsController controller = Get.put(SettingsController());

  /// Builder untuk widget button agar tidak perlu atur style berulang-ulang
  Widget _buildButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = AppColors.black,
    TextStyle textStyle = AppTextStyles.body,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: textStyle),
      onTap: onTap,
    );
  }

  /// Builder untuk widget divider agar tidak perlu atur style berulang-ulang
  Widget _buildDivider() {
    return const Divider(height: 1, thickness: 1, color: AppColors.gray);
  }

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
          // Tombol ubah profil
          _buildButton(
            icon: Icons.manage_accounts_rounded,
            title: 'Perbarui Data Diri',
            onTap: controller.goToEditProfile,
          ),
          _buildDivider(),

          // Tombol ubah alamat
          _buildButton(
            icon: Icons.location_on_rounded,
            title: 'Perbarui Alamat',
            onTap: controller.goToEditAddress,
          ),
          _buildDivider(),

          // Tombol ubah kata sandi
          _buildButton(
            icon: Icons.key_rounded,
            title: 'Ubah Kata Sandi',
            onTap: controller.goToEditPassword,
          ),
          _buildDivider(),

          // Tombol tentang PMI
          _buildButton(
            icon: Icons.info_outline_rounded,
            title: 'Tentang PMI',
            onTap: controller.goToAbout,
          ),
          _buildDivider(),

          // Button: Logout
          _buildButton(
            icon: Icons.logout,
            title: 'Keluar',
            onTap: controller.handleLogout,
            iconColor: AppColors.danger,
            textStyle: AppTextStyles.bodyDanger,
          ),
        ],
      ),
    );
  }
}
