import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_halte/models/Data.dart';
import 'package:flutter_halte/models/History.dart';
import 'package:http/http.dart' as http;




import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../models/HistoryData.dart';

class ChartPageController extends GetxController {

  var isLoadingLatest = true.obs;


  dynamic  historyData1hour = "";
  dynamic  historyData3hour = "";
  dynamic  historyData6hour = "";
  dynamic  historyData12hour = "";
  dynamic  historyData1day = "";
  dynamic  historyData3day = "";
  dynamic  historyData7day = "";
  int length = 0;

  String typeData = "1hrs";


  void onInit() {
    print("Call API Chart");
    super.onInit();
    fetchDataLatest();
  }
  History? history;

  final String uriChartJson = "http://desprokel10.ddns.net:1234/chart_json";

  Future<void> fetchDataLatest() async {
    try {
      isLoadingLatest(true);
      final response = await http.get(Uri.parse(uriChartJson));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print(data);

        historyData1hour = data['history']['1hrs'];
        historyData3hour = data['history']['3hrs'];
        historyData6hour = data['history']['6hrs'];
        historyData12hour = data['history']['12hrs'];
        historyData1day = data['history']['1day'];
        historyData3day = data['history']['3day'];
        historyData7day = data['history']['7day'];




        // HistoryData oneHour = HistoryData.fromJson(jsonDecode(data['history']['1hrs']));
        // HistoryData threeHour = HistoryData.fromJson(jsonDecode(data['history']['3hrs']));
        // HistoryData sixHour= HistoryData.fromJson(jsonDecode(data['history']['6hrs']));
        // HistoryData twelveHour= HistoryData.fromJson(jsonDecode(data['history']['12hrs']));
        // HistoryData oneDay= HistoryData.fromJson(jsonDecode(data['history']['1day']));
        // HistoryData threeDay= HistoryData.fromJson(jsonDecode(data['history']['3day']));
        // HistoryData sevenDay= HistoryData.fromJson(jsonDecode(data['history']['7day']));
        //
        //
        // history = History(oneDay:oneDay,oneHour: oneHour,sevenDay: sevenDay,sixHour: sixHour,threeDay: threeDay,threeHour: threeHour,twelveHour: twelveHour);
        // print(historyData1hour);
        // print(historyData3hour);
        // print(historyData6hour);
      }

    }catch(e){
      print(e);
    }
    finally {
      isLoadingLatest(false);
    }
  }


}