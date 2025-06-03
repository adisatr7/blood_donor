import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:blood_donor/core/theme.dart';

void showSnackbar({
  required String title,
  required String message,
  SnackPosition position = SnackPosition.TOP,
  Duration duration = const Duration(seconds: 2),
  Color? colorText = AppColors.black,
  Color? backgroundColor = AppColors.white,
}) {
  Get.snackbar(
    title,
    message,
    snackPosition: position,
    duration: duration,
    colorText: colorText,
    backgroundColor: backgroundColor,
    boxShadows: [AppStyles.cardShadow],
  );
}
