import 'package:blood_donor/core/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/widgets/buttons/wide_button.dart';

class SelectInput extends StatelessWidget {
  final String label;
  final List<String> options;
  final RxString selectedValue;
  final void Function(String)? onChanged;

  const SelectInput({
    super.key,
    required this.label,
    required this.options,
    required this.selectedValue,
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
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: WideButton(
                      label: options[i],
                      type:
                          selectedValue.value == options[i]
                              ? ButtonType.primary
                              : ButtonType.secondary,
                      onPressed: () {
                        selectedValue.value = options[i];
                        if (onChanged != null) {
                          onChanged!(options[i]);
                        }
                      },
                    ),
                  ),
                ),
                if (i != options.length - 1) const SizedBox(width: 16),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
