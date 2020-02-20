import 'package:flutter/material.dart';
import 'package:interval_timer/shared/time_segment.dart';

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
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [_buildTimeRow(), _buildIconButton(context)]),
          ),
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
      crossAxisAlignment: CrossAxisAlignment.center,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        TimeSegment(_duration.inMinutes.truncate().toString(), 'm'),
        TimeSegment((_duration.inSeconds % 60).truncate().toString(), 's'),
      ],
    );
  }

  FlatButton _buildIconButton(BuildContext context) {
    return FlatButton(
      shape: CircleBorder(),
      child: Icon(Icons.backspace),
      onPressed: () => _deleteDigit(),
    );
  }
}
