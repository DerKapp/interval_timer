import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/pause_time_input_page.dart';
import 'package:interval_timer/text_input/time_input.dart';


class WorkTimeInputPage extends StatefulWidget {
  final Duration _workDuration;
  final Duration _pauseDuration;

  WorkTimeInputPage([this._workDuration, this._pauseDuration]);

  @override
  State<StatefulWidget> createState() {
    return WorkTimeInputPageState(this._workDuration, this._pauseDuration);
  }
}

class WorkTimeInputPageState extends State<WorkTimeInputPage> {
  Duration _workDuration;
  Duration _pauseDuration;


  WorkTimeInputPageState([this._workDuration, this._pauseDuration]);

  @override
  void initState() {
    _workDuration = _workDuration ?? new Duration();
    _pauseDuration = _pauseDuration ?? new Duration();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
        appBar: AppBar(title: Text('Work Time')), body: TimeInput(_setDuration, _workDuration, _onDoneClick));
  }

  void _setDuration(Duration newDuration) => _workDuration = newDuration;

  void _onDoneClick() async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PauseTimeInputPage(_workDuration, _pauseDuration)),
    );
  }
}
