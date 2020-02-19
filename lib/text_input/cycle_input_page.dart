import 'package:flutter/material.dart';
import 'package:interval_timer/interval_player/interval_player_page.dart';
import 'package:interval_timer/text_input/number_input.dart';

class CycleInputPage extends StatefulWidget {
  final int _cycles;
  final Duration _workDuration;
  final Duration _pauseDuration;

  CycleInputPage(this._cycles, this._workDuration, this._pauseDuration);

  @override
  State<StatefulWidget> createState() =>
      CycleInputPageState(_cycles, _workDuration, _pauseDuration);
}

class CycleInputPageState extends State<CycleInputPage> {
  final Duration _workDuration;
  final Duration _pauseDuration;
  int _cycles;

  CycleInputPageState(this._cycles, this._workDuration, this._pauseDuration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Set Cycle Amount',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: NumberInput(_cycles, _setNumber),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FlatButton(
                    shape: CircleBorder(),
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 50,
                    ),
                  ),
                  FlatButton(
                    shape: CircleBorder(),
                    onPressed: () => _onDoneClick(),
                    child: Icon(
                      Icons.done,
                      size: 50,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onDoneClick() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) =>
              IntervalPlayerPage(_cycles, _workDuration, _pauseDuration)),
      (Route<dynamic> route) => false,
    );
  }

  void _setNumber(int number) => _cycles = number;
}
