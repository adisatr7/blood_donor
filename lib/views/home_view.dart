import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/home_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/home/user_profile_header.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:blood_donor/widgets/home/appointment_card.dart';

class HomeView extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  HomeView({super.key});

  /// Method internal untuk membangun widget AppointmentCard agar
  /// terlihat lebih rapi daripada ditulis di bawah ListView.builder
  Widget _buildItem(BuildContext context, int index) {
    final appointment = controller.appointments[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppointmentCard(appointment: appointment),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🧑‍🦳 Info tentang user dan tombol pengaturan
          UserProfileHeader(
            currentUser: controller.currentUser,
            onIconPress: controller.goToSettings,
          ),
          const SizedBox(height: 12),

          // 🗺️ Tombol untuk mencari lokasi donor terdekat
          WideButton(
            label: 'Cari Lokasi Donor Terdekat',
            onPressed: controller.goToMap,
          ),
          const SizedBox(height: 12),

          // 📅 Daftar sesi kunjungan donor (appointment)
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.appointments.length,
              itemBuilder: _buildItem,
            ),
          ),
        ],
      ),
    );
  }
}
