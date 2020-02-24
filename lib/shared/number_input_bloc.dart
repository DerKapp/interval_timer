import 'dart:async';

import 'package:interval_timer/shared/bloc.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

class NumberInputBloc extends Bloc {
  final BehaviorSubject<num> _numController;

  NumberInputBloc(num initialNumber) : _numController = BehaviorSubject<num>.seeded(initialNumber);

  ValueStream<num> get numberStream => _numController.stream;
  StreamSink<num> get numberSink => _numController.sink;

  @override
  void dispose() {
    _numController.close();
  }
}
