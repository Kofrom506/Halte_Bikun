import 'package:get/get.dart';

import '../../models/Data.dart';
import '../../models/weather.dart';
import 'package:flutter_halte/configs/configs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LiveViewPageController extends GetxController {
  var number = 0.obs;
  // RxString imageUrl = "http://desprokel10.ddns.net:1234/latestdetect?a=${number.value}".obs;
  var isLoadingWeather = true.obs;
  var isLoadingLatest = true.obs;

  // var isLoadingImage = true.obs;

  Weather weatherData = Weather();
  DataNow dataNow = DataNow(personCount: 0, dateTime: DateTime.now());

  double lat = -6.359897830104273;
  final double lon = 106.82723430001242;
  final String city = "Depok";
  final String country = "Indonesia";

  var uri = "https://api.openweathermap.org/data/2.5/weather?lat=-6.359897830104273&lon=106.82723430001242&appid=2b7f68fc45158a3eecc242be3998ac85&q=Depok&country=Indonesia&mode=json&units=metric";
  var uriLatest = "http://desprokel10.ddns.net:1234/latest_json";
  var uriChartJson = "http://desprokel10.ddns.net:1234/chart_json";

  // void updateImageUrl() {
  //   imageUrl.value = 'http://desprokel10.ddns.net:1234/latestpic';
  // }

  void onInit() {
    super.onInit();
    fetchDataLatest();
  }



  Future<void> fetchDataLatest() async {
    try {
      isLoadingLatest(true);
      final response = await http.get(Uri.parse(uriLatest));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int personCount = int.tryParse(data['personCount']) ?? 0;
        String dateTime = data['time'];
        DateTime parsedTime = DateTime.parse(dateTime);
        print(data);
        print(dateTime);
        dataNow = DataNow(dateTime: parsedTime, personCount: personCount);
        print(dataNow.personCount);

      }

    }catch(e){
      print(e);
    }
    finally {
      isLoadingLatest(false);
    }
  }
}