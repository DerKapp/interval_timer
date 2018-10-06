import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/time_segment.dart';

typedef void DeleteDigit();

class TimeLabel extends StatelessWidget {
  final Duration _duration;

  final DeleteDigit _deleteDigit;

  TimeLabel(this._duration, [this._deleteDigit]);

  @override
  Widget build(BuildContext context) {
    if (_deleteDigit != null) {
      return Column(
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_buildTimeRow(), _buildIconButton(context)]),
          SizedBox(
              height: 4.0,
              child: Center(
                child: Container(
                  margin: EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                  height: 2.0,
                  color: Theme.of(context).primaryColor,
                ),
              ))
        ],
      );
    } else {
      return _buildTimeRow();
    }
  }

  Row _buildTimeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        TimeSegment(_duration.inMinutes.truncate().toString(), 'm'),
        TimeSegment((_duration.inSeconds % 60).truncate().toString(), 's'),
      ],
    );
  }

  IconButton _buildIconButton(BuildContext context) {
    return IconButton(icon: Icon(Icons.backspace), onPressed: () => _deleteDigit());
  }
}
