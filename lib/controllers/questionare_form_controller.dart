import 'package:get/get.dart';

import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/controllers/global_controller.dart';
import 'package:blood_donor/services/appointment_service.dart';
import 'package:blood_donor/models/db/questionnaire.dart';
import 'package:blood_donor/constants/questionnaire_list.dart';
import 'package:blood_donor/models/api/create_appointment_request.dart';
import 'package:blood_donor/core/app_routes.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';
import 'package:blood_donor/core/theme.dart';

class QuestionnaireFormController extends GetxController {
  final Location selectedLocation = Get.arguments as Location;
  final GlobalController global = Get.find<GlobalController>();
  final AppointmentService _appointmentService = AppointmentService.instance;

  // Daftar jawaban untuk setiap pertanyaan
  List<String> options = ['Ya', 'Tidak'];

  final RxBool isSubmitDisabled = true.obs;
  final RxBool isLoading = false.obs;

  List<QuestionnaireSection> get allQuestionnaireSections =>
      allQuestions.sections;

  /// Method untuk memastikan semua pertanyaan sudah dijawab. Untuk
  /// dipasangkan ke prop `onChanged` pada setiap inputan jawaban
  void validateAnswers(String _) {
    isSubmitDisabled.value = allQuestions.sections.any(
      (section) => section.items.any((item) => item.isNotAnswered),
    );
  }

  /// Method untuk mengirimkan form kuesioner ke server
  Future<void> handleSubmit() async {
    try {
      // Mulai animasi loading
      isLoading.value = true;

      // Siapkan request payload
      final CreateAppointmentRequest request = CreateAppointmentRequest(
        locationId: selectedLocation.id,
        status: 'SCHEDULED',
        questionnaireSections: allQuestions.sections,
      );

      // Tampilkan dialog konfirmasi sebelum mengirim
      await _appointmentService.create(request);

      // Kembalikan user ke halaman beranda (Home)
      Get.offAllNamed(AppRoutes.home);

      // Tampilkan pesan sukses atau navigasi ke halaman lain
      Get.snackbar(
        'Sukses',
        'Form kuesioner berhasil dikirim',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 2),
        colorText: AppColors.black,
        backgroundColor: AppColors.white,
        boxShadows: [AppStyles.cardShadow],
      );
    } on Exception catch (e) {
      // Tampilkan pesan kesalahan
      showAppError('Terjadi Kesalahan', e);
    } finally {
      // Hentikan animasi loading
      isLoading.value = false;
    }
  }
}
