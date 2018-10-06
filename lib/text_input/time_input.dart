import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/num_pad.dart';
import 'package:interval_timer/text_input/time_label.dart';

typedef void SetDuration(Duration d);
typedef void OnDoneClick();

class TimeInput extends StatefulWidget {
  final SetDuration _setDuration;
  final OnDoneClick _onDoneClick;
  final Duration _duration;

  TimeInput(this._setDuration, this._duration, this._onDoneClick);

  @override
  State<StatefulWidget> createState() {
    return TimeInputState(this._setDuration, this._duration, this._onDoneClick);
  }
}

class TimeInputState extends State<TimeInput> {
  Duration _duration;

  final SetDuration _setDuration;
  final OnDoneClick _onDoneClick;

  TimeInputState(this._setDuration, this._duration, this._onDoneClick);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      // todo check if media heigth is under 450, then place button bottom right
      return Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400.0, maxWidth: MediaQuery.of(context).size.width),
            child: Column(
              children: <Widget>[
                Expanded(flex: 1, child: TimeLabel(_duration, _deleteDigit)),
                Expanded(flex: 4, child: NumPad(_numPadClick))
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.all(10.0),
                child: FloatingActionButton(child: Icon(Icons.navigate_next), onPressed: () => _onDoneClick()),
              )),
        ],
      );
    } else {
      return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
        child: Row(
          children: <Widget>[
            Expanded(flex: 2, child: TimeLabel(_duration, _deleteDigit)),
            Expanded(flex: 2, child: NumPad(_numPadClick))
          ],
        ),
      );
    }
  }

  void _numPadClick(int number) {
    setState(() {
      double seconds = (_duration.inSeconds % 60).truncateToDouble();
      double minutes = _duration.inMinutes.truncateToDouble();

      seconds = seconds * 10;
      seconds = seconds + number;
      minutes = minutes * 10;
      minutes = minutes + (seconds / 100).truncateToDouble();
      seconds = seconds % 100;
      minutes = minutes % 100;

      _duration = Duration(minutes: minutes.toInt(), seconds: seconds.toInt());
      _setDuration(_duration);
    });
  }

  void _deleteDigit() {
    setState(() {
      double seconds = (_duration.inSeconds % 60).truncateToDouble();
      double minutes = _duration.inMinutes.truncateToDouble();

      seconds = seconds / 10;
      seconds = seconds + (minutes % 10) * 10;
      seconds = seconds.truncateToDouble();
      minutes = minutes / 10;
      minutes = minutes.truncateToDouble();

      _duration = Duration(minutes: minutes.toInt(), seconds: seconds.toInt());
      _setDuration(_duration);
    });
  }
}
