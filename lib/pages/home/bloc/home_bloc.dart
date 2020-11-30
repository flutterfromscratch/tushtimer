import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:standtimer/database/database.dart';
import 'package:standtimer/services/database.dart';
import 'package:standtimer/services/preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DatabaseService _databaseService;
  final PreferencesService _preferencesService;

  final timerCoordinator =
      StreamController<GlobalTimerState>.broadcast(onListen: () {
    print('new timer attached');
  });

  HomeBloc(this._databaseService, this._preferencesService)
      : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is LoadTimersEvent) {
      final timers = await _databaseService.timers();
      yield TimersLoadedState(timers, false);
    }
    if (event is DeleteTimerEvent){
      await _databaseService.removeTimer(event.timer.key as int);
      add(LoadTimersEvent());
    }
    if (event is StartTimersEvent){
      timerCoordinator.add(GlobalTimerState.RUNNING);
    }

    // TODO: implement mapEventToState
  }
}

enum GlobalTimerState { RUNNING, PAUSED, RESET }
