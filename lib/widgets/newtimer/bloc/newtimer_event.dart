// @dart=2.11

part of 'newtimer_bloc.dart';

abstract class NewtimerEvent extends Equatable {
  const NewtimerEvent();
}

class UpdateTimerEvent extends NewtimerEvent {
  final Color color;
  final String name;
  final int duration;
  final bool automaticRepeat;
  final int restDuration;

  UpdateTimerEvent(this.color, this.name, this.duration, this.automaticRepeat, this.restDuration);

  @override
  // TODO: implement props
  List<Object> get props => [color, name, duration, automaticRepeat, restDuration];
}

class SaveTimerEvent extends UpdateTimerEvent {
  SaveTimerEvent(
    Color color,
    String name,
    int duration,
    bool automaticRepeat,
    int restDuration,
  ) : super(
          color,
          name,
          duration,
          automaticRepeat,
          restDuration,
        );
  // final String name;
  // final Color color;
  // final int duration;
  // final bool automaticRepeat;
  // final int restDuration;
  //
  // SaveTimerEvent(this.name, this.color, this.duration, this.automaticRepeat, this.restDuration);
  //
  // @override
  // // TODO: implement props
  // List<Object> get props => [name, color, duration, automaticRepeat];
}
