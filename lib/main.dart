// @dart=2.11

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:standtimer/blocdelegate.dart';
import 'package:standtimer/main_bloc.dart';
import 'package:standtimer/pages/home/bloc/home_bloc.dart';
import 'package:standtimer/pages/home/home.dart';
// import 'file:///C:/code/standtimer/lib/pages/home/home.dart';
import 'package:standtimer/services/database.dart';
import 'package:standtimer/services/preferences.dart';
import 'package:standtimer/widgets/timer/timer.dart';
// import 'package:window_utils/window_utils.dart';

const TIME_MULTIPLIER_FACTOR = kReleaseMode ? 60 : 1;

void main() {
  Bloc.observer = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => PreferencesService()),
        RepositoryProvider(
          create: (context) => DatabaseService(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: BlocProvider(
          create: (context) => MainBloc(
            RepositoryProvider.of<PreferencesService>(context),
            RepositoryProvider.of<DatabaseService>(context),
          )..add(InitServicesEvent()),
          child: BlocBuilder<MainBloc, MainState>(
            builder: (context, state) {
              if (state is ServicesReadyState) {
                return BlocProvider(
                    create: (context) => HomeBloc(
                          RepositoryProvider.of<DatabaseService>(context),
                          RepositoryProvider.of<PreferencesService>(context),
                        )..add(LoadTimersEvent()),
                    child: StandTimerHome());
              }
              return Material(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Initialising..."),
                    CircularProgressIndicator(),
                    Text("Getting set up"),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
