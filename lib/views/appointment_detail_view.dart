import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/controllers/appointment_detail_controller.dart';
import 'package:blood_donor/widgets/scaffolds/app_scaffold.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:intl/intl.dart';

class AppointmentDetailView extends StatelessWidget {
  final AppointmentDetailController controller = Get.put(AppointmentDetailController());

  AppointmentDetailView({super.key});

  /// Method builder untuk menampilkan informasi umum
  Widget _buildInfoText(String title, String? value) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.bodyGray),
          const SizedBox(height: 2),
          Text(value ?? 'Memuat...', style: AppTextStyles.subheading),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateFormat formatter = DateFormat('dd MMM yyyy', 'id');
    final user = controller.global.currentUser.value;

    return AppScaffold(
      showBackButton: true,
      backButtonLabel: 'Beranda',
      footer: Obx(() {
        // Sembunyikan tombol cetak jika status janji temu 'missed'
        if (!controller.isPrintButtonShown.value) {
          return const SizedBox.shrink();
        }
        // Jika status janji temu bukan 'missed', tampilkan tombol Cetak PDF
        return WideButton(
          label: 'Cetak PDF',
          isLoading: controller.isLoading,
        );
      }),
      child: Obx(() {
        // Jika data appointment masih dimuat dari server, tampilkan animasi loading
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Jika data sudah selesai dimuat, tampilkan datanya
        return Column(
          children: [
            // Logo
            const Center(child: Icon(Icons.bloodtype, size: 100, color: AppColors.primary)),
            const SizedBox(height: 20),

            // Nama lokasi
            Obx(
              () => Text(
                controller.appointment.value?.location.name ?? '',
                style: AppTextStyles.heading,
              ),
            ),
            const SizedBox(height: 4),

            // Waktu donor
            Obx(
              () => Text(
                controller.appointmentDate,
                style: AppTextStyles.subheadingGray,
              ),
            ),
            const SizedBox(height: 26),

            _buildInfoText('Nama Pendonor', user?.name),
            _buildInfoText('Golongan Darah', user?.mergedBloodType),
            _buildInfoText('Tempat/Tanggal Lahir','${user?.birthPlace}, ${formatter.format(user?.birthDate ?? DateTime.now())}'),
            Row(
              children: [
                Expanded(child: _buildInfoText('No. RT', user?.noRt.toString())),
                Expanded(child: _buildInfoText('No. RW', user?.noRw.toString())),
              ],
            ),
            _buildInfoText('Kelurahan/Desa', user?.village),
            _buildInfoText('Kecamatan', user?.district),
            _buildInfoText('Kota/Kabupaten', user?.city),
            _buildInfoText('Provinsi', user?.province),
            _buildInfoText('Pekerjaan', user?.job),
          ],
        );
      }),
    );
  }
}
