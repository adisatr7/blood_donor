import 'package:blood_donor/models/db/questionnaire.dart';

class CreateAppointmentRequest {
  final int locationId;
  final String status;
  final List<QuestionnaireSection> questionnaireSections;

  CreateAppointmentRequest({
    required this.locationId,
    this.status = 'SCHEDULED',
    required this.questionnaireSections,
  });

  Map<String, dynamic> toMap() {
    return {
      'locationId': locationId,
      'status': status,
      'questionnaireSections':
          questionnaireSections.map((section) {
            return section.toMap();
          }).toList(),
    };
  }
}
