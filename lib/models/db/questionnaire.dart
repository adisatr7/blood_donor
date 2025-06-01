import 'package:get/get.dart';

class Questionnaire {
  final List<QuestionnaireSection> sections;

  Questionnaire({required this.sections});

  /// Method untuk mengambil semua jawaban dari semua kuesioner.
  List<String> get getAllAnswers {
    return sections.expand((section) => section.allAnswers).toList();
  }
}

/// Model untuk menyimpan data dari setiap bab (section) kuesioner.
/// Setiap bab memiliki judul, nomor bab, dan daftar item pertanyaan.
class QuestionnaireSection {
  /// Judul bab
  String title;

  /// Nomor bab
  int sectionNumber;

  /// Daftar item pertanyaan dalam bab ini
  List<QuestionnaireSectionItem> items;

  QuestionnaireSection({
    required this.title,
    required this.sectionNumber,
    this.items = const [],
  });

  /// Ambil semua jawaban dari soal-soal dalam bab ini.
  List<String> get allAnswers =>
      items.map((item) => item.answer.value).toList();

  /// Cek apakah semua pertanyaan dalam bab ini sudah dijawab.
  bool get isAllAnswered {
    return items.every((item) => item.isAnswered);
  }
}

/// Model untuk menyimpan data dari setiap item pertanyaan dalam kuesioner.
/// Setiap item memiliki nomor, pertanyaan, dan jawaban yang dapat diubah.
class QuestionnaireSectionItem {
  int itemNumber;
  String question;
  RxString answer = ''.obs;

  QuestionnaireSectionItem({required this.itemNumber, required this.question});

  /// Getter untuk mengambil nomor dan soal pertanyaan dalam format yang mudah dibaca.
  String get questionText => '$itemNumber. $question';

  /// Cek apakah pertanyaan ini sudah dijawab.
  bool get isAnswered => answer.value.isNotEmpty;

  /// Cek apakah pertanyaan ini belum dijawab.
  bool get isNotAnswered => answer.value.isEmpty;

  /// Cek apakah jawaban adalah 'Ya' atau 'Tidak'.
  bool get isYes => answer.value == 'Ya';

  /// Cek apakah jawaban adalah 'Tidak'.
  bool get isNo => answer.value == 'Tidak';
}
