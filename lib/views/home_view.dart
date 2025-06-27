import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/home_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/home/user_profile_header.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:blood_donor/widgets/home/appointment_card.dart';
import 'package:blood_donor/core/theme.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  /// Method internal untuk membangun widget AppointmentCard agar
  /// terlihat lebih rapi daripada ditulis di bawah ListView.builder
  Widget _buildItem(BuildContext context, int index) {
    final appointment = controller.appointments[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppointmentCard(
        appointment: appointment,
        onTap: controller.goToAppointmentDetail,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        onPressed: controller.goToAiChat,
        child: const Icon(Icons.chat_rounded),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🧑‍🦳 Info tentang user dan tombol pengaturan
          UserProfileHeader(
            currentUser: controller.global.currentUser,
            // onGoToChat: controller.goToChat,
            onGoToSettings: controller.goToSettings,
          ),
          const SizedBox(height: 12),

          // 🗺️ Tombol untuk mencari lokasi donor terdekat
          WideButton(
            leftIcon: const Icon(
              Icons.bloodtype_rounded,
              color: AppColors.white,
            ),
            label: 'Cari Donor Terdekat',
            onPressed: controller.goToMap,
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Text(
                'Riwayat Donor',
                style: AppTextStyles.heading,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // 📅 Daftar sesi kunjungan donor (appointment)
          Obx(() {
            // Jika riwayat donot kosong, tampilkan text
            if (controller.appointments.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 64),
                child: Text(
                  'Belum ada riwayat donor.\nYuk mulai daftar donor sekarang!',
                  style: AppTextStyles.bodyGray,
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.appointments.length,
              itemBuilder: _buildItem,
            );
          }),
        ],
      ),
    );
  }
}
