import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:interval_timer/shared/bloc_provider.dart';
import 'package:interval_timer/core/time_bloc.dart';
import 'package:interval_timer/interval_player/timer_painter.dart';
import 'package:interval_timer/shared/time_label.dart';
import 'package:interval_timer/work_time/work_time_input_page.dart';
import 'package:path_provider/path_provider.dart';

enum DurationState { warmUp, work, pause, finished }

class IntervalPlayerPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IntervalPlayerPageState();
  }
}

class IntervalPlayerPageState extends State<IntervalPlayerPage> with TickerProviderStateMixin {
  static const Duration _READY_DURATION = Duration(seconds: 5);
  TimeBloc _timeBloc;

  int _roundCount = 0;

  AnimationController controller;
  DurationState _durationState = DurationState.warmUp;

  String _pauseFilePath;
  String _workFilePath;

  AudioPlayer audioPlayer = new AudioPlayer();

  String get _durationTitle {
    switch (_durationState) {
      case DurationState.warmUp:
        return 'Get Ready';
      case DurationState.work:
        return 'Work It!';
      case DurationState.pause:
        return 'Rest';
      case DurationState.finished:
        return 'Well Done!';
      default:
        return 'Unknown State';
    }
  }

  @override
  void initState() {
    _loadFile();
    controller = AnimationController(vsync: this, duration: _READY_DURATION, value: 0);
    controller.addListener(_stateChange);

    super.initState();
  }

  void _stateChange() {
    if (controller.value == 0 && _roundCount < _timeBloc.rounds.value) {
      switch (_durationState) {
        case DurationState.warmUp:
          audioPlayer.play(_workFilePath, isLocal: true);
          _durationState = DurationState.work;
          controller.duration = _timeBloc.workTime.value;
          _roundCount++;
          break;
        case DurationState.work:
          audioPlayer.play(_pauseFilePath, isLocal: true);
          _durationState = DurationState.pause;
          controller.duration = _timeBloc.pauseTime.value;
          break;
        case DurationState.pause:
          audioPlayer.play(_workFilePath, isLocal: true);
          _durationState = DurationState.work;
          controller.duration = _timeBloc.workTime.value;
          _roundCount++;
          break;
        default:
      }

      controller.reverse(from: 1.0);
    } else if (controller.value == 0 && _roundCount == _timeBloc.rounds.value) {
      _durationState = DurationState.finished;
    }
  }

  Future _loadFile() async {
    final dir = await getApplicationDocumentsDirectory();
    final lvlUpFile = new File('${dir.path}/pauseaudio.mp3');
    final nowGoFile = new File('${dir.path}/workaudio.mp3');

    var lvlUpBytes = await rootBundle.load('assets/sound/pause.mp3');
    var nowGoBytes = await rootBundle.load('assets/sound/work.mp3');

    final lvlUpBuffer = lvlUpBytes.buffer;
    final nowGoBuffer = nowGoBytes.buffer;
    await lvlUpFile.writeAsBytes(lvlUpBuffer.asUint8List(lvlUpBytes.offsetInBytes, lvlUpBytes.lengthInBytes));
    await nowGoFile.writeAsBytes(nowGoBuffer.asUint8List(nowGoBytes.offsetInBytes, nowGoBytes.lengthInBytes));

    if (await lvlUpFile.exists() && await nowGoFile.exists()) {
      _pauseFilePath = lvlUpFile.path;
      _workFilePath = nowGoFile.path;
    } else {
      print('file not exists');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('build -> interval player page');
    _timeBloc = BlocProvider.of<TimeBloc>(context);

    ThemeData themeData = Theme.of(context);
    Orientation orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: orientation == Orientation.portrait
              ? Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: getTextContent(themeData),
                    ),
                    Expanded(
                      flex: 6,
                      child: buildTimer(themeData),
                    ),
                    Expanded(
                      flex: 2,
                      child: getButtonsContent(),
                    )
                  ],
                )
              : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: buildTimer(themeData),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: getTextContent(themeData),
                          ),
                          Expanded(
                            flex: 1,
                            child: getButtonsContent(),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  AnimatedBuilder getButtonsContent() {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => buildButtons(),
    );
  }

  AnimatedBuilder getTextContent(ThemeData themeData) {
    return AnimatedBuilder(
      animation: controller,
      builder: (_, __) => Row(
        verticalDirection: VerticalDirection.down,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _durationTitle,
            style: themeData.textTheme.display1,
          ),
        ],
      ),
    );
  }

  Widget buildButtons() {
    if (controller.isAnimating) {
      return FlatButton(
        shape: CircleBorder(),
        onPressed: () => setState(() => controller.stop()),
        child: Icon(
          Icons.pause,
          size: 50,
        ),
      );
    } else if (_durationState == DurationState.finished) {
      return FlatButton(
        shape: CircleBorder(),
        onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => WorkTimeInputPage(),
            ),
            (_) => false),
        child: Icon(
          Icons.home,
          size: 50,
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          FlatButton(
            shape: CircleBorder(),
            onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkTimeInputPage(),
                ),
                (_) => false),
            child: Icon(
              Icons.stop,
              size: 50,
            ),
          ),
          FlatButton(
            shape: CircleBorder(),
            onPressed: () => controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value),
            child: Icon(
              Icons.play_arrow,
              size: 50,
            ),
          ),
        ],
      );
    }
  }

  Align buildTimer(ThemeData themeData) {
    return Align(
      alignment: FractionalOffset.center,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: AnimatedBuilder(
                animation: controller,
                builder: (BuildContext context, Widget child) {
                  var backgroundColor;
                  var frontColor;

                  switch (_durationState) {
                    case DurationState.warmUp:
                      backgroundColor = themeData.primaryColor;
                      frontColor = themeData.canvasColor;
                      break;
                    case DurationState.work:
                      backgroundColor = themeData.canvasColor;
                      frontColor = themeData.accentColor;
                      break;
                    case DurationState.pause:
                      backgroundColor = themeData.accentColor;
                      frontColor = themeData.canvasColor;
                      break;
                    case DurationState.finished:
                      backgroundColor = Colors.transparent;
                      frontColor = Colors.transparent;
                      break;
                  }

                  return CustomPaint(
                    painter: TimerPainter(
                      animation: controller,
                      backgroundColor: backgroundColor,
                      color: frontColor,
                    ),
                  );
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
    );
  }

  Widget buildTimeInfo(ThemeData themeData) {
    switch (_durationState) {
      case DurationState.warmUp:
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[TimeLabel(controller.duration * controller.value)],
        );
      case DurationState.work:
      case DurationState.pause:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TimeLabel(controller.duration * controller.value),
            Text('Round $_roundCount of ${_timeBloc.rounds.value}', style: themeData.textTheme.display1),
          ],
        );
      case DurationState.finished:
        return SvgPicture.asset(
          'assets/celebration.svg',
          semanticsLabel: 'cel',
        );
      default:
        throw Exception('Unhandled duration state');
    }
  }
}
