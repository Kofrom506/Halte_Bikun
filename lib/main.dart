import 'package:flutter/material.dart';
import 'package:flutter_halte/configs/configs.dart';
import 'package:flutter_halte/screens/about/about_page.dart';
import 'package:flutter_halte/screens/bus_location/bus_location_page.dart';
import 'package:flutter_halte/screens/bus_location/bus_location_page_controller.dart';
import 'package:flutter_halte/screens/chart/chart_page.dart';
import 'package:flutter_halte/screens/home/home_page.dart';
import 'package:flutter_halte/screens/live_view/live_view_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  final List<IconData> _icons = [
    FontAwesomeIcons.house,
    FontAwesomeIcons.cameraRetro,
    FontAwesomeIcons.bus,
    FontAwesomeIcons.lineChart,
    FontAwesomeIcons.infoCircle,
  ];
  Widget? getPage() {
    switch(_currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return LiveViewPage();
      case 2:
        return BusLocationPage();
      case 3:
        return ChartPage();
      case 4:
        return AboutPage();
      default:
        return HomePage();
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          return Scaffold(
              body: getPage(),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 8.0,right: 8.0),
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                     children: _icons.asMap().entries.map((entry) {
                      final index = entry.key;
                      final icon = entry.value;

                      return GestureDetector(
                        onTap: () {
                          if(index!=2) {
                            setState(() {
                              _currentIndex = index;
                            });
                          }
                          else{
                            print("AAAA");
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => BusLocationPage());

                          }
                        },
                        child: Container(
                          padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                          decoration: index == 2
                              ? BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Configs.primaryColor)
                              : null,
                          child: index == 2 ? Icon(
                          icon,
                          size: 25.0,
                          color: Colors.white
                          ) : Icon(
                            icon,
                            size: 25.0,
                            color: _currentIndex == index
                                ? Configs.primaryColor
                                : Configs.navBarColor,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ));
        }
      ),
    );
  }
}
//
// class MyHomePageController extends GetxController {
//   var count = 10.obs;
//   void increment() {
//     count++;
//     update();
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   // const MyHomePage({Key? key}) : super(key: key);
//   final controller = Get.put(MyHomePageController());
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       home: Scaffold(
//           body: SafeArea(
//         child: Column(
//           children: [
//             Obx(() => Text("Number: ${controller.count.value})")),
//
//             FloatingActionButton(onPressed: controller.increment)
//           ],
//         ),
//       )),
//     );
//   }
// }
