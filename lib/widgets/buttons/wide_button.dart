import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/core/theme.dart';

enum ButtonType { primary, secondary }

class WideButton extends StatelessWidget {
  final String? label;
  final VoidCallback? onPressed;
  final ButtonType type;
  final RxBool isLoading;
  final RxBool isDisabled;
  final Icon? leftIcon;

  WideButton({
    super.key,
    this.label,
    this.onPressed,
    this.type = ButtonType.primary,
    RxBool? isLoading,
    RxBool? isDisabled,
    this.leftIcon,
  }) : isLoading = isLoading ?? false.obs,
       isDisabled = isDisabled ?? false.obs;

  @override
  Widget build(BuildContext context) {
    // Tentukan warna latar belakang berdasarkan tipe tombol
    Color bgColor =
        type == ButtonType.primary ? AppColors.primary : AppColors.secondary;

    return SizedBox(
      width: double.infinity, // Supaya tombol melebar sepanjang layar
      child: Obx(
        () => ElevatedButton(
          onPressed: (isLoading.value || isDisabled.value) ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor,
            disabledBackgroundColor: isDisabled.value ? AppColors.gray : bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            elevation: 2,
          ),
          child:
              isLoading.value
                  // Jika sedang loading, tampilkan circular progress indicator
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
                  // Jika tidak, tampilkan teks label (dengan optional leftIcon)
                  : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leftIcon != null) ...[
                        leftIcon!,
                        const SizedBox(width: 8),
                      ],
                      if (label != null)
                        Text(
                          label!,
                          style:
                              type == ButtonType.primary
                                  ? AppTextStyles.bodyWhite
                                  : AppTextStyles.body,
                        ),
                    ],
                  ),
        ),
      ),
    );
  }
}
