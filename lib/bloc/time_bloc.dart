import 'dart:async';

import 'package:interval_timer/bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class TimeBloc implements Bloc {
  final _workTimeController = BehaviorSubject<Duration>.seeded(Duration());
  final _pauseTimeController = BehaviorSubject<Duration>.seeded(Duration());
  final _roundsController = BehaviorSubject<int>.seeded(1);

  ValueStream<Duration> get workTime => _workTimeController.stream;

  ValueStream<Duration> get pauseTime => _pauseTimeController.stream;

  ValueStream<int> get rounds => _roundsController.stream;

  void setWorkTime(Duration workTime) {
    _workTimeController.add(workTime);
  }

  void setPauseTime(Duration pauseTime) {
    _pauseTimeController.add(pauseTime);
  }

  void setRounds(int rounds) {
    _roundsController.add(rounds);
  }

  @override
  void dispose() {
    _workTimeController.close();
    _pauseTimeController.close();
    _roundsController.close();
  }
}
