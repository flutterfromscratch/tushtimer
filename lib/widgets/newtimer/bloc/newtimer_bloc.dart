// @dart=2.11

import 'dart:async';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:standtimer/database/database.dart';
import 'package:standtimer/services/database.dart';

part 'newtimer_event.dart';
part 'newtimer_state.dart';

class NewtimerBloc extends Bloc<NewtimerEvent, NewtimerState> {
  final DatabaseService _databaseService;

  NewtimerBloc(this._databaseService) : super(NewtimerInitial('', Colors.green, 15, 10, false));

  @override
  Stream<NewtimerState> mapEventToState(
    NewtimerEvent event,
  ) async* {
    if (event is UpdateTimerEvent) {
      yield NewtimerInitial(
        event.name,
        event.color,
        event.duration,
        event.restDuration,
        event.automaticRepeat,
      );
    }
    if (event is SaveTimerEvent) {
      await _databaseService.addTimer(ActivityTimer(
          name: event.name,
          automaticRepeat: event.automaticRepeat,
          intervalDurationMinutes: event.duration,
          restDurationSeconds: event.restDuration,
          color: event.color));
    }
    // TODO: implement mapEventToState
  }
}
