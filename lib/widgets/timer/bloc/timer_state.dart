part of 'timer_bloc.dart';

abstract class TimerState extends Equatable {
  const TimerState();
}

class TimerInitial extends TimerState {
  @override
  List<Object> get props => [];
}

class TimerLoadedState extends TimerState {
  final ActivityTimer timer;
  final TimerPhase phase;
  final int? remainingTime;
  // final int durationRemaining;

  TimerLoadedState(this.timer, this.phase, {this.remainingTime});

  @override
  // TODO: implement props
  List<Object> get props => [timer];
}

enum TimerPhase { ACTIVE, RESTING, PAUSED }
