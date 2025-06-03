import 'package:get/get.dart';
import 'dart:ui';

import 'package:blood_donor/core/theme.dart';

void showSnackbar({
  required String title,
  required String message,
  SnackPosition position = SnackPosition.TOP,
  Duration duration = const Duration(seconds: 2),
  Color? colorText = AppColors.white,
  Color? backgroundColor = AppColors.black,
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
