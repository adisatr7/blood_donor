class TimeRange {
  final DateTime start;
  final DateTime end;

  /// Constructor for TimeRange, which takes two DateTime objects
  TimeRange({required this.start, required this.end}) {
    // Check if the start and end times are valid
    if (start.hour < 0 ||
        start.hour > 23 ||
        start.minute < 0 ||
        start.minute > 59) {
      throw ArgumentError('Start time is out of range (00:00 - 23:59)');
    }
    if (end.hour < 0 || end.hour > 23 || end.minute < 0 || end.minute > 59) {
      throw ArgumentError('End time is out of range (00:00 - 23:59)');
    }
    if (start.isAfter(end)) {
      throw ArgumentError('Start time cannot be after end time');
    }
  }

  /// Create a TimeRange from two Strings. Uses 24-hour format (HH:mm).
  factory TimeRange.fromStrings({
    required String startTime,
    required String endTime,
  }) {
    // Parse the time strings into DateTime objects
    final start = DateTime.parse(startTime);
    final end = DateTime.parse(endTime);

    // Use regex to validate the time format
    final timeRegex = RegExp(r'^(0[0-9]|1[0-9]|2[0-3]):([0-5][0-9])$');
    if (!timeRegex.hasMatch(startTime) || !timeRegex.hasMatch(endTime)) {
      throw ArgumentError('Time format must be HH:mm (00:00 - 23:59)');
    }

    // Check if the start and end times are valid
    if (start.isAfter(end)) {
      throw ArgumentError('Start time cannot be after end time');
    }

    return TimeRange(start: start, end: end);
  }

  /// Check if this TimeRange overlaps with another TimeRange
  bool overlapsWith(TimeRange other) {
    return start.isBefore(other.end) && end.isAfter(other.start);
  }

  /// Get the start time in HH:mm format
  String get startTimeString {
    return '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}';
  }

  /// Get the end time in HH:mm format
  String get endTimeString {
    return '${end.hour.toString().padLeft(2, '0')}:${end.minute.toString().padLeft(2, '0')}';
  }
}
