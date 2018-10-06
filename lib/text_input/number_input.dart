import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/num_pad.dart';

typedef void OnDoneClick();
typedef void SetNumber(int number);

class NumberInput extends StatefulWidget {
  final int _number;
  final OnDoneClick _onDoneClick;
  final SetNumber _setNumber;

  NumberInput(this._number, this._onDoneClick, this._setNumber);

  @override
  State<StatefulWidget> createState() => NumberInputState(_number, _onDoneClick, _setNumber);
}

class NumberInputState extends State<NumberInput> {
  int _number;
  final OnDoneClick _onDoneClick;
  final SetNumber _setNumber;

  NumberInputState(this._number, this._onDoneClick, this._setNumber);

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Stack(
        children: <Widget>[
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 400.0, maxWidth: MediaQuery.of(context).size.width),
            child: Column(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Text(_number.toString(), style: Theme.of(context).textTheme.display3),
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
                    )),
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
            Expanded(flex: 2, child: Text(_number.toString(), style: Theme.of(context).textTheme.display3)),
            Expanded(flex: 2, child: NumPad(_numPadClick))
          ],
        ),
      );
    }
  }

  void _numPadClick(int number) {
    setState(() {
      _number = number;
      _setNumber(number);
    });
  }
}
