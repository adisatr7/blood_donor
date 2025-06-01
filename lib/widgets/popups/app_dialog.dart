import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/core/theme.dart';

void showAppDialog({
  required String title,
  required String message,
  String confirmText = 'Tutup',
  VoidCallback? onConfirm,
}) {
  Get.dialog(
    Dialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 40),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Text: Title
            Text(
              title,
              style: AppTextStyles.subheading,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Text: Message
            Text(
              message,
              style: AppTextStyles.bodyGray,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Button: Close
            const Divider(height: 1, color: AppColors.secondary),
            InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: () {
                Get.back();
                onConfirm?.call();
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Text(confirmText, style: AppTextStyles.bodyBoldPrimary),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

/// Method untuk menampilkan dialog error
void showAppError(String title, Exception e) {
  showAppDialog(
    title: title, // Judul pesan error
    message:
        (e is DioException && e.response != null)
            ? e.response!.data['error'] // Handle error berkaitan dengan API
            : e.toString(), // Handle error umum
  );
}
