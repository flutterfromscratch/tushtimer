import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:standtimer/pages/home/bloc/home_bloc.dart';
import 'package:standtimer/services/database.dart';
import 'package:standtimer/widgets/newtimer/bloc/newtimer_bloc.dart';

class NewTimerWidget extends StatefulWidget {
  @override
  _NewTimerWidgetState createState() => _NewTimerWidgetState();
}

class _NewTimerWidgetState extends State<NewTimerWidget> {
  // final _minutesDurationController = TextEditingController();
  final _timerNameController = TextEditingController();
  // final _secondsRestController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewtimerBloc(RepositoryProvider.of<DatabaseService>(context)),
      child: BlocBuilder<NewtimerBloc, NewtimerState>(
        builder: (context, state) {
          if (state is NewtimerInitial) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Add a new timer",
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextField(
                    controller: _timerNameController,
                    decoration: InputDecoration(labelText: 'Timer name'),
                    // inputFormatters: [Formatter],
                  ),
                  Card(
                    child: Column(
                      children: [
                        Text("Active time"),
                        Slider(
                          min: 3,
                          max: 60,
                          onChanged: (val) {
                            BlocProvider.of<NewtimerBloc>(context).add(UpdateTimerEvent(
                              state.color,
                              state.name,
                              val.toInt(),
                              state.autoRepeats,
                              state.restDuration,
                            ));
                          },
                          value: state.duration.toDouble(),
                        ),
                        Text(state.duration.toString() + " minutes")
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      children: [
                        Text("Wait time"),
                        Slider(
                          min: 3,
                          max: 60,
                          onChanged: (val) {
                            BlocProvider.of<NewtimerBloc>(context).add(UpdateTimerEvent(
                              state.color,
                              state.name,
                              state.duration,
                              state.autoRepeats,
                              val.toInt(),
                            ));
                          },
                          value: state.restDuration.toDouble(),
                        ),
                        Text(state.restDuration.toString() + " seconds")
                      ],
                    ),
                  ),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     floatingLabelBehavior: FloatingLabelBehavior.always,
                  //     labelText: 'Duration (in minutes)',
                  //   ),
                  //   controller: _minutesDurationController,
                  //   keyboardType: TextInputType.number,
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(labelText: 'Rest (in seconds)'),
                  //   controller: _secondsRestController,
                  // ),
                  Container(
                    width: double.infinity,
                    child: RaisedButton(
                      color: state.color,
                      onPressed: () {
                        showDialog<Color>(
                                builder: (context) {
                                  return Dialog(
                                    child: BlockPicker(
                                      pickerColor: state.color,
                                      onColorChanged: (color) => Navigator.pop(
                                        context,
                                        color,
                                      ),
                                    ),
                                  );
                                },
                                context: context)
                            .then((value) => BlocProvider.of<NewtimerBloc>(context).add(UpdateTimerEvent(
                                  value ?? state.color,
                                  _timerNameController.value.text,
                                  state.duration,
                                  state.autoRepeats,
                                  state.restDuration,
                                )));
                      },
                      child: Text("Indicator color"),
                    ),
                  ),
                  CheckboxListTile(
                    value: state.autoRepeats,
                    title: Text('Automatically repeat?'),
                    onChanged: (val) => BlocProvider.of<NewtimerBloc>(context).add(UpdateTimerEvent(
                      state.color,
                      _timerNameController.text,
                      state.duration,
                      val ?? state.autoRepeats,
                      state.restDuration,
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FlatButton.icon(
                        icon: Icon(Icons.add),
                        label: Text("ADD TIMER"),
                        onPressed: () {
                          BlocProvider.of<NewtimerBloc>(context)
                              .add(SaveTimerEvent(state.color, state.name, state.duration, state.autoRepeats, state.restDuration));
                          Navigator.of(context)?.pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
