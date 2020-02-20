import 'package:flutter/material.dart';
import 'package:interval_timer/shared/num_pad.dart';
import 'package:interval_timer/shared/time_label.dart';

typedef void SetDuration(Duration d);
typedef void OnDoneClick();

class TimeInput extends StatefulWidget {
  final SetDuration _setDuration;
  Duration _duration;

  TimeInput(this._setDuration, this._duration);

  @override
  State<StatefulWidget> createState() {
    return TimeInputState();
  }
}

class TimeInputState extends State<TimeInput> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      // todo check if media heigth is under 450, then place button bottom right
      return Column(
        children: <Widget>[
          Expanded(flex: 2, child: TimeLabel(widget._duration, _deleteDigit)),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 6, child: NumPad(_numPadClick)),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          TimeLabel(widget._duration, _deleteDigit),
          NumPad(_numPadClick),
        ],
      );
    }
  }

  void _numPadClick(int number) {
    setState(() {
      double seconds = (widget._duration.inSeconds % 60).truncateToDouble();
      double minutes = widget._duration.inMinutes.truncateToDouble();

      seconds = seconds * 10;
      seconds = seconds + number;
      minutes = minutes * 10;
      minutes = minutes + (seconds / 100).truncateToDouble();
      seconds = seconds % 100;
      minutes = minutes % 100;

      widget._duration = Duration(minutes: minutes.toInt(), seconds: seconds.toInt());
      widget._setDuration(widget._duration);
    });
  }

  void _deleteDigit() {
    setState(() {
      double seconds = (widget._duration.inSeconds % 60).truncateToDouble();
      double minutes = widget._duration.inMinutes.truncateToDouble();

      seconds = seconds / 10;
      seconds = seconds + (minutes % 10) * 10;
      seconds = seconds.truncateToDouble();
      minutes = minutes / 10;
      minutes = minutes.truncateToDouble();

      widget._duration = Duration(minutes: minutes.toInt(), seconds: seconds.toInt());
      widget._setDuration(widget._duration);
    });
  }
}
