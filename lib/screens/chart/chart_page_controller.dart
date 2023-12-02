import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_halte/models/Data.dart';
import 'package:flutter_halte/models/History.dart';
import 'package:http/http.dart' as http;




import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../models/HistoryData.dart';

class ChartPageController extends GetxController {
  var isLoadingWeather = true.obs;
  var isLoadingLatest = true.obs;

  History? history;

  final String uriChartJson = "http://desprokel10.ddns.net:1234/chart_json";

  Future<void> fetchDataLatest() async {
    try {
      isLoadingLatest(true);
      final response = await http.get(Uri.parse(uriChartJson));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        HistoryData oneHour = HistoryData.fromJson(jsonDecode(data['history']['1hrs']));
        HistoryData threeHour = HistoryData.fromJson(jsonDecode(data['history']['3hrs']));
        HistoryData sixHour= HistoryData.fromJson(jsonDecode(data['history']['6hrs']));
        HistoryData twelveHour= HistoryData.fromJson(jsonDecode(data['history']['12hrs']));
        HistoryData oneDay= HistoryData.fromJson(jsonDecode(data['history']['1day']));
        HistoryData threeDay= HistoryData.fromJson(jsonDecode(data['history']['3day']));
        HistoryData sevenDay= HistoryData.fromJson(jsonDecode(data['history']['7day']));

        // int personCount = data['personCount'];
        // String dateTime = data['time'];
        // DateTime parsedTime = DateTime.parse(dateTime);
        history = History(oneDay:oneDay,oneHour: oneHour,sevenDay: sevenDay,sixHour: sixHour,threeDay: threeDay,threeHour: threeHour,twelveHour: twelveHour);
      }

    }catch(e){
      print(e);
    }
    finally {
      isLoadingLatest(false);
    }
  }


}