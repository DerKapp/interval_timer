import 'package:flutter/material.dart';
import 'package:interval_timer/interval_player/interval_player_page.dart';
import 'package:interval_timer/text_input/number_input.dart';

class CycleInputPage extends StatefulWidget {
  final int _cycles;
  final Duration _workDuration;
  final Duration _pauseDuration;

  CycleInputPage(this._cycles, this._workDuration, this._pauseDuration);

  @override
  State<StatefulWidget> createState() => CycleInputPageState(_cycles, _workDuration, _pauseDuration);
}

class CycleInputPageState extends State<CycleInputPage> {
  final Duration _workDuration;
  final Duration _pauseDuration;
  int _cycles;

  CycleInputPageState(this._cycles, this._workDuration, this._pauseDuration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Cycle Amount')), body: NumberInput(_cycles, _onDoneClick, _setNumber));
  }

  void _onDoneClick() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => IntervalPlayerPage(_cycles, _workDuration, _pauseDuration)),
      (Route<dynamic> route) => false,
    );
  }

  void _setNumber(int number) => _cycles = number;
}
