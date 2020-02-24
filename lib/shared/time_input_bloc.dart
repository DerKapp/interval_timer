import 'dart:async';

import 'package:interval_timer/shared/bloc.dart';
import 'package:rxdart/rxdart.dart';

class TimeInputBloc extends Bloc {
  final BehaviorSubject<Duration> _timeController;
  final StreamController<num> _numberController = StreamController();
  StreamSubscription _subscription;

  TimeInputBloc([Duration initialTime = const Duration()])
      : _timeController = BehaviorSubject<Duration>.seeded(initialTime) {
    _subscription = _numberController.stream.listen((number) {
      double seconds = (_timeController.value.inSeconds % 60).truncateToDouble();
      double minutes = _timeController.value.inMinutes.truncateToDouble();

      seconds = seconds * 10;
      seconds = seconds + number;
      minutes = minutes * 10;
      minutes = minutes + (seconds / 100).truncateToDouble();
      seconds = seconds % 100;
      minutes = minutes % 100;

      _timeController.add(Duration(minutes: minutes.toInt(), seconds: seconds.toInt()));
    });
  }

  ValueStream<Duration> get timeStream => _timeController.stream;

  StreamSink<Duration> get timeSink => _timeController.sink;

  StreamSink<num> get numberSink => _numberController.sink;

  void deleteNumber() {
    double seconds = (_timeController.value.inSeconds % 60).truncateToDouble();
    double minutes = _timeController.value.inMinutes.truncateToDouble();

    seconds = seconds / 10;
    seconds = seconds + (minutes % 10) * 10;
    seconds = seconds.truncateToDouble();
    minutes = minutes / 10;
    minutes = minutes.truncateToDouble();

    _timeController.add(Duration(minutes: minutes.toInt(), seconds: seconds.toInt()));
  }

  @override
  void dispose() {
    _timeController.close();
    _numberController.close();
    _subscription.cancel();
  }
}
