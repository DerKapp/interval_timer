import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/cycle_input_page.dart';
import 'package:interval_timer/text_input/time_input.dart';

class PauseTimeInputPage extends StatefulWidget {
  final Duration _workDuration;
  final Duration _pauseDuration;

  PauseTimeInputPage(this._workDuration, this._pauseDuration);

  @override
  State<StatefulWidget> createState() {
    return PauseTimeInputPageState(_workDuration, this._pauseDuration);
  }
}

class PauseTimeInputPageState extends State<PauseTimeInputPage> {
  final Duration _workDuration;
  Duration _pauseDuration;

  PauseTimeInputPageState(this._workDuration, this._pauseDuration);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Pause Time')), body: TimeInput(_setDuration, _pauseDuration, _onDoneClick));
  }

  void _setDuration(Duration newDuration) => _pauseDuration = newDuration;

  void _onDoneClick() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CycleInputPage(1, _workDuration, _pauseDuration)),
    );
  }
}
