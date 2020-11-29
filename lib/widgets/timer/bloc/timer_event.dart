part of 'timer_bloc.dart';

abstract class TimerEvent extends Equatable {
  const TimerEvent();
}

class LoadTimerEvent extends TimerEvent {
  final ActivityTimer timer;

  LoadTimerEvent(this.timer);

  @override
  // TODO: implement props
  List<Object> get props => [timer];
}

class StartTimerEvent extends TimerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StopTimerEvent extends TimerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class TimerTickEvent extends TimerEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
