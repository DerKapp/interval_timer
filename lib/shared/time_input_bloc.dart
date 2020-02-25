import 'dart:async';

import 'package:interval_timer/shared/bloc.dart';
import 'package:rxdart/rxdart.dart';

class TimeInputBloc extends Bloc {
  final StreamController<num> _numberController = StreamController();
  StreamSubscription _numberSub;

  ValueStream<Duration> timeStream;
  StreamSink<Duration> timeSink;

  StreamSink<num> get numberSink => _numberController.sink;

  TimeInputBloc(StreamSink _timeSink, ValueStream<Duration> _timeStream)
      : timeStream = _timeStream,
        timeSink = _timeSink {
    _numberSub = _numberController.stream.listen((number) {
      double seconds = (timeStream.value.inSeconds % 60).truncateToDouble();
      double minutes = timeStream.value.inMinutes.truncateToDouble();

      seconds = seconds * 10;
      seconds = seconds + number;
      minutes = minutes * 10;
      minutes = minutes + (seconds / 100).truncateToDouble();
      seconds = seconds % 100;
      minutes = minutes % 100;

      timeSink.add(Duration(minutes: minutes.toInt(), seconds: seconds.toInt()));
    });
  }

  void deleteNumber() {
    double seconds = (timeStream.value.inSeconds % 60).truncateToDouble();
    double minutes = timeStream.value.inMinutes.truncateToDouble();

    seconds = seconds / 10;
    seconds = seconds + (minutes % 10) * 10;
    seconds = seconds.truncateToDouble();
    minutes = minutes / 10;
    minutes = minutes.truncateToDouble();

    timeSink.add(Duration(minutes: minutes.toInt(), seconds: seconds.toInt()));
  }

  @override
  void dispose() {
    _numberController.close();
    _numberSub.cancel();
  }
}
