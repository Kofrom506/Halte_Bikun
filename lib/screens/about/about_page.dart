import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageListState createState() => _AboutPageListState();
}

class _AboutPageListState extends State<AboutPage> {

  final List<Item> _items = <Item>[
    Item('Apa itu Bikun Tracker?', 'Bikun Tracker adalah '),
    Item('Bagaimana Cara Memakai Bikun Tracker?', 'Bikun Tracker adalah '),
    Item('Tim di Balik Aplikasi', 'Bikun Tracker adalah '),
  ];

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
   return SafeArea(
     child: Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text("About",
               style: TextStyle(
                   color: Colors.black,
                   fontSize: 25,
                   fontWeight: FontWeight.bold)),
           Expanded(
             child: ListView(
                  children: _items.map<Widget>((Item item) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                        child: ExpansionPanelList(

                          elevation: 1,
                          expandedHeaderPadding: EdgeInsets.all(16.0),
                          // expandedBodyPadding: EdgeInsets.all(16.0),
                          expansionCallback: (int index, bool isExpanded) {
                            setState(() {
                              item.isExpanded = !item.isExpanded;
                            });
                          },
                          children: [
                            ExpansionPanel(
                              headerBuilder: (BuildContext context, bool isExpanded) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(item.header, style: TextStyle(fontWeight: FontWeight.bold)),
                                );
                              },
                              body: Text(item.body),
                              isExpanded: item.isExpanded,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Image.asset(
                   'assets/ui.png',
                   width: screenWidth * 0.1,
                   fit:BoxFit.fitWidth

               ),
               SizedBox(width: 20),
               Image.asset(
                 'assets/dte.png',
                 width: screenWidth * 0.3,
                 fit:BoxFit.fitWidth

                 // width: double.infinity,
                 // height: 150,
                 // fit: BoxFit.cover,
               ),

             ],
           ),
         ],
       ),
     ),
   );
  }
}

class Item {
  Item(this.header, this.body, {this.isExpanded = false});
  final String header;
  final String body;
  bool isExpanded;
}