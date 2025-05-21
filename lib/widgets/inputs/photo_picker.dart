import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:blood_donor/core/theme.dart';

class PhotoPicker extends StatelessWidget {
  final String label;
  final Rx<File?> selectedPhoto;
  final double size;

  const PhotoPicker({
    super.key,
    this.label = 'Tekan untuk mengunggah',
    required this.selectedPhoto,
    this.size = 92.0,
  });

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedFile != null) {
      selectedPhoto.value = File(pickedFile.path);
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
          child: Obx(
            () => Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(1000),
                boxShadow: [AppStyles.cardShadow],
                image:
                    selectedPhoto.value != null
                        ? DecorationImage(
                          image: FileImage(selectedPhoto.value!),
                          fit: BoxFit.cover,
                        )
                        : null,
              ),
              child:
                  selectedPhoto.value == null
                      ? Center(
                        child: Icon(
                          Icons.person_rounded,
                          color: AppColors.gray,
                          size: size * 0.6,
                        ),
                      )
                      : null,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: AppTextStyles.bodyGray),
      ],
    );
  }
}
