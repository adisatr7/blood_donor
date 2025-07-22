import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/constants/appointment_status.dart';
import 'package:blood_donor/widgets/popups/snackbar.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final void Function(int) onTap;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onTap,
  });

  /// Method internal untuk memformat tanggal dan waktu
  /// dari objek [Appointment] menjadi string yang mudah dibaca.
  /// Contoh output: `15 Januari 2025 • 10:00 ~ 12:00`
  String _formatDateTime(Appointment appt) {
    // Pisah antara waktu mulai dan selesai
    final DateTime startTime = appt.location.time.start;
    final DateTime endTime = appt.location.time.end;

    // Format tanggal
    final String date = DateFormat('d MMMM yyyy', 'id_ID').format(startTime);
    // Format jam
    final String startHour = DateFormat('HH:mm').format(startTime);
    final String endHour = DateFormat('HH:mm').format(endTime);

    return '$date • $startHour ~ $endHour';
  }

  /// Method internal untuk mendapatkan style text, digunakan agar kode tidak
  /// kepanjangan dan lebih mudah dibaca
  TextStyle _getStatusTextStyle() {
    return AppTextStyles.bodyBold.copyWith(
      color:
          appointment.statusString == AppointmentStatus.attended
              ? AppColors.success
              : appointment.statusString == AppointmentStatus.scheduled
              ? AppColors.warning
              : AppColors.danger,
    );
  }

    @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [AppStyles.cardShadow],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap(appointment.id);
          },
          onLongPress: () {
            if (appointment.status == 'ATTENDED') {
              showSnackbar(
                title: 'Sudah 60 Hari Sejak Donor Terakhir Anda',
                message: 'Yuk, jadwalkan donor darah Anda!',
              );
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Garis vertikal kiri berwarna sesuai status
                Container(
                  width: 8,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    color: _getStatusTextStyle().color,
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(width: 12), // Jarak antara garis kiri dan text
                // Text group berisi nama lokasi, waktu buka, dan status kunjungan
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama lokasi
                        Text(
                          appointment.location.name,
                          style: AppTextStyles.subheadingBold,
                        ),

                        // Waktu buka
                        Text(
                          _formatDateTime(appointment),
                          style: AppTextStyles.bodyGray,
                        ),

                        // Status kunjungan
                        Text(
                          appointment.statusString,
                          style: _getStatusTextStyle(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
