import 'package:get/get.dart';

import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/models/db/questionnaire.dart';
import 'package:blood_donor/constants/questionnaire_list.dart';

class QuestionnaireFormController extends GetxController {
  final Location selectedLocation = Get.arguments as Location;
  final GlobalController global = Get.find<GlobalController>();

  // Daftar jawaban untuk setiap pertanyaan
  List<String> options = ['Ya', 'Tidak'];

  final RxBool isSubmitDisabled = true.obs;
  final RxBool isLoading = false.obs;

  List<QuestionnaireSection> get allQuestionnaireSections => allQuestions.sections;

  /// Method untuk memastikan semua pertanyaan sudah dijawab. Untuk
  /// dipasangkan ke prop `onChanged` pada setiap inputan jawaban
  void validateAnswers(String _) {
    isSubmitDisabled.value = allQuestions.sections.any(
      (section) => section.items.any((item) => item.isNotAnswered),
    );
  }

  /// Method untuk mengirimkan form kuesioner ke server
  Future<void> handleSubmit() async {
    isLoading.value = true;

    // Simulasi pengiriman data ke server
    await Future.delayed(const Duration(seconds: 2));

    // Setelah pengiriman selesai, set loading ke false
    isLoading.value = false;

    // Tampilkan pesan sukses atau navigasi ke halaman lain
    Get.snackbar(
      'Sukses',
      'Form kuesioner berhasil dikirim',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
