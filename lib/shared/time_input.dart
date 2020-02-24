import 'package:flutter/material.dart';
import 'package:interval_timer/shared/bloc_provider.dart';
import 'package:interval_timer/shared/num_pad.dart';
import 'package:interval_timer/shared/time_input_bloc.dart';
import 'package:interval_timer/shared/time_label.dart';

typedef void SetDuration(Duration d);
typedef void OnDoneClick();

class TimeInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TimeInputState();
  }
}

class TimeInputState extends State<TimeInput> {
  @override
  Widget build(BuildContext context) {
    print('build -> pause time input page');
    TimeInputBloc timeInputBloc = BlocProvider.of<TimeInputBloc>(context);

    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Column(
        children: [
          Expanded(flex: 2, child: StreamBuilder<Duration>(
            stream: timeInputBloc.timeStream,
            builder: (_, snapshot) {
              return TimeLabel(snapshot.data, timeInputBloc.deleteNumber);
            }
          )),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 6, child: NumPad(timeInputBloc.numberSink)),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StreamBuilder<Duration>(
            stream: timeInputBloc.timeStream,
            builder: (_, snapshot) {
              return TimeLabel(snapshot.data, timeInputBloc.deleteNumber);
            }
          ),
          NumPad(timeInputBloc.numberSink),
        ],
      );
    }
  }
}
