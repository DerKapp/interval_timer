import 'package:flutter/material.dart';
import 'package:interval_timer/shared/bloc_provider.dart';
import 'package:interval_timer/core/time_bloc.dart';
import 'package:interval_timer/rounds/rounds_input_page.dart';
import 'package:interval_timer/shared/time_input.dart';
import 'package:interval_timer/shared/time_input_bloc.dart';

class PauseTimeInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build -> pause time input page');
    TimeBloc timeBloc = BlocProvider.of<TimeBloc>(context);

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
              child: BlocProvider<TimeInputBloc>(
                bloc: TimeInputBloc(timeBloc.pauseTimeSink, timeBloc.pauseTimeStream),
                child: TimeInput(),
              ),
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
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RoundsInputPage(),
                      ),
                    ),
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
}
