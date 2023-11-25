import 'package:get/get.dart';

import '../../models/Data.dart';
import '../../models/weather.dart';
import 'package:flutter_halte/configs/configs.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LiveViewPageController extends GetxController {
  RxString imageUrl = 'http://desprokel10.ddns.net:1234/latestdetect'.obs;
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

  void updateImageUrl() {
    imageUrl.value = 'http://desprokel10.ddns.net:1234/latestpic';
  }

  void onInit() {
    super.onInit();
    fetchDataWeather();
    fetchDataLatest();
  }

  Future<void> fetchDataWeather() async {
    try {
      isLoadingWeather(true);
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String icon = data['weather'][0]['icon'];
        double lon = data['coord']['lon'];
        double lat = data['coord']['lat'];
        String mainWeather = data['weather'][0]['main'];
        String weatherDescription = data['weather'][0]['description'];
        double temp = data['main']['temp'];
        weatherData = Weather(temp: temp,iconName: icon, iconColor: Colors.white, lat: lat, lon: lon, weatherDescription: weatherDescription, weatherName: mainWeather);
        print(weatherData);

        switch (data.iconName) {
          case '01d':
            weatherData.iconColor =  Colors.blue;
            break;// Clear sky during the day
          case '02d':
            weatherData.iconColor =  Colors.blue;
            break;
          case '03d':
            weatherData.iconColor =  Colors.grey;
            break;
          case '04d':
            weatherData.iconColor =  Colors.grey;
            break;
          case '09d':
            weatherData.iconColor =  Colors.green;
            break;
          case '10d':
            weatherData.iconColor =  Colors.green;
            break;
          case '11d':
            weatherData.iconColor =  Colors.indigo;
            break;
          case '13d':
            weatherData.iconColor =  Colors.lightBlue;
            break;
          case '50d':
            weatherData.iconColor =  Colors.grey;
            break;
          default:
            weatherData.iconColor =  Configs.primaryColor;
        }

        // final results = data['results'] as List<dynamic>;
        //
        // for (var result in results) {
        //   print(result);
        //   final pokemonData = await fetchPokemonData(result['url']);
        //   pokemonList.add(pokemonData);
        // }
        //
        // offset += results.length;
      }

    }catch(e){
      print(e);
    }
    finally {
      isLoadingWeather(false);
    }
  }

  Future<void> fetchDataLatest() async {
    try {
      isLoadingLatest(true);
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        int personCount = data['personCount'];
        String dateTime = data['time'];
        DateTime parsedTime = DateTime.parse(dateTime);
        dataNow = DataNow(dateTime: parsedTime, personCount: personCount);
      }

    }catch(e){
      print(e);
    }
    finally {
      isLoadingLatest(false);
    }
  }
}