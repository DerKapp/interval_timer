import 'package:flutter/material.dart';
import 'package:interval_timer/shared/bloc_provider.dart';
import 'package:interval_timer/core/time_bloc.dart';
import 'package:interval_timer/interval_player/interval_player_page.dart';
import 'package:interval_timer/shared/number_input.dart';
import 'package:interval_timer/shared/number_input_bloc.dart';

class RoundsInputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build -> rounds input page');
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
                  'Set Rounds',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: BlocProvider<NumberInputBloc>(
                bloc: NumberInputBloc(timeBloc.roundStream, timeBloc.roundSink),
                child: NumberInput(),
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
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => IntervalPlayerPage(),
                      ),
                      (_) => false,
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
