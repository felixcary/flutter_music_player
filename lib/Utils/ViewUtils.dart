class ViewUtils {
  String intToString(int durationSec) {
    var duration = Duration(seconds: durationSec);

    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return '0$n';
    }

    final twoDigitMinutes =
        twoDigits(duration.inMinutes.remainder(Duration.minutesPerHour));
    final twoDigitSeconds =
        twoDigits(duration.inSeconds.remainder(Duration.secondsPerMinute));
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
