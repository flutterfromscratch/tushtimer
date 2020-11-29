import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:standtimer/database/database.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late Timer? _timer;

  TimerBloc() : super(TimerInitial());

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is LoadTimerEvent) {
      yield TimerLoadedState(event.timer, TimerPhase.PAUSED);
    }
    if (event is StartTimerEvent) {
      _timer?.cancel();
      _timer = Timer(Duration(seconds: 1), () {
        add(TimerTickEvent());
      });
    }
    if (event is TimerTickEvent) {
      if (state is TimerLoadedState) {
        final timerState = state as TimerLoadedState;
        if (timerState.remainingTime == 0) {
          if (timerState.phase == TimerPhase.ACTIVE) {
            // switching from active to resting phase
            yield TimerLoadedState(timerState.timer, TimerPhase.RESTING);
          } else if (timerState.phase == TimerPhase.RESTING) {
            if (timerState.timer.automaticRepeat) {
              _timer?.cancel();
              _timer = Timer(Duration(seconds: 1), () {
                add(TimerTickEvent());
              });
            } else {
              _timer?.cancel();
            }
          }
        } else {
          yield TimerLoadedState(timerState.timer, timerState.phase,
              remainingTime: timerState.remainingTime == null ? timerState.timer.intervalDurationMinutes * 60 : timerState.remainingTime! - 1);
        }

        // yield(TimerLoadedState())
      }
    }
    if (event is StopTimerEvent) _timer?.cancel();
    // TODO: implement mapEventToState
  }
}
