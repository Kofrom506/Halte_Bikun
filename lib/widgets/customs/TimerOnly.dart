import 'package:flutter/material.dart';
import 'dart:async';

class TimerOnly extends StatefulWidget {
  @override
  TextStyle? style;
  int minutes = 0;
  TimerOnlyState createState() => TimerOnlyState();

  TimerOnly({required this.minutes, required TextStyle style});
// TimerWidget({required this.style});
}

class TimerOnlyState extends State<TimerOnly> {
  late Timer _timer;
  TextStyle? style;
  int _secondsRemaining = 7 * 60; // 5 minutes in seconds

  // TextStyle? style;
  // 5 minutes in seconds

  @override
  void initState() {
    super.initState();
    // Start the timer when the widget is created
    _timer = Timer.periodic(Duration(seconds: 1), _updateTimer);
  }

  void _updateTimer(Timer timer) {
    setState(() {
      if (_secondsRemaining > 0) {
        _secondsRemaining--;
      } else {
        // Timer has reached 0, you can handle what happens when the timer is done.
        _timer.cancel(); // Stop the timer
        // Add any additional logic here
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Convert seconds to minutes and seconds for display
    int minutes = _secondsRemaining ~/ 60;
    int seconds = _secondsRemaining % 60;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          minutes != 0 ? '$minutes ' : '${seconds.toString().padLeft(2, '0')} ',
          style: widget.style ??
              TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Cancel the timer when the widget is disposed
    super.dispose();
    // _timer.cancel();
  }
}
