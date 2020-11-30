import 'dart:async';
//You need to import this
import 'package:async/async.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:standtimer/database/database.dart';
import 'package:standtimer/main.dart';
import 'package:standtimer/pages/home/bloc/home_bloc.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late RestartableTimer? _timer;
  // final _timer = RestartableTimer(Duration(seconds: 1), timerTickCallback);
  // final ActivityTimer _activityTimer;
  final Stream<GlobalTimerState> _globalTimerState;

  TimerBloc(this._globalTimerState) : super(TimerInitial()) {
    _globalTimerState.listen((event) {
      if (event == GlobalTimerState.RUNNING) {
        print('timer received event');
        add(StartTimerEvent());
      }
    });
  }

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is LoadTimerEvent) {
      yield TimerLoadedState(event.timer, TimerPhase.PAUSED,
          remainingTime:
              event.timer.intervalDurationMinutes * TIME_MULTIPLIER_FACTOR);
    }
    if (event is StartTimerEvent) {
      print('starting timer...');
      // yield TimerLoadedState(event);
      // _timer.reset();
      // _timer?.cancel();
      _timer = RestartableTimer(Duration(seconds: 1), () {
        add(TimerTickEvent());
      });
    }
    if (event is TimerTickEvent) {
      print('timer tick event');
      if (state is TimerLoadedState) {
        final timerState = state as TimerLoadedState;
        if (timerState.phase == TimerPhase.PAUSED) {
          yield TimerLoadedState(timerState.timer, TimerPhase.ACTIVE,
              remainingTime: timerState.timer.intervalDurationMinutes *
                  TIME_MULTIPLIER_FACTOR);
        } else if (timerState.remainingTime == 0) {
          if (timerState.phase == TimerPhase.ACTIVE) {
            // switching from active to resting phase
            yield TimerLoadedState(timerState.timer, TimerPhase.RESTING,
                remainingTime: timerState.timer.restDurationSeconds);
          } else if (timerState.phase == TimerPhase.RESTING) {
            if (timerState.timer.automaticRepeat) {
              yield TimerLoadedState(timerState.timer, TimerPhase.ACTIVE,
                  remainingTime: timerState.timer.intervalDurationMinutes *
                      TIME_MULTIPLIER_FACTOR);
              _timer?.cancel();
              _timer = RestartableTimer(Duration(seconds: 1), () {
                add(TimerTickEvent());
              });
            } else {
              _timer?.cancel();
            }
          }
        } else {
          yield TimerLoadedState(timerState.timer, timerState.phase,
              remainingTime: timerState.remainingTime! - 1);
          print(timerState.remainingTime);
        }
        _timer?.reset();

        // yield(TimerLoadedState())
      }
    }
    if (event is StopTimerEvent) _timer?.cancel();
    // TODO: implement mapEventToState
  }
}
