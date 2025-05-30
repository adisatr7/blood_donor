import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/core/theme.dart';

class Dropdown extends StatelessWidget {
  final String label;
  final RxString? selectedValue;
  final List<String> options;
  final String? placeholder;
  final ValueChanged<String>? onChanged;

  const Dropdown({
    super.key,
    required this.label,
    required this.selectedValue,
    required this.options,
    this.placeholder,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label for the dropdown field
        Text(label, style: AppTextStyles.body),

        // Dropdown container
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            boxShadow: [AppStyles.cardShadow],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
            child: Obx(
              () => DropdownButtonFormField<String>(
                value:
                    selectedValue?.value.isNotEmpty == true
                        ? selectedValue!.value
                        : null,
                decoration: InputDecoration(
                  fillColor: AppColors.secondary,
                  border: InputBorder.none,
                  hintText: placeholder ?? 'Select an option',
                  hintStyle: AppTextStyles.bodyGray,
                ),
                onChanged: (String? newValue) {
                  if (newValue == null) {
                    return;
                  }
                  if (selectedValue != null) {
                    selectedValue!.value = newValue;
                  }
                  if (onChanged != null) {
                    onChanged!(newValue);
                  }
                },
                items:
                    options.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: AppTextStyles.body),
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
