// @dart=2.11

part of 'newtimer_bloc.dart';

abstract class NewtimerState extends Equatable {
  const NewtimerState();
}

class NewtimerInitial extends NewtimerState {
  final String name;
  final Color color;
  final int duration;
  final int restDuration;
  final bool autoRepeats;

  NewtimerInitial(this.name, this.color, this.duration, this.restDuration, this.autoRepeats);
  @override
  List<Object> get props => [name, color, duration, restDuration, autoRepeats];
}
