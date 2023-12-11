import 'package:flutter/material.dart';

import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

class BusLocationPage extends StatelessWidget {
  SlidingUpPanelController panelController = SlidingUpPanelController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Row(
            children: [
              Text("Halte UI --> Halte Teknik"),
              Text(" 4 km"),
              Spacer(),
              Icon(Icons.info)
            ],
          ),
          Divider(),
          CircularTextWidget(number: 6),
          Row(
            children: [
              Expanded(
                child: Card(
                  child: ListTile(

                    title: Text('1.5Km'),
                    subtitle: Text('Distance'),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  child: ListTile(
                    title: Text('1:43:31'),
                    subtitle: Text('Duration'),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
class CircularTextWidget extends StatelessWidget {
  final int number;

  CircularTextWidget({required this.number});

  @override
  Widget build(BuildContext context) {
    // Determine if the number is greater than 5
    bool isNumberGreaterThan5 = number > 5;

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isNumberGreaterThan5 ? Colors.red : Colors.black,
              width: 2.0,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: isNumberGreaterThan5 ? Colors.red : Colors.black,
              ),
            ),
          ),
        ),
        if (isNumberGreaterThan5)
          Image.asset("assets/ramai.png", width: 200),
        if (!isNumberGreaterThan5)
          Image.asset("assets/sepi.jpg", width: 200),
        SizedBox(height: 10),
        Text("RAMAI", style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: isNumberGreaterThan5 ? Colors.red : Colors.black,
          ),
        ),

        SizedBox(height: 10),

      ],
    );
  }
}
