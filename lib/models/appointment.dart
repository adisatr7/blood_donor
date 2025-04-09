import 'package:blood_donor/models/user.dart';
import 'package:blood_donor/models/location.dart';
import 'package:blood_donor/enums/appointment_status.dart';

class Appointment {
  final int id;
  final User user;
  final Location location;
  final DateTime time;
  final AppointmentStatus status;

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
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'] as int,
      user: User.fromMap(map['user'] as Map<String, dynamic>),
      location: Location.fromMap(map['location'] as Map<String, dynamic>),
      time: DateTime.parse(map['time'] as String),
      status: AppointmentStatus.values[map['status'] as int],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user.toMap(),
      'location': location.toMap(),
      'time': time.toIso8601String(),
      'status': status.index,
    };
  }
}
