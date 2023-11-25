import 'package:flutter/material.dart';
import 'package:flutter_halte/models/Data.dart';
import 'package:flutter_halte/widgets/Content.dart';

class DataModal extends StatelessWidget {
  final DataNow data;

  DataModal({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TechStackWidget()
            // Text('Person Count: ${data.personCount}', style: TextStyle(fontSize: 18)),
            // SizedBox(height: 8),
            // Text('Date and Time: ${data.dateTime.toString()}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}