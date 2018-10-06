import 'package:flutter/material.dart';
import 'package:interval_timer/interval_player/interval_player_page.dart';
import 'package:interval_timer/text_input/time_label.dart';
import 'package:interval_timer/text_input/work_time_input_page.dart';

class IntervalSettingsPage extends StatefulWidget {
  final Duration _workLength;
  final Duration _pauseLength;

  IntervalSettingsPage(this._workLength, this._pauseLength);

  @override
  State<StatefulWidget> createState() {
    return IntervalSettingsPageState(_workLength, _pauseLength);
  }
}

class IntervalSettingsPageState extends State<IntervalSettingsPage> {
  Duration _workLength;
  Duration _pauseLength;

  IntervalSettingsPageState(this._workLength, this._pauseLength);

  @override
  void initState() {
    _workLength = _workLength ?? new Duration();
    _pauseLength = _pauseLength ?? new Duration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Interval Settings'),
        ),
        body: ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height, maxWidth: MediaQuery.of(context).size.width),
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: buildContent(context),
            )));
  }

  Flex buildContent(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[_buildSettingsOverview(context), Expanded(child: _buildButtons())],
      );
    } else {
      return Row(
        children: <Widget>[
          Expanded(flex: 3, child: _buildSettingsOverview(context)),
          Expanded(flex: 2, child: _buildButtons())
        ],
      );
    }
  }

  Column _buildSettingsOverview(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Work',
              style: Theme.of(context).textTheme.display1,
            ),
            TimeLabel(_workLength)
          ],
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Pause',
                style: Theme.of(context).textTheme.display1,
              ),
              TimeLabel(_pauseLength),
            ]),
        Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Cycles',
                style: Theme.of(context).textTheme.display1,
              ),
              Text(
                '5',
                style: Theme.of(context).textTheme.display3,
              ),
            ])
      ],
    );
  }

  Row _buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[_buildEditButton(), _buildRunButton()],
    );
  }

  FloatingActionButton _buildRunButton() {
    return FloatingActionButton(
        heroTag: 0,
        child: Icon(Icons.play_arrow),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => IntervalPlayerPage(5, _workLength, _pauseLength)),
          );
        });
  }

  FloatingActionButton _buildEditButton() {
    return FloatingActionButton(
        heroTag: 1,
        child: Icon(Icons.edit),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WorkTimeInputPage(_workLength, _pauseLength)),
          );
        });
  }
}
