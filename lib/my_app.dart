import 'package:flutter/material.dart';
import 'package:interval_timer/bloc/bloc_provider.dart';
import 'package:interval_timer/text_input/work_time_input_page.dart';

import 'bloc/time_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimeBloc>(
      bloc: TimeBloc(),
      child: MaterialApp(
        theme: _buildThemeData(),
        home: WorkTimeInputPage(),
      ),
    );
  }

  ThemeData _buildThemeData() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      accentColor: Color(0xFFE63462),
      primaryColor: Color(0xFFEFEFEF),
      canvasColor: Color(0xFF3F51B5),
      textTheme: base.textTheme.copyWith(
        title: base.textTheme.title.copyWith(fontSize: 30),
        display1: base.textTheme.display1.copyWith(color: Color(0xFFEFEFEF)),
        display3: base.textTheme.display1.copyWith(color: Color(0xFFEFEFEF)),
      ),
      iconTheme: base.iconTheme.copyWith(
        color: Color(0xFFEFEFEF),
      ),
    );
  }
}
