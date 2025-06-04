import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import 'package:blood_donor/core/theme.dart';

void showAppDialog({
  required String title,
  required String message,
  String confirmText = 'Tutup',
  VoidCallback? onConfirm,
  String? cancelText,
  VoidCallback? onCancel,
}) {
  // Menampilkan dialog menggunakan Get.dialog
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
            // Menampilkan judul dialog
            Text(
              title,
              style: AppTextStyles.subheadingBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            // Menampilkan pesan dialog
            Text(
              message,
              style: AppTextStyles.bodyGray,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),

            // Garis pemisah antara pesan dan tombol
            const Divider(height: 1, color: AppColors.secondary),

            // Menampilkan tombol aksi (bisa 1 atau 2 tombol)
            if (cancelText != null)
              Row(
                children: [
                  // Tombol batal
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(14),
                      ),
                      onTap: () {
                        Get.back();
                        onCancel?.call();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Text(cancelText, style: AppTextStyles.body),
                      ),
                    ),
                  ),
                  // Garis pemisah vertikal antara tombol
                  Container(
                    width: 1,
                    height: 48,
                    color: AppColors.secondary,
                  ),
                  // Tombol konfirmasi
                  Expanded(
                    child: InkWell(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(14),
                      ),
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
                  ),
                ],
              )
            else
              // Jika hanya ada tombol konfirmasi
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
