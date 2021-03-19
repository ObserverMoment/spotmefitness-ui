import 'dart:async';

abstract class Utils {
  // https://stackoverflow.com/questions/47776045/is-there-a-good-way-to-write-wait-for-variables-to-change-in-darts-async-meth
  // Completes the future when async test() return true
  // Or bails out after maxAttempts with an error.
  static Future waitWhile(Future<bool> Function() test,
      {Duration pollInterval = Duration.zero, int? maxAttempts}) {
    var completer = new Completer();
    int attempt = 0;
    check() async {
      if (await test()) {
        completer.complete();
      } else {
        attempt++;
        if (maxAttempts != null && attempt > maxAttempts) {
          completer.completeError(Exception(
              'waitWhile: Max attempts reached without receiving a valid response'));
        } else {
          new Timer(pollInterval, check);
        }
      }
    }

    check();
    return completer.future;
  }
}
