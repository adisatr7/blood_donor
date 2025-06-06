import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blood_donor/utils/pdf_helper.dart';
import 'package:blood_donor/controllers/preview_a4_controller.dart';

class PreviewA4View extends StatelessWidget {
  const PreviewA4View({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreviewA4Controller());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview A4 Landscape PDF'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() => questionnairePdfPreviewA4(controller.user.value, controller.appointment.value)), 
    );
  }
}