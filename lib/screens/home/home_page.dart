import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_halte/configs/configs.dart';
import 'package:flutter_halte/screens/home/home_page_controller.dart';
import 'package:flutter_halte/widgets/DataModal.dart';
import 'package:flutter_halte/widgets/Timer.dart';
import 'package:flutter_halte/widgets/customs/TimerOnly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());

  // const HomePage({Key? key}) : super(key: key);
  // final HomePageController pokemonController = Get.put(HomePageController());

  void onInit() {
    // Get.find<HomePageController>().fetchData();
    // print(homePageController.fetchData());
    // print(Get.find<HomePageController>().parseHistoryFromJson(jsonStr))
  }

  Future<void> _refresh() async {
    homePageController.fetchDataLatest();
    homePageController.fetchDataWeather();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return RefreshIndicator(
      color: Configs.primaryColor,
      onRefresh: _refresh,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Good Morning ☀️",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        Text("Halte Teknik UI Overview.",
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        // FloatingActionButton(
                        //     onPressed: () => {
                        //           homePageController.fetchPokemon(),
                        //           text.value = "Evan"
                        //         }),
                        // Obx(() {
                        //   return Text("Total Poke ${homePageController.dataPoke
                        //       ?.count}");
                        // }),

                        // Obx(() {
                        //   if (homePageController.isLoading.value) {
                        //     return Center(child: CircularProgressIndicator());
                        //   } else {
                        //     print(homePageController.historyData);
                        //     return Text(
                        //       "Evan",
                        //       style: TextStyle(
                        //           fontWeight: FontWeight.bold, height: 10),
                        //     );
                        //   }
                        // })
                        // GetBuilder<HomePageController>(
                        //                     builder: (controller) {
                        //                       return Text("Evan", style: TextStyle(fontWeight: FontWeight.bold,height: 10),);
                        //                     },
                        //                   ),
                        /*Obx(()=>
                          Text(
                            'Counter: ${homePageController.historyData}',
                            style: TextStyle(fontSize: 24),
                          )
                        ),*/
                        // ElevatedButton(
                        //   onPressed: () {
                        //     homePageController.fetchData();
                        //     print(homePageController.weatherData.value.weatherDescription); // Call the function when the button is pressed
                        //   },
                        //   child: Text("Test API"),
                        // ),
                        // Text("Today",
                        //     style: TextStyle(
                        //         fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: _refresh,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        shape: CircleBorder(),
                        primary:
                            Configs.primaryColor, // Set the background color
                      ),
                      child: CircleAvatar(
                        child: Icon(FontAwesomeIcons.arrowsRotate),
                        foregroundColor: Colors.white,
                        backgroundColor: Configs.primaryColor,
                      ),
                    )
                  ]),
                  SizedBox(height: 15),
                  Container(
                    height: screenHeight * 0.12,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Configs.secondaryColor,
                    ),
                    child: Obx(() {
                      if (!homePageController.isLoadingWeather.value) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "${homePageController.weatherData.temp?.toInt() ?? "Loading..."}°",
                                      style: TextStyle(
                                          color: Configs.primaryColor,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      homePageController.capitalizeEachWord(
                                          homePageController.weatherData
                                                  .weatherDescription ??
                                              ""),
                                      style: TextStyle(
                                          color: Configs.navBarColor,
                                          fontSize: 12)),
                                  Text("Beji, Depok ",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15))
                                ]),
                            Spacer(),
                            Container(
                              height: screenHeight * 0.12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amberAccent,
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  "https://openweathermap.org/img/wn/${homePageController.weatherData.iconName}@2x.png",
                                  fit: BoxFit.fitHeight,
                                  height: screenHeight * 0.12,
                                  // color: homePageController.weatherData.iconColor,
                                ),
                              ),
                            ),

                            // Icon(
                            //   Icons.sunny,
                            //   size: screenHeight * 0.05,
                            //   color: Colors.orange,
                            // )
                          ]),
                        );
                      } else {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Configs.primaryColor,
                        ));
                      }
                    }),
                  ),
                  SizedBox(height: 15),
                  Text("Latest Activities️",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  Card(
                    child: Stack(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          'assets/halte_teknik_maps.png',
                          width: double.infinity,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 130),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Configs.primaryColor),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(FontAwesomeIcons.person,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 7.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Current Condition:  "),
                                            Obx(() {
                                              if (!homePageController
                                                  .isLoadingLatest.value) {
                                                return Text(
                                                  "${homePageController.dataNow.personCount} Person",
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              } else {
                                                return Text(
                                                  'Loading...',
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                );
                                              }
                                            }),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Configs.primaryColor,
                                          borderRadius: BorderRadius.circular(
                                              20), // Adjust the radius as needed.
                                        ),
                                        child: TimerWidget(),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("Overview",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(0),
                           // Set the background color
                            shape: CircleBorder(), // Make the button circular
                          ),
                          onPressed: () {
                            homePageController.showModal(context,
                                DataModal(data: homePageController.dataNow));
                          },
                          child: Icon(
                            FontAwesomeIcons.circleInfo,
                            color: Configs.primaryColor,
                          ))
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
                                    if (!homePageController
                                        .isLoadingLatest.value) {
                                      return Text(
                                          "${homePageController.dataNow.personCount}",
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
                                              TimerOnly(
                                                  minutes: 5,
                                                  style: TextStyle(
                                                      fontSize: 30.0,
                                                      fontWeight:
                                                          FontWeight.bold)),
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
                                                if (!homePageController
                                                    .isLoadingWeather.value) {
                                                  return Text(
                                                    '${homePageController.weatherData?.temp?.toInt()}°',
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
                  )
                  // Row(
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.all(30.0),
                  //       child: SizedBox(
                  //         height: 110,
                  //         // child: Image.asset(
                  //         //   "assets/sam.png",
                  //         //   fit: BoxFit.cover,
                  //         // ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(bottom: 120.0),
                  //         child: Container(
                  //           decoration: const BoxDecoration(
                  //             borderRadius: BorderRadius.only(
                  //               bottomRight: Radius.circular(25),
                  //               topLeft: Radius.circular(25),
                  //               topRight: Radius.circular(25),
                  //             ),
                  //             color: Color.fromARGB(255, 116, 63, 63),
                  //           ),
                  //           child: const Padding(
                  //             padding: EdgeInsets.all(12),
                  //             child: CustomText(
                  //               "Lebih baik tunggu ${5} menit.",
                  //               color: Colors.white,
                  //               fontSize: 16,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ]),
          ),
        ),
      ),
    );
  }
}
