import 'package:blood_donor/constants/questionnaire.dart';
import 'package:blood_donor/models/questionnaire.dart';
import 'package:get/get.dart';

class QuestionnaireFormController extends GetxController {
  List<String> options = ['Ya', 'Tidak'];

  List<Questionnaire> questionnaireForm = questionnaires.obs;
}
