import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences_web';
import 'package:simple_gesture_detector/simple_gesture_detector.dart';
import 'package:shared_preferences_platform_interface';
import 'shared/utils.dart';
import 'widgets/calendar_core.dart';

void main()
=>

runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

@override
class _MyAppState extends State<MyApp> {

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: TableCalendar(
            startDay: DateTime.utc(2010, 10, 20),
            endDay: DateTime.utc(2040, 10, 20),

            headerVisible: true,

            headerStyle: HeaderStyle(titleTextStyle: TextStyle(fontSize: 20,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w800)),
            calendarStyle: CalendarStyle()),
          ),
        ),

    );
  }
}
