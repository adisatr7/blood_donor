const int minWaitMilliseconds = 0;
const int maxWaitMilliseconds = 2000;

/// Simulate a wait time of 0 to 2 seconds
Future<void> simulateWait() async {
  final duration = Duration(
    milliseconds:
        (minWaitMilliseconds +
                (maxWaitMilliseconds - minWaitMilliseconds) *
                    (DateTime.now().millisecondsSinceEpoch % 1000) /
                    1000)
            .toInt(),
  );

  await Future.delayed(duration);
}
