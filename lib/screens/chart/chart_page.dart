// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'dart:async';
import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_halte/configs/configs.dart';
import 'package:flutter_halte/models/HistoryData.dart';
import 'package:flutter_halte/screens/chart/chart_page_controller.dart';
import 'package:flutter_halte/widgets/Chart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<Color> gradientColors = [
    Configs.primaryColor,
    Configs.tertiaryColor,
  ];
  late HistoryData chartData;
  late int max;
  late int min;

  bool showAvg = false;
  final ChartPageController chartPageController =
  Get.put(ChartPageController());

  @override
  void onInit() async {
    await chartPageController.fetchDataLatest();

    String jsonData = jsonEncode(chartPageController.history?.oneHour);
    chartData = HistoryData.fromJson(chartPageController.historyData1hour);

    print(chartPageController.historyData1hour);
  }

  void initState() {
    max = 22;
    min = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> refresh() async {
      chartPageController.fetchDataLatest();
      print("Refreshed");
    }

    Timer.periodic(Duration(minutes: 5), (Timer timer) {
      refresh();
      print("Refreshed In 5 minute");
    });

    // return SafeArea(
    //   child: Center(
    //         child: LineChart(
    //           LineChartData(
    //             gridData: FlGridData(show: false),
    //             titlesData: FlTitlesData(show: false),
    //             borderData: FlBorderData(
    //               show: true,
    //               border: Border.all(color: const Color(0xff37434d), width: 1),
    //             ),
    //             minX: 0,
    //             maxX: chartData.time.length.toDouble() - 1,
    //             minY: 0,
    //             maxY: 25,
    //             lineBarsData: [
    //               LineChartBarData(
    //
    //                 spots: List.generate(
    //                   chartData.time.length,
    //                       (index) =>
    //                       FlSpot(index.toDouble(),
    //                           double.tryParse(chartData.count[index])!),
    //                 ),
    //                 isCurved: true,
    //                 color: Colors.blue,
    //                 dotData: FlDotData(show: false),
    //                 belowBarData: BarAreaData(show: false),
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //   ),
    // );

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // FloatingActionButton(onPressed: ()=>{
              //   print(chartPageController.historyData1hour)
              // }),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Chart View",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  ElevatedButton(
                      onPressed: refresh,
                      child: Icon(
                        FontAwesomeIcons.arrowsRotate,
                        color: Configs.primaryColor,
                      ))
                ],
              ),
              SizedBox(
                height: 15,
              ),
              // BarChart(
              //   BarChartData(
              //     alignment: BarChartAlignment.spaceAround,
              //     maxY: 10,
              //     barGroups: [
              //       BarChartGroupData(
              //         x: 0,
              //         barRods: [
              //           BarChartRodData(
              //
              //             color: Colors.blue, toY: 5,
              //           ),
              //         ],
              //       ),
              //       BarChartGroupData(
              //         x: 1,
              //         barRods: [
              //           BarChartRodData(
              //             color: Colors.green, toY: 5,
              //           ),
              //         ],
              //       ),
              //       BarChartGroupData(
              //         x: 2,
              //         barRods: [
              //           BarChartRodData(
              //             color: Colors.red, toY: 3,
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),


              Obx(() {

                if (!chartPageController.isLoadingLatest.value) {
                  return Text("Grafik Keramaian: ${chartPageController
                      .typeData} Terakhir",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ));
                }else{
                  return Text("Loading");
                }
              }),
              SizedBox(
                height: 15,
              ),
              Obx(() {
                if (!chartPageController.isLoadingLatest.value) {
                  int number = 2;

                  dynamic data = chartPageController.historyData1hour;

                  switch (chartPageController.typeData) {
                    case "1hrs":
                      data = chartPageController.historyData1hour;
                      break;
                    case "3hrs":
                      data = chartPageController.historyData3hour;
                      break;
                    case "6hrs":
                      data = chartPageController.historyData6hour;
                      break;
                    case "12hrs":
                      data = chartPageController.historyData12hour;
                      break;
                    case "1day":
                      data = chartPageController.historyData1day;
                      break;

                    case "3day":
                      data = chartPageController.historyData3day;
                      break;
                    case "7day":
                      data = chartPageController.historyData7day;
                      break;

                    default:
                      data = chartPageController.historyData1hour;
                      break;
                  }

                  return Stack(
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 1.70,
                        child: LineChart(
                          showAvg
                              ? avgData()
                              : mainData(HistoryData.fromJson(data)),
                        ),
                      ),
                      SizedBox(
                        width: 60,
                        height: 34,
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showAvg = !showAvg;
                            });
                          },
                          child: Text(
                            'avg',
                            style: TextStyle(
                              fontSize: 12,
                              color: showAvg
                                  ? Colors.white.withOpacity(0.5)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
              SizedBox(
                height: 15,
              ),

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "1hrs", refresh()},
                        child: Chip(
                          label: Text("1 Hour"),
                        )),
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "3hrs", refresh()},
                        child: Chip(
                          label: Text("3 Hour"),
                        )),
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "6hrs", refresh()},
                        child: Chip(
                          label: Text("6 Hour"),
                        )),
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "12hrs", refresh()},
                        child: Chip(
                          label: Text("12 Hour"),
                        )),

                    // ElevatedButton(onPressed: refresh,
                    //     child: Text("1 Hrs",style: TextStyle(
                    //       color: Configs.primaryColor,
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.bold,
                    //     ),),
                    //       ),
                    //
                    //
                    // ElevatedButton(onPressed: refresh,
                    //   child: Text("3 Hrs",style: TextStyle(
                    //     color: Configs.primaryColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                    // ),
                    //
                    // ElevatedButton(onPressed: refresh,
                    //   child: Text("6 Hrs",style: TextStyle(
                    //     color: Configs.primaryColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                    // ),
                    // ElevatedButton(onPressed: refresh,
                    //   child: Text("12 Hrs",style: TextStyle(
                    //     color: Configs.primaryColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "1day", refresh()},
                        child: Chip(
                          label: Text("1 Day"),
                        )),
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "3day", refresh()},
                        child: Chip(
                          label: Text("3 Day"),
                        )),
                    InkWell(
                        onTap: () =>
                        {chartPageController.typeData = "7day", refresh()},
                        child: Chip(
                          label: Text("7 Day"),
                        )),
                    //
                    // ElevatedButton(onPressed: refresh,
                    //   child: Text("1 Day",style: TextStyle(
                    //     color: Configs.primaryColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                    // ),
                    // ElevatedButton(onPressed: refresh,
                    //   child: Text("3 Day",style: TextStyle(
                    //     color: Configs.primaryColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                    // ),
                    // ElevatedButton(onPressed: refresh,
                    //   child: Text("7 Day",style: TextStyle(
                    //     color: Configs.primaryColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;

    var data = HistoryData.fromJson(chartPageController.historyData1hour);

    switch (value.toInt()) {
      case 0:
        text = const Text('0 Menit', style: style);
        break;
    // case 28:
    //   text = const Text('12 Jam', style: style);
    //   break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );
    String text;

    switch (value.toInt()) {
      case 0:
        text = min.toString();
        break;
      case 10:
        text = "10";
        break;
      case 20:
        text = "20";
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(HistoryData chartData) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Configs.color1,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Configs.color3,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: chartData.count.length.toDouble() - 1,
      minY: 0,
      maxY: 20,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(
            chartData.time.length,
                (index) =>
                FlSpot(
                    index.toDouble(), double.tryParse(chartData.count[index])!),
          ),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.8))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: const LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1])
                  .lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CapsuleButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  CapsuleButton({required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Configs.primaryColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(4.0, 4.0),
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
              blurRadius: 6.0,
              spreadRadius: 2.0,
            ),
          ], // Change the color as needed
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Button Text Overlay
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
