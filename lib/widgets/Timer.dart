import 'package:flutter/material.dart';
import 'dart:async';

class TimerWidget extends StatefulWidget {
  @override
  TextStyle? style;
  _TimerWidgetState createState() => _TimerWidgetState();
  // TimerWidget({required this.style});
}

class _TimerWidgetState extends State<TimerWidget> {
  late Timer _timer;
  // TextStyle? style;
  int _secondsRemaining = 5 * 60; // 5 minutes in seconds



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
          minutes != 0
              ? '$minutes minutes ago'
              : '${seconds.toString().padLeft(2, '0')} seconds ago',
          style: widget.style ??
              TextStyle(
                color: Colors.white, // Text color
                fontSize: 11, // Text size
              ),
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
