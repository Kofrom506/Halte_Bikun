import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageListState createState() => _AboutPageListState();
}

class _AboutPageListState extends State<AboutPage> {

  final List<Item> _items = <Item>[
    Item('Apa itu HalteTracker?', ''
        'HalteTracker Merupakan sebuah aplikasi yang membantu setiap pengguna halte di halte teknik untuk mengetahui keramaian di halte. Sehingga pengguna dapat dengan nyaman menggunakan fasiltas halte tanpa menunggu terlalu lama'),
    Item('Bagaimana Cara HalteTracker?', 'HalteTracker dapat digunakan dengan cara menggunakan aplikasi dan dapt dilihat data secara realtime pada aplikasi '),
    Item('Tim di Balik Aplikasi', ''
        'Evan Susanto - 2006466164 \n'
        'Rizky Rivaldi - 2006466164 \n '
        'Iqbal Risya - 2006466164 \n '
        'Raden Dzakiha - 2006466164 \n  '),
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