import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:standtimer/services/database.dart';
import 'package:standtimer/services/preferences.dart';

part 'main_event.dart';
part 'main_state.dart';

// import 'package:standtimer/database/database.dart' as database;

class MainBloc extends Bloc<MainEvent, MainState> {
  final PreferencesService _preferencesService;
  final DatabaseService _databaseService;

  MainBloc(this._preferencesService, this._databaseService) : super(MainInitial());

  @override
  Stream<MainState> mapEventToState(
    MainEvent event,
  ) async* {
    if (event is InitServicesEvent) {
      await _preferencesService.init();
      await _databaseService.init();
      yield ServicesReadyState();
    }
    // TODO: implement mapEventToState
  }
}
