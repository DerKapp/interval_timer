import 'dart:async';

import 'package:flutter/material.dart';

class NumPad extends StatelessWidget {
  final StreamSink<num> _streamSink;

  NumPad(this._streamSink);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: buildNumRow(context, 1, 2, 3)),
        Expanded(child: buildNumRow(context, 4, 5, 6)),
        Expanded(child: buildNumRow(context, 7, 8, 9)),
        Expanded(child: buildNumButton(context, 0))
      ],
    );
  }

  Row buildNumRow(BuildContext context, int first, int second, int third) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          buildNumButton(context, first),
          buildNumButton(context, second),
          buildNumButton(context, third),
        ]);
  }

  FlatButton buildNumButton(BuildContext context, int number) {
    return FlatButton(
      shape: CircleBorder(),
      onPressed: () => _streamSink.add(number),
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}
