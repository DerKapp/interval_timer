import 'package:flutter/material.dart';
import 'package:interval_timer/shared/num_pad.dart';

typedef void OnDoneClick();
typedef void SetNumber(int number);

class NumberInput extends StatefulWidget {
  int _number;
  final SetNumber _setNumber;

  NumberInput(this._number, this._setNumber);

  @override
  State<StatefulWidget> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[
          Expanded(flex: 2, child: buildRoundsLabel(context)),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 6, child: NumPad(_numPadClick)),
        ],
      );
    } else {
      return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
        child: Row(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Center(
                        child: Text(widget._number.toString(), style: Theme.of(context).textTheme.display3),
                      ),
                    ),
                  ],
                )),
            Expanded(flex: 2, child: NumPad(_numPadClick))
          ],
        ),
      );
    }
  }

  Column buildRoundsLabel(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(child: Center(child: Text(widget._number.toString(), style: Theme.of(context).textTheme.display3))),
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
  }

  void _numPadClick(int number) {
    setState(() {
      widget._number = number;
      widget._setNumber(number);
    });
  }
}
