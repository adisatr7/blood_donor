import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/core/theme.dart';

class AppBackButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool elevated;

  const AppBackButton({
    super.key,
    this.label = 'Kembali',
    this.onPressed,
    this.elevated = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget button;

    if (label.isNotEmpty) {
      // Jika ada label, gunakan TextButton dengan ikon
      button = TextButton.icon(
        onPressed: onPressed ?? Get.back,
        icon: const Icon(Icons.arrow_back_ios_rounded),
        label: Text(label, style: AppTextStyles.body),
      );
    } else {
      // Jika tidak ada label, gunakan IconButton
      button = IconButton(
        onPressed: onPressed ?? Get.back,
        icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
      );
    }

    // Jika prop `elevated` bernilai true, bungkus dengan Container untuk menampilkan efek melayang
    if (elevated) {
      button = Container(
        decoration: BoxDecoration(
          color: AppColors.secondary, // Warna latar belakang diatur
          borderRadius: BorderRadius.circular(8), // Efek sudut melingkar
          boxShadow: [AppStyles.cardShadow], // Efek melayang (bayangan) diatur
        ),
        height: 52, // Tinggi disamakan dengan tinggi widget TextInput
        child: button,
      );
    }

    return button;
  }
}
