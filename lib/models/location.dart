import 'package:blood_donor/models/time_range.dart';

class Location {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final TimeRange time;

  Location({
    this.id = 0,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.time,
  }) {
    if (name.isEmpty) {
      throw ArgumentError('Location name cannot be empty');
    }

    if (latitude < -90 || latitude > 90) {
      throw ArgumentError('Latitude must be between -90 and 90 degrees');
    }

    if (longitude < -180 || longitude > 180) {
      throw ArgumentError('Longitude must be between -180 and 180 degrees');
    }
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'] as int,
      name: map['name'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      time: TimeRange(
        start: DateTime.parse(map['start_time'] as String),
        end: DateTime.parse(map['end_time'] as String),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'start_time': time.startTimeString,
      'end_time': time.endTimeString,
    };
  }
}
