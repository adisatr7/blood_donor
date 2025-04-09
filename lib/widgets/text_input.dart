import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/core/theme.dart';

class TextInput extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final String? placeholder;

  const TextInput({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final RxBool obscureText = isPassword.obs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label for the text field
        Text(label, style: AppTextStyles.body),
        const SizedBox(height: 8),

        // Textbox container
        Container(
          decoration: BoxDecoration(
            color: AppColors.secondary,
            boxShadow: [AppStyles.cardShadow],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 4, 0),
            // The actual text input handler
            child: Obx(
              () => TextField(
                controller: controller,
                obscureText: obscureText.value,
                style: AppTextStyles.body,
                textAlignVertical: isPassword ? TextAlignVertical.center : null,
                decoration: InputDecoration(
                  fillColor: AppColors.secondary,
                  border: InputBorder.none,
                  hintText: placeholder,
                  hintStyle: AppTextStyles.bodyGray,

                  // Button to toggle password visibility (only visible if `isPassword` prop is true)
                  suffixIcon:
                      isPassword
                          ? IconButton(
                            icon: Icon(
                              obscureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              obscureText.toggle();
                            },
                          )
                          : null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
