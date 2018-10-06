import 'package:flutter/material.dart';

typedef void ClickNumber(int number);
typedef void OnDoneClick();

class NumPad extends StatelessWidget {
  final ClickNumber _clickNumber;

  NumPad(this._clickNumber);

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
      onPressed: () => _clickNumber(number),
      child: Text(
        number.toString(),
        style: Theme.of(context).textTheme.display1,
      ),
    );
  }
}
