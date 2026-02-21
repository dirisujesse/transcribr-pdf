import 'dart:math';

import 'extensions.dart';

extension NumExtension on num {
  double get asDeg {
    return this * (180 / pi);
  }

  Duration get microseconds {
    return Duration(microseconds: toInt());
  }

  Duration get milliseconds {
    return Duration(milliseconds: toInt());
  }

  Duration get seconds {
    return Duration(seconds: toInt());
  }

  Duration get minutes {
    return Duration(minutes: toInt());
  }

  Duration get hours {
    return Duration(hours: toInt());
  }

  Duration get days {
    return Duration(days: toInt());
  }

  double get asCents => this * 100;
  double get asDollars => this / 100;
  String get asPercentage => asCents.toStringAsFixed(0);

  String get timeCode {
    final duration = "$seconds".split(".").tryFirst;
    final sections = duration?.split(":") ?? List.generate(3, (_) => "0");
    final [hour, min, sec] = [
      num.tryParse(sections[0]) ?? 0,
      num.tryParse(sections[1]) ?? 0,
      num.tryParse(sections[2]) ?? 0,
    ];
    final fomattedMin = min < 10 ? "0$min" : "$min";
    final fomattedHour = hour < 10 ? "0$hour" : "$hour";
    final fomattedSec = sec < 10 ? "0$sec" : "$sec";

    var timeCode = "$fomattedMin:$fomattedSec";

    if (hour > 0) timeCode = "$fomattedHour:$timeCode";

    return timeCode;
  }
}

extension IntExtension on int {
  List<int> get monthDays {
    final daysInMonth = switch (this) {
      DateTime.february => 29,
      DateTime.september | DateTime.april | DateTime.june | DateTime.november =>
        30,
      _ => 31,
    };
    return List.generate(daysInMonth, (index) => index + 1, growable: false);
  }
}

int randomInt() {
  return Random().nextInt(10000);
}
