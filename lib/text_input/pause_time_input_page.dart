import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/cycle_input_page.dart';
import 'package:interval_timer/text_input/time_input.dart';

class PauseTimeInputPage extends StatefulWidget {
  final Duration _workDuration;
  Duration _pauseDuration;

  PauseTimeInputPage(this._workDuration, this._pauseDuration);

  @override
  State<StatefulWidget> createState() {
    return PauseTimeInputPageState();
  }
}

class PauseTimeInputPageState extends State<PauseTimeInputPage> {
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
                  'Set Rest Duration',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: TimeInput(_setDuration, widget._pauseDuration),
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

  void _setDuration(Duration newDuration) =>
      widget._pauseDuration = newDuration;

  void _done() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CycleInputPage(1, widget._workDuration, widget._pauseDuration)),
    );
  }
}
