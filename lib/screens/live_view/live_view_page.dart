import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_halte/screens/live_view/live_view_page_controller.dart';
import 'package:flutter_halte/widgets/GalleryCard.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../configs/configs.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:math' as math;
import '../../widgets/customs/TimerOnly.dart';

class LiveViewPage extends StatefulWidget {
  @override
  State<LiveViewPage> createState() => _LiveViewPageState();
}

class _LiveViewPageState extends State<LiveViewPage> {
  // const LiveViewPage({Key? key}) : super(key: key);
  final LiveViewPageController liveViewPageController =
  Get.put(LiveViewPageController());

  void onInit() {
    liveViewPageController.fetchDataLatest();
    // liveViewPageController.imageUrl.value =
    // 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1200px-International_Pok%C3%A9mon_logo.svg.png';
    // print(liveViewPageController.imageUrl.value);
    // print(Get.find<HomePageController>().parseHistoryFromJson(jsonStr))
  }

  Future<void> refresh() async {
    liveViewPageController.fetchDataLatest();
    print(liveViewPageController.dataNow.personCount);
    liveViewPageController.number.value += 1;
    print("Refreshed");
  }


  @override
  void initState() {
    Timer.periodic(Duration(minutes: 5), (Timer timer) {
      refresh();
      print("Refreshed In 5 minute");
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;



    return RefreshIndicator(
      onRefresh: refresh,
      child: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 10.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Text("Live View Gallery",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                      ElevatedButton(onPressed: refresh,
                          child: Icon(FontAwesomeIcons.arrowsRotate,
                            color: Configs.primaryColor,))
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // Obx(() {
                  //   return Image.network(
                  //       "http://desprokel10.ddns.net:1234/latestdetect?a=${liveViewPageController
                  //           .number}");
                  // }),
                  // FloatingActionButton(onPressed: refresh),
                  // NetworkImage(liveViewPageController.imageUrl.value),
                  Obx(() {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(
                            18.0), // Adjust the radius as needed
                        child:
                        // Use the Obx widget to listen for changes in the imageUrl
                        Image.network(
                          errorBuilder: (context, error, stackTrace) {
                            return
                              Center(
                                child: Card(
                                  child: Container(
                                    width: double.infinity,
                                    height: screenHeight * 0.2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.exclamationTriangle,
                                          // Error icon
                                          size: 50,
                                          color: Colors.red, // Error icon color
                                        ),
                                        SizedBox(height: screenHeight * 0.03,),
                                        Text("Image Fail To Be Loaded !",
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          },
                          "http://desprokel10.ddns.net:1234/latestdetect?data=${liveViewPageController.number}",
                          fit: BoxFit.cover,
                        ));
                  }),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text("Image Info",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      ElevatedButton(onPressed: refresh,
                          child: Icon(FontAwesomeIcons.circleInfo,
                            color: Configs.primaryColor,))
                      // Text("View All",
                      //     style: TextStyle(
                      //       color: Colors.grey,
                      //       fontSize: 13,
                      //     )),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 4.0,
                          child: Container(
                            height: 200,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,

                                    children: [
                                      Icon(FontAwesomeIcons.peopleGroup,
                                          color: Configs.primaryColor),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Person',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,),
                                      )
                                    ],
                                  ),
                                  Obx(() {
                                    if (!liveViewPageController
                                        .isLoadingLatest.value) {
                                      return Text(
                                          "${liveViewPageController.dataNow.personCount}",
                                          style: TextStyle(
                                              fontSize: 100.0,
                                              fontWeight: FontWeight.bold));
                                    } else {
                                      return Text('Loading...',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold));
                                    }
                                  }),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          height: 200,
                          child: Column(
                            children: [
                              Expanded(
                                child: Card(
                                  elevation: 4.0,
                                  child: Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Icon(FontAwesomeIcons.peopleGroup,
                                                  color: Configs.primaryColor),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Condition',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.bold),
                                              )
                                            ],
                                          ),

                                          Obx(() {
                                            if (!liveViewPageController
                                                .isLoadingLatest.value) {
                                              String getSizeDescription(int num) {
                                                if (num > 5) {
                                                  return 'Ramai';
                                                } else {
                                                  return 'Sepi';
                                                }
                                              }
                                              return Column(
                                                children: [
                                                  SizedBox(height: 10),
                                                  if (liveViewPageController.dataNow.personCount <= 5)
                                                    Image.asset("assets/sepi.jpg"),
                                                  if (liveViewPageController.dataNow.personCount > 5)
                                                    Image.asset("assets/ramai.png"),
                                                  SizedBox(height: 10),
                                                  Text(
                                                      getSizeDescription(liveViewPageController.dataNow.personCount),
                                                      style: TextStyle(
                                                          fontSize: 20.0,
                                                          fontWeight: FontWeight.w500
                                                      )),
                                                ],
                                              );
                                            } else {
                                              return Text('Loading...',
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.bold));
                                            }
                                          }),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),


                    ],
                  ),
                  // SpeedometerWidget(value: 1),
                  // Image.network("http://desprokel10.ddns.net:1234/latestpic"),
                ],

              ),
            )

          // ListView(children: [Container()],)
          //     MasonryGridView.count(
          // crossAxisCount: 4,
          // mainAxisSpacing: 4,
          // crossAxisSpacing: 4,
          // itemBuilder: (context, index) {
          //   return Container(height: 30,color: Configs.color2);
          // },
          // )

        ),
      ),
    );
  }
}

class SpeedometerWidget extends StatelessWidget {
  final int value;

  SpeedometerWidget({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      height: 150.0,
      child: CustomPaint(
        painter: SpeedometerPainter(value: value),
      ),
    );
  }
}

class SpeedometerPainter extends CustomPainter {
  final int value;

  SpeedometerPainter({required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = Colors.red
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    final Paint outlinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double centerX = size.width / 2;
    final double centerY = size.height / 2;
    final double radius = size.width / 2 - 5.0;

    // Draw the outline
    canvas.drawCircle(Offset(centerX, centerY), radius, outlinePaint);

    // Calculate the sweep angle based on the value
    final double sweepAngle = math.min(1.0, value / 10.0) * 180.0;

    // Draw the filled arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      math.pi,
      _degreesToRadians(sweepAngle),
      true,
      fillPaint,
    );
  }

  double _degreesToRadians(double degrees) {
    return degrees * math.pi / 180.0;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}