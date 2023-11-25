import 'package:flutter/material.dart';
import 'package:flutter_halte/models/Data.dart';




import 'package:get/get.dart';
import 'package:meta/meta.dart';

class ChartPageController extends GetxController {
  var isLoadingWeather = true.obs;
  var isLoadingLatest = true.obs;

  HistoryData? weatherData;

  final String uriChartJson = "http://desprokel10.ddns.net:1234/chart_json";


  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;

}