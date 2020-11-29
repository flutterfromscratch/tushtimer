import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'database.g.dart';

// Future<void> init() async {
//   await Hive.initFlutter();
// }

@HiveType(typeId: 1)
class ActivityTimer extends HiveObject {
  @HiveField(0)
  final String name;
  @HiveField(2)
  final int intervalDurationMinutes;
  @HiveField(3)
  final int restDurationSeconds;
  @HiveField(4)
  final bool automaticRepeat;
  @HiveField(5)
  final Color color;

  ActivityTimer(
      {required this.name,
      required this.intervalDurationMinutes,
      required this.restDurationSeconds,
      required this.automaticRepeat,
      required this.color});
}
