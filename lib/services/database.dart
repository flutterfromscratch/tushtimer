// @dart=2.11

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:standtimer/database/color.dart';
import 'package:standtimer/database/database.dart';

class DatabaseService {
  Box<ActivityTimer> _timerBox;

  // DatabaseService() {
  //   Hive.openBox<Timer>('timer').then((value) => _timerBox = value);
  // }
  // late Stream<BoxEvent> timerSubscription;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Color>(ColorAdapter());
    Hive.registerAdapter<ActivityTimer>(ActivityTimerAdapter());
    _timerBox = await Hive.openBox<ActivityTimer>('timer');

    // _timerBox = await Hive.openBox<Timer>('timer');
    // timerSubscription = _timerBox.watch();
    // timerSubscription = _timerBox.watch();
    // timerSubscription.listen((event) {event.})
    // await Hive.ini
  }

  Future addTimer(final ActivityTimer timer) async {
    await _timerBox.add(timer);
  }

  Future removeTimer(final int timerId) async {
    await _timerBox.deleteAt(timerId);
    // _timerBox.watch()
  }

  Future<List<ActivityTimer>> timers() async => _timerBox.values.toList(growable: false);
}
