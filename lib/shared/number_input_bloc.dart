import 'dart:async';

import 'package:interval_timer/shared/bloc.dart';
import 'package:rxdart/streams.dart';

class NumberInputBloc extends Bloc {
  final ValueStream<num> numberStream;
  final StreamSink<num> numberSink;

  NumberInputBloc(this.numberStream, this.numberSink);

  @override
  void dispose() {
  }
}
