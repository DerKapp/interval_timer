import 'package:flutter/material.dart';

class TimeSegment extends StatelessWidget {
  final String _unit;
  final String _value;

  TimeSegment(this._value, this._unit);

  @override
  Widget build(BuildContext context) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(
            _value.padLeft(2, '0'),
            style: Theme.of(context).textTheme.display3,
          ),
          Text(_unit, style: Theme.of(context).textTheme.display1),
        ]);
  }
}
