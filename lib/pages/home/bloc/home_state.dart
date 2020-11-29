part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class TimersLoadedState extends HomeState {
  final List<ActivityTimer> timers;
  final bool running;

  TimersLoadedState(this.timers, this.running);

  @override
  // TODO: implement props
  List<Object> get props => [timers, running];
}
