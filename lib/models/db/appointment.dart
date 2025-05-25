import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/models/db/location.dart';
import 'package:blood_donor/constants/appointment_status.dart';

class Appointment {
  final int id;
  final User user;
  final Location location;
  final DateTime time;
  final String status;

  Appointment({
    this.id = 0,
    required this.user,
    required this.location,
    required this.time,
    required this.status,
  }) {
    if (time.isBefore(DateTime.now())) {
      throw ArgumentError('Appointment time cannot be in the past');
    }

    if (user.id <= 0) {
      throw ArgumentError('Invalid user ID');
    }

    if (location.id <= 0) {
      throw ArgumentError('Invalid location ID');
    }

    if (status.isEmpty) {
      throw ArgumentError('Status cannot be empty');
    }

    if (status != AppointmentStatus.scheduled &&
        status != AppointmentStatus.attended &&
        status != AppointmentStatus.missed) {
      throw ArgumentError('Invalid appointment status');
    }
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    // Validate the map before creating an Appointment object
    if (map['id'] == null) {
      throw ArgumentError('ID cannot be null');
    }
    if (map['user'] == null || map['location'] == null) {
      throw ArgumentError('User or location cannot be null');
    }
    if (map['time'] == null || map['status'] == null) {
      throw ArgumentError('Time or status cannot be null');
    }

    // Validate status values
    if (map['status'] != AppointmentStatus.scheduled &&
        map['status'] != AppointmentStatus.attended &&
        map['status'] != AppointmentStatus.missed) {
      throw ArgumentError('Invalid appointment status');
    }

    return Appointment(
      id: map['id'] as int,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      time: DateTime.parse(map['time'] as String),
      status: map['status'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'location': location.toMap(),
      'time': time.toIso8601String(),
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
