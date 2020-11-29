import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:standtimer/database/database.dart';

class TimerWidget extends StatelessWidget {
  final ActivityTimer timer;

  const TimerWidget({Key? key, required this.timer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // create: ,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Transform.rotate(
                    angle: 9.5,
                    child: CircularProgressIndicator(
                      strokeWidth: 10,
                      value: 0.99,
                    ),
                  ),
                ),
              ),
              Text("Stand")
            ],
          ),
        ),
      ),
    );
  }
}
