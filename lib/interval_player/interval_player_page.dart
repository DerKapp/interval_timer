import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:interval_timer/interval_player/timer_painter.dart';
import 'package:interval_timer/text_input/time_label.dart';
import 'package:interval_timer/text_input/work_time_input_page.dart';

enum DurationState { warmUp, work, pause }

class IntervalPlayerPage extends StatefulWidget {
  final Duration _workDuration;
  final Duration _pauseDuration;
  final int _cycles;

  IntervalPlayerPage(this._cycles, this._workDuration, this._pauseDuration);

  @override
  State<StatefulWidget> createState() {
    return IntervalPlayerPageState(this._cycles, this._workDuration, this._pauseDuration);
  }
}

class IntervalPlayerPageState extends State<IntervalPlayerPage> with TickerProviderStateMixin {
  AnimationController controller;

  DurationState _durationState = DurationState.warmUp;

  String get _durationTitle {
    switch (_durationState) {
      case DurationState.warmUp:
        return 'Get Ready';
      case DurationState.work:
        return 'Work It!';
      case DurationState.pause:
        return 'Rest';
      default:
        return 'Unknown State';
    }
  }

  Duration _getReadyDuration = Duration(seconds: 5);
  Duration _workDuration;
  Duration _pauseDuration;
  final int _cycleLimit;
  int _cycleCount = 0;

  IntervalPlayerPageState(this._cycleLimit, this._workDuration, this._pauseDuration);

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: _getReadyDuration, value: 1.0);

    controller.addListener(() {
      if (controller.value == 0 && _cycleCount < _cycleLimit) {
        switch (_durationState) {
          case DurationState.warmUp:
            _durationState = DurationState.work;
            controller.duration = _workDuration;
            _cycleCount++;
            break;
          case DurationState.work:
            _durationState = DurationState.pause;
            controller.duration = _pauseDuration;
            break;
          case DurationState.pause:
            _durationState = DurationState.work;
            controller.duration = _getReadyDuration;
            _cycleCount++;
            break;
        }
        SystemSound.play(SystemSoundType.click);
        controller.reverse(from: 1.0);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildTimer(themeData),
            AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    child: buildButtons(),
                  );
                })
          ],
        ),
      ),
    );
  }

  Widget buildButtons() {
    if (controller.isAnimating) {
      return FloatingActionButton(
        heroTag: 10,
        child: Icon(Icons.pause),
        onPressed: () {
          controller.stop();
          // this is used to rerender all after stop
          setState(() {});
        },
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 11,
            child: Icon(Icons.stop),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WorkTimeInputPage(_workDuration, _pauseDuration)),
                  (Route<dynamic> route) => false);
            },
          ),
          FloatingActionButton(
            heroTag: 10,
            child: Icon(Icons.play_arrow),
            onPressed: () {
              controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
            },
          )
        ],
      );
    }
  }

  Expanded buildTimer(ThemeData themeData) {
    return Expanded(
      child: Align(
        alignment: FractionalOffset.center,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget child) {
                    return new CustomPaint(
                        painter: TimerPainter(
                      animation: controller,
                      backgroundColor: Colors.white,
                      color: Colors.deepOrangeAccent,
                    ));
                  },
                ),
              ),
              Align(
                alignment: FractionalOffset.center,
                child: AnimatedBuilder(
                    animation: controller,
                    builder: (BuildContext context, Widget child) {
                      return buildTimeInfo(themeData);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildTimeInfo(ThemeData themeData) {
    if (_durationState == DurationState.warmUp) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_durationTitle, style: themeData.textTheme.display1),
          TimeLabel(controller.duration * controller.value)
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_durationTitle, style: themeData.textTheme.display1),
          Text('Cycle: $_cycleCount/$_cycleLimit', style: themeData.textTheme.body1),
          TimeLabel(controller.duration * controller.value)
        ],
      );
    }
  }
}
