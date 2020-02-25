import 'dart:async';

import 'package:interval_timer/shared/bloc.dart';
import 'package:rxdart/rxdart.dart';

class TimeBloc implements Bloc {
  final _workTimeController = BehaviorSubject<Duration>.seeded(Duration());
  final _pauseTimeController = BehaviorSubject<Duration>.seeded(Duration());
  final _roundsController = BehaviorSubject<int>.seeded(1);

  ValueStream<Duration> get workTimeStream => _workTimeController.stream;
  StreamSink<Duration> get workTimeSink => _workTimeController.sink;

  ValueStream<Duration> get pauseTimeStream => _pauseTimeController.stream;
  StreamSink<Duration> get pauseTimeSink => _pauseTimeController.sink;

  ValueStream<num> get roundStream => _roundsController.stream;
  StreamSink<num> get roundSink => _roundsController.sink;

  void setWorkTime(Duration workTime) {
    print('workTime: $workTime');
    _workTimeController.add(workTime);
  }

  void setPauseTime(Duration pauseTime) {
    print('pauseTime: $pauseTime');
    _pauseTimeController.add(pauseTime);
  }

  void setRounds(num rounds) {
    _roundsController.add(rounds);
  }

  @override
  void dispose() {
    _workTimeController.close();
    _pauseTimeController.close();
    _roundsController.close();
  }
}
