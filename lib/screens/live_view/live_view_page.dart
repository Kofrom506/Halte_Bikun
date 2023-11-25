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

class LiveViewPage extends StatefulWidget {
  @override
  State<LiveViewPage> createState() => _LiveViewPageState();
}

class _LiveViewPageState extends State<LiveViewPage> {
  // const LiveViewPage({Key? key}) : super(key: key);
  final LiveViewPageController liveViewPageController =
  Get.put(LiveViewPageController());

  void onInit() {
    liveViewPageController.fetchDataWeather();
    // liveViewPageController.imageUrl.value =
    // 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/1200px-International_Pok%C3%A9mon_logo.svg.png';
    // print(liveViewPageController.imageUrl.value);
    // print(Get.find<HomePageController>().parseHistoryFromJson(jsonStr))
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;



    Future<void> refresh() async {
      await DefaultCacheManager().removeFile('http://desprokel10.ddns.net:1234/latestdetect');
      liveViewPageController.imageUrl.value = 'http://desprokel10.ddns.net:1234/latestdetect';
      print("Eva");
    }
    Timer.periodic(Duration(minutes: 5), (Timer timer) {
      refresh();

      print("Refreshed Image");
    });

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
                      ElevatedButton(
                        onPressed: ()=>refresh,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          shape: CircleBorder(),
                          primary: Configs.primaryColor, // Set the background color
                        ),
                        child: CircleAvatar(
                          child: Icon(FontAwesomeIcons.arrowsRotate),
                          foregroundColor: Colors.white,
                          backgroundColor: Configs.primaryColor,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Image.network("http://desprokel10.ddns.net:1234/latestdetect"),
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
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.exclamationTriangle, // Error icon
                                            size: 50,
                                            color: Colors.red, // Error icon color
                                          ),
                                          SizedBox(height: screenHeight*0.03,),
                                          Text("Image Fail To Be Loaded !", style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );




                          },
                          '${liveViewPageController.imageUrl.value}?${DateTime.now().millisecondsSinceEpoch.toString()}',
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
                      ElevatedButton(onPressed: refresh,child: Icon(FontAwesomeIcons.circleInfo,color: Configs.primaryColor,))
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
                              padding: const EdgeInsets.all(8.0),
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
                                        'Person',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                  Obx(() {
                                    if (!liveViewPageController
                                        .isLoadingLatest.value) {
                                      return Text(
                                          "${liveViewPageController.dataNow
                                              .personCount}",
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
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Icon(FontAwesomeIcons.bus,
                                                  color: Configs.primaryColor),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Arrival',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Minute',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Card(
                                  elevation: 4.0,
                                  child: Container(
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Icon(FontAwesomeIcons.sun,
                                                  color: Configs.primaryColor),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                'Weather',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                    FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          Spacer(),
                                          Row(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                            children: [
                                              Obx(() {
                                                if (!liveViewPageController
                                                    .isLoadingWeather.value) {
                                                  return Text(
                                                    '${liveViewPageController
                                                        .weatherData?.temp
                                                        ?.toInt()}°',
                                                    style: TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight:
                                                        FontWeight.bold),
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        8.0),
                                                    child:
                                                    CircularProgressIndicator(
                                                        color: Configs
                                                            .primaryColor),
                                                  );
                                                }
                                              }),
                                              Text(
                                                'Celsius',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
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
