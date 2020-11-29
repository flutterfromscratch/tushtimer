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

  HomeBloc(this._databaseService, this._preferencesService) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    final timers = await _databaseService.timers();
    yield TimersLoadedState(timers, false);

    // TODO: implement mapEventToState
  }
}
