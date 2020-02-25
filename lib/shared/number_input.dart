import 'package:flutter/material.dart';
import 'package:interval_timer/shared/bloc_provider.dart';
import 'package:interval_timer/shared/num_pad.dart';
import 'package:interval_timer/shared/number_input_bloc.dart';

class NumberInput extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NumberInputState();
}

class NumberInputState extends State<NumberInput> {
  NumberInputBloc _numberInputBloc;

  @override
  Widget build(BuildContext context) {
    print('build -> pause time input page');
    _numberInputBloc = BlocProvider.of<NumberInputBloc>(context);

    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    child: buildRoundsLabel(context),
                  ),
                  SizedBox(
                    height: 4.0,
                    child: Center(
                      child: Container(
                        margin: EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
                        height: 2.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              )),
          Expanded(flex: 1, child: SizedBox()),
          Expanded(flex: 6, child: NumPad(_numberInputBloc.numberSink)),
        ],
      );
    } else {
      return ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildRoundsLabel(context),
            ),
            Expanded(flex: 2, child: NumPad(_numberInputBloc.numberSink))
          ],
        ),
      );
    }
  }

  Widget buildRoundsLabel(BuildContext context) {
    return StreamBuilder<num>(
        stream: _numberInputBloc.numberStream,
        builder: (_, snapshot) {
          return Center(
            child: Text(
              snapshot.data.toString(),
              style: Theme.of(context).textTheme.display3,
            ),
          );
        });
  }
}
