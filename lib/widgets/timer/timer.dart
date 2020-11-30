import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:standtimer/database/database.dart';
import 'package:standtimer/main.dart';
import 'package:standtimer/pages/home/bloc/home_bloc.dart';
import 'package:standtimer/services/database.dart';
import 'package:standtimer/widgets/timer/bloc/timer_bloc.dart';

class TimerWidget extends StatelessWidget {
  // final DatabaseService _databaseService;

  final ActivityTimer timer;

  const TimerWidget({Key? key, required this.timer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          TimerBloc(BlocProvider.of<HomeBloc>(context).timerCoordinator.stream)
            ..add(LoadTimerEvent(timer)),
      // create: ,
      child: BlocConsumer<TimerBloc, TimerState>(listener: (context, state) {
        if (state is DeleteTimerState) {
          // send the instruction to the parent bloc to delete this timer
          BlocProvider.of<HomeBloc>(context).add(DeleteTimerEvent(timer));
        }
      }, builder: (context, state) {
        if (state is TimerLoadedState) {
          return Card(
            child: AnimatedContainer(
              curve: Curves.easeInOutCubic,
              duration: Duration(seconds: 1),
              color: state.phase == TimerPhase.ACTIVE
                  ? state.timer.color
                  : state.phase == TimerPhase.RESTING
                      ? Theme.of(context).cardTheme.color
                      : Colors.white24,
              padding: EdgeInsets.all(20),
              child: Column(
                // Key(state.phase.toString()),
                key: Key(state.phase.toString()),
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        AspectRatio(
                          aspectRatio: 1,
                          child: Transform.rotate(
                              angle: 9.5,
                              child: CircularProgressIndicator(
                                value: calculateProgress(state),
                                // backgroundColor:
                                //     state.phase == TimerPhase.ACTIVE
                                //         ? state.timer.color
                                //         : Theme.of(context).primaryColor,
                              )),
                        ),
                        Center(child: Text(state.timer.name)),
                        FloatingActionButton(
                          child: Icon(Icons.remove),
                          mini: true,
                          clipBehavior: Clip.antiAlias,
                          onPressed: () {
                            BlocProvider.of<HomeBloc>(context)
                                .add(DeleteTimerEvent(timer));
                          },
                        ),
                      ],
                    ),
                  ),
                  // Text(state.timer.name)
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      }),
    );
  }
}

double calculateProgress(TimerLoadedState state) {
  // if (state.phase == TimerPhase.ACTIVE) {
  if (state.remainingTime == null) {
    return 1;
  } else if (state.phase == TimerPhase.ACTIVE) {
    final remainingTime = state.remainingTime! /
        (state.timer.intervalDurationMinutes * TIME_MULTIPLIER_FACTOR);
    print(remainingTime);
    return remainingTime;
  } else if (state.phase == TimerPhase.RESTING) {
    final remainingTime =
        state.remainingTime! / state.timer.restDurationSeconds;
    return remainingTime;
  }
  // }
  return 0;
  // return Container();
}
