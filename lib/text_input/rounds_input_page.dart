import 'package:flutter/material.dart';
import 'package:interval_timer/bloc/bloc_provider.dart';
import 'package:interval_timer/bloc/time_bloc.dart';
import 'package:interval_timer/interval_player/interval_player_page.dart';
import 'package:interval_timer/text_input/number_input.dart';

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
                  'Set Cycle Amount',
                  style: Theme.of(context).textTheme.title,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: NumberInput(timeBloc.rounds.value, timeBloc.setRounds),
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
                        builder: (context) => IntervalPlayerPage(),
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
