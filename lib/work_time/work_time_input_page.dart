import 'package:flutter/material.dart';
import 'package:interval_timer/shared/bloc_provider.dart';
import 'package:interval_timer/core/time_bloc.dart';
import 'package:interval_timer/pause_time/pause_time_input_page.dart';
import 'package:interval_timer/shared/time_input.dart';
import 'package:interval_timer/shared/time_input_bloc.dart';

class WorkTimeInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build -> work time input page');
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
                  'Set Work Duration',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: BlocProvider<TimeInputBloc>(
                bloc: TimeInputBloc(timeBloc.workTimeSink, timeBloc.workTimeStream),
                child: TimeInput(),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  FlatButton(
                    shape: CircleBorder(),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PauseTimeInputPage(),
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
