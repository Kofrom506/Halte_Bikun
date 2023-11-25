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
