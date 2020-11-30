part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class LoadTimersEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeleteTimerEvent extends HomeEvent {
  final ActivityTimer timer;

  DeleteTimerEvent(this.timer);

  @override
  // TODO: implement props
  List<Object> get props => [timer];
}

class StartTimersEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class StopTimersEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
