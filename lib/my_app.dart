import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/work_time_input_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildThemeData(),
      home: WorkTimeInputPage(),
    );
  }

  ThemeData _buildThemeData() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      accentColor: Colors.white70,
      canvasColor: Colors.blueGrey,
      textTheme: base.textTheme.copyWith(
        title: base.textTheme.title.copyWith(fontSize: 30),
        display1: base.textTheme.display1.copyWith(color: Colors.white),
        display3: base.textTheme.display1.copyWith(color: Colors.white),
      ),
      iconTheme: base.iconTheme.copyWith(
        color: Colors.white,
      ),
    );
  }
}
