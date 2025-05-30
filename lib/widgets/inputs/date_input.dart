import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:blood_donor/core/theme.dart';

class DateInput extends StatelessWidget {
  final String label;
  final Rx<DateTime?> selectedDate;
  final String? placeholder;
  final DateTime? firstDate;
  final DateTime? lastDate;

  const DateInput({
    super.key,
    required this.label,
    required this.selectedDate,
    this.placeholder,
    this.firstDate,
    this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label for the date input
        Text(label, style: AppTextStyles.body),

        Obx(
          () => GestureDetector(
            onTap: () async {
              final DateTime now = DateTime.now();
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: selectedDate.value ?? now,
                firstDate: firstDate ?? DateTime(1900),
                lastDate: lastDate ?? DateTime(now.year + 5),
              );
              if (picked != null) {
                selectedDate.value = picked;
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                boxShadow: [AppStyles.cardShadow],
                borderRadius: BorderRadius.circular(5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate.value != null
                          ? formatter.format(selectedDate.value!)
                          : placeholder ?? 'Pilih Tanggal',
                      style:
                          selectedDate.value != null
                              ? AppTextStyles.body
                              : AppTextStyles.bodyGray,
                    ),
                  ),
                  const Icon(Icons.calendar_today, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
