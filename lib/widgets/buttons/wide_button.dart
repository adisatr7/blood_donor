import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/core/theme.dart';

enum ButtonType { primary, secondary }

class WideButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final RxBool isLoading;

  WideButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = ButtonType.primary,
    RxBool? isLoading,
  }) : isLoading = isLoading ?? false.obs;

  @override
  Widget build(BuildContext context) {
    // Determine the background color based on the button type
    Color bgColor =
        type == ButtonType.primary ? AppColors.primary : AppColors.secondary;

    return SizedBox(
      width: double.infinity, // To stretch the button across the screen
      child: Obx(
        () => ElevatedButton(
          onPressed: isLoading.value ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            disabledBackgroundColor: bgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2,
          ),
          child:
              isLoading.value
                  // If loading, show a circular progress indicator
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color:
                          type == ButtonType.primary
                              ? AppColors.white
                              : AppColors.black,
                      strokeWidth: 2,
                    ),
                  )
                  // Otherwise, show the text label
                  : Text(
                    label,
                    style:
                        type == ButtonType.primary
                            ? AppTextStyles.bodyWhite
                            : AppTextStyles.body,
                  ),
        ),
      ),
    );
  }
}
