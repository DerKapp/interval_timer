import 'package:flutter/material.dart';
import 'package:interval_timer/text_input/work_time_input_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        canvasColor: Colors.blueGrey,
        iconTheme: IconThemeData(
          color: Colors.white70,
        ),
        accentColor: Colors.white70,
        brightness: Brightness.dark,
      ),
      home: WorkTimeInputPage(),
    );
  }
}
