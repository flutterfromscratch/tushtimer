import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:standtimer/services/database.dart';
import 'package:standtimer/services/preferences.dart';
import 'package:standtimer/widgets/newtimer/newtimer.dart';
import 'package:standtimer/widgets/timer/timer.dart';

import 'bloc/home_bloc.dart';

class StandTimerHome extends StatefulWidget {
  // StandTimerHome() : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  _StandTimerHomeState createState() => _StandTimerHomeState();
}

class _StandTimerHomeState extends State<StandTimerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is TimersLoadedState) {
            if (state.timers.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Add some timers to get started!"),
                    ConstrainedBox(
                      child: Image.asset('assets/bike.png'),
                      constraints: BoxConstraints(maxHeight: 200),
                    ),
                  ],
                ),
              );
            } else {
              return GridView.count(
                crossAxisCount: (MediaQuery.of(context).size.shortestSide / 120)
                    .floor()
                    .clamp(2, 5),
                children: state.timers
                    .map((e) => TimerWidget(
                          timer: e,
                        ))
                    .toList(),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
            child: FloatingActionButton(
              onPressed: () {
                BlocProvider.of<HomeBloc>(context).add(StartTimersEvent());
              },
              child: Icon(Icons.play_arrow),
            ),
          ),
          FloatingActionButton(
            // onPressed: _incrementCounter,
            // tooltip: 'Increment',
            onPressed: () {
              showDialog<void>(
                      builder: (c) => Dialog(child: NewTimerWidget()),
                      context: context)
                  .then((value) => BlocProvider.of<HomeBloc>(context)
                      .add(LoadTimersEvent()));
            },
            child: Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
