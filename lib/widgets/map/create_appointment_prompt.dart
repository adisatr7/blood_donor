import 'package:flutter/material.dart';

import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class CreateAppointmentPrompt extends StatelessWidget {
  final Location location;
  final void Function(Location) onCreateAppointment;

  const CreateAppointmentPrompt({
    super.key,
    required this.location,
    required this.onCreateAppointment,
  });

  /// Method internal untuk memformat waktu ke dalam format HH:mm
  String _formatTime(int hour, int minute) {
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    // Siapkan text jam buka lokasi
    final String startHour = _formatTime(
      location.time.start.hour,
      location.time.start.minute,
    );

    // Siapkan text jam tutup lokasi
    final String endHour = _formatTime(
      location.time.end.hour,
      location.time.end.minute,
    );

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nama lokasi
          Text(location.name, style: AppTextStyles.subheading),

          // Jam buka lokasi
          Text(
            'Jam buka: $startHour - $endHour',
            style: AppTextStyles.bodyGray,
          ),
          const SizedBox(height: 10),

          // Tombol untuk membuat janji
          WideButton(
            label: 'Buat Janji',
            onPressed: () {
              onCreateAppointment(location);
            },
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
