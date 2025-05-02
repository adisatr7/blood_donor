import 'package:blood_donor/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class SelectInput extends StatelessWidget {
  final String label;
  final List<String> options;
  final RxString selectedValue;
  final bool allowDeselect;
  final void Function(String)? onChanged;

  const SelectInput({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
    this.allowDeselect = false,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text label
          Text(label, style: AppTextStyles.body),

          // Actual select input
          Row(
            children: [
              for (int i = 0; i < options.length; i++) ...[
                Expanded(
                  child: WideButton(
                    label: options[i],
                    type:
                        selectedValue.value == options[i]
                            ? ButtonType.primary
                            : ButtonType.secondary,
                    onPressed: () {
                      // Toggle selection based on allowDeselect
                      if (selectedValue.value == options[i] && allowDeselect) {
                        selectedValue.value = '';
                      } else {
                        selectedValue.value = options[i];
                      }

                      // Trigger onChanged callback if provided
                      if (onChanged != null) {
                        onChanged!(selectedValue.value);
                      }
                    },
                  ),
                ),
                if (i != options.length - 1) const SizedBox(width: 16),
              ],
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
