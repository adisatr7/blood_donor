import 'package:get/get.dart';

class Questionnaire {
  String title;
  int sectionNumber;
  List<QuestionnaireItem> items;

  Questionnaire({
    required this.title,
    required this.sectionNumber,
    this.items = const [],
  });

  /// Returns a list of all answers in the subsection.
  List<String> get answers => items.map((item) => item.answer.value).toList();

  /// Returns a list of all answers from all list of questionnaires.
  static List<String> getAllAnswers(List<Questionnaire> questionnaires) {
    return questionnaires
        .expand((questionnaire) => questionnaire.answers)
        .toList();
  }

  /// Checks if all items in the questionnaire are answered.
  static RxBool isAllAnswered(List<Questionnaire> questionnaires) {
    return (questionnaires
        .every((questionnaire) => questionnaire.items.every((item) => item.isAnswered)))
        .obs;
  }
}

class QuestionnaireItem {
  int itemNumber;
  String question;
  RxString answer = ''.obs;

  QuestionnaireItem({
    required this.itemNumber,
    required this.question,
  });

  String get questionText => '$itemNumber. $question';

  bool get isAnswered => answer.value.isNotEmpty;
  bool get isNotAnswered => answer.value.isEmpty;
  bool get isYes => answer.value == 'Ya';
  bool get isNo => answer.value == 'Tidak';
}
