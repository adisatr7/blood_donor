import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:blood_donor/core/theme.dart';

class PhotoPicker extends StatelessWidget {
  final String label;
  final Rx<File?> selectedPhoto;
  final RxString initialPhotoUrl;
  final double size;
  final void Function(File?)? onChanged; // <-- Added

  PhotoPicker({
    super.key,
    this.label = 'Tekan untuk mengunggah',
    required this.selectedPhoto,
    RxString? initialPhotoUrl,
    this.size = 92.0,
    this.onChanged,
  }) : initialPhotoUrl = initialPhotoUrl ?? ''.obs;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      selectedPhoto.value = file;
      if (onChanged != null) {
        onChanged!(file);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Obx(() {
            DecorationImage? image;
            if (selectedPhoto.value != null) {
              image = DecorationImage(
                image: FileImage(selectedPhoto.value!),
                fit: BoxFit.cover,
              );
            } else if (initialPhotoUrl.value.isNotEmpty) {
              image = DecorationImage(
                image: NetworkImage(initialPhotoUrl.value),
                fit: BoxFit.cover,
              );
            }

            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(1000),
                boxShadow: [AppStyles.cardShadow],
                image: image,
              ),
              child:
                  (selectedPhoto.value == null && initialPhotoUrl.value.isEmpty)
                      ? Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: AppColors.gray,
                          size: size * 0.6,
                        ),
                      )
                      : null,
            );
          }),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodyGray),
      ],
    );
  }
}
