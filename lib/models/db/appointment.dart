import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/constants/appointment_status.dart';

class Appointment {
  final int id;
  final int userId;
  final Location location;
  final String status;

  Appointment({
    this.id = 0,
    required this.userId,
    required this.location,
    required this.status,
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
      id: map['id'] as int? ?? 0,
      userId: map['userId'] as int,
      location: Location.fromMap(map['Location'] as Map<String, dynamic>),
      status: map['status'] as String,
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
}
