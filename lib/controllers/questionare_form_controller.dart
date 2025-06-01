import 'package:get/get.dart';

import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/constants/questionnaire.dart';
import 'package:blood_donor/models/db/questionnaire.dart';

class QuestionnaireFormController extends GetxController {
  final Location selectedLocation = Get.arguments as Location;

  List<String> options = ['Ya', 'Tidak'];
  List<Questionnaire> questionnaireForm = questionnaires.obs;
}
