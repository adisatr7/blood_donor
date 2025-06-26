import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/constants/appointment_status.dart';

class Appointment {
  final int id;
  final int userId;
  final Location location;
  final String status;
  final List<AppointmentQuestionnaire> questionnaire;

  Appointment({
    this.id = 0,
    required this.userId,
    required this.location,
    required this.status,
    this.questionnaire = const [],
  }) {
    if (userId <= 0) {
      throw ArgumentError('Invalid user ID');
    }

    if (location.id <= 0) {
      throw ArgumentError('Invalid location ID');
    }

    if (status.isEmpty) {
      throw ArgumentError('Status cannot be empty');
    }
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] ?? 0,
      userId: map['userId'],
      location: Location.fromMap(map['Location']),
      status: map['status'],
      questionnaire: map['Questionnaire'] != null ? _getQuestionnaireList(map['Questionnaire']) : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'location': location.toMap(),
      'status': status,
    };
  }

  String get statusString {
    switch (status) {
      case 'SCHEDULED':
        return AppointmentStatus.scheduled;
      case 'ATTENDED':
        return AppointmentStatus.attended;
      case 'MISSED':
        return AppointmentStatus.missed;
      default:
        return 'ERROR';
    }
  }

  static List<AppointmentQuestionnaire> _getQuestionnaireList(List<dynamic> questionnaireMap) {
    return questionnaireMap
        .map((item) => AppointmentQuestionnaire.fromMap(item))
        .toList();
  }
}

class AppointmentQuestionnaire {
  final int id;
  final int appointmentId;
  final int number;
  final String question;
  final String answer;

  AppointmentQuestionnaire({
    this.id = 0,
    required this.appointmentId,
    required this.number,
    required this.question,
    required this.answer,
  }) {
    if (appointmentId <= 0) {
      throw ArgumentError('Invalid appointment ID');
    }

    if (number <= 0) {
      throw ArgumentError('Invalid question number');
    }

    if (question.isEmpty) {
      throw ArgumentError('Question cannot be empty');
    }

    if (answer.isEmpty) {
      throw ArgumentError('Answer cannot be empty');
    }
  }

  factory AppointmentQuestionnaire.fromMap(Map<String, dynamic> map) {
    return AppointmentQuestionnaire(
      id: map['id'] as int? ?? 0,
      appointmentId: map['appointmentId'] as int,
      number: map['number'] as int,
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointmentId': appointmentId,
      'number': number,
      'question': question,
      'answer': answer,
    };
  }

  bool get isYes {
    return answer.toLowerCase() == 'ya';
  }

  bool get isNo {
    return answer.toLowerCase() == 'tidak';
  }
}
