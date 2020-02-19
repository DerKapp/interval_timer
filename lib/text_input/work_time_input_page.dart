import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/pause_time_input_page.dart';
import 'package:interval_timer/text_input/time_input.dart';

class WorkTimeInputPage extends StatefulWidget {
  Duration _workDuration;
  Duration _pauseDuration;

  WorkTimeInputPage([
    this._workDuration = const Duration(),
    this._pauseDuration = const Duration(),
  ]);

  @override
  State<StatefulWidget> createState() {
    return WorkTimeInputPageState();
  }
}

class WorkTimeInputPageState extends State<WorkTimeInputPage> {
  @override
  Widget build(BuildContext context) {
    print('build');
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  'Set Workout Duration',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: TimeInput(_setDuration, widget._workDuration),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FlatButton(
                    shape: CircleBorder(),
                    onPressed: () => _done(),
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

  void _setDuration(Duration newDuration) => widget._workDuration = newDuration;

  void _done() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              PauseTimeInputPage(widget._workDuration, widget._pauseDuration)),
    );
  }
}
