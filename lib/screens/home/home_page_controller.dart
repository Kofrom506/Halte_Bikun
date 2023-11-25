import 'package:flutter/material.dart';
import 'package:flutter_halte/models/Data.dart';
import 'package:flutter_halte/models/weather.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../configs/configs.dart';

class HomePageController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchDataWeather();
    fetchDataLatest();
  }
  void showModal(BuildContext context, Widget modalContent) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return modalContent;
      },
    );
  }

  var isLoadingWeather = true.obs;
  var isLoadingLatest = true.obs;

  // var isLoadingImage = true.obs;

  Weather weatherData = Weather();
  DataPoke dataPoke = DataPoke(count: 10);
  DataNow dataNow = DataNow(personCount: 0, dateTime: DateTime.now());

  double lat = -6.359897830104273;
  final double lon = 106.82723430001242;
  final String city = "Depok";
  final String country = "Indonesia";

  var uri = "https://api.openweathermap.org/data/2.5/weather?lat=-6.359897830104273&lon=106.82723430001242&appid=2b7f68fc45158a3eecc242be3998ac85&q=Depok&country=Indonesia&mode=json&units=metric";
  var uriLatest = "http://desprokel10.ddns.net:1234/latest_json";
  var uriChartJson = "http://desprokel10.ddns.net:1234/chart_json";


  @override


  String capitalizeEachWord(String input) {
    List<String> words = input.split(' ');

    for (int i = 0; i < words.length; i++) {
      if (words[i].isNotEmpty) {
        words[i] = words[i][0].toUpperCase() + words[i].substring(1);
      }
    }

    return words.join(' ');
  }


  Future<void> fetchImage() async {
    // try{
    //   isLoading(true)
    // }
  }

  // Future<void> fetchPokemon() async {
  //   try{
  //     isLoadingPoke(true);
  //     final response = await http.get(Uri.parse("https://pokeapi.co/api/v2/pokemon?limit=20&offset=2"));
  //     if(response.statusCode == 200){
  //       final data = json.decode(response.body);
  //       print(data["count"]);
  //       dataPoke = DataPoke(count: data["count"]);
  //       print(dataPoke?.count);
  //       // Rx<DataPoke>? rxDataPoke = Rx<DataPoke>(dataPoke);
  //     }
  //   }finally{
  //     isLoadingPoke(false);
  //   }
  // }

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
//   Data parseDataFromJson(String jsonStr) {
//     final Map<String, dynamic> jsonData = json.decode(jsonStr);
//
//     return Data(
//       dataNow: DataNow(
//         count: jsonData['now']['count'],
//         dateTime: DateTime.parse(jsonData['now']['date']),
//       ),
//     );
//   }
//
// // Function to convert JSON response to History model
//   History parseHistoryFromJson(String jsonStr) {
//     final Map<String, dynamic> jsonData = json.decode(jsonStr);
//
//     return History(
//       oneHour: parseHistoryDataFromJson(jsonData['history']['1hrs']),
//       threeHour: parseHistoryDataFromJson(jsonData['history']['3hrs']),
//       sixHour: parseHistoryDataFromJson(jsonData['history']['6hrs']),
//       twelveHour: parseHistoryDataFromJson(jsonData['history']['12hrs']),
//       oneDay: parseHistoryDataFromJson(jsonData['history']['1day']),
//       threeDay: parseHistoryDataFromJson(jsonData['history']['3day']),
//       sevenDay: parseHistoryDataFromJson(jsonData['history']['7day']),
//     );
//   }
//
// // Function to convert JSON response to HistoryData model
//   HistoryData parseHistoryDataFromJson(Map<String, dynamic> jsonData) {
//     return HistoryData(
//       length: jsonData['length'],
//       time: List<DateTime>.from(jsonData['time'].map((time) => DateTime.parse(time))),
//       count: List<int>.from(jsonData['count']),
//     );
//   }
//
//   Future<Data> fetchData() async {
//     final String assetPath = 'assets/latest.json';
//
//     try {
//       isLoading(true);
//       final response = await rootBundle.loadString(assetPath);
//       final data = json.decode(response);
//       print(data);
//
//       int personCount = int.tryParse(data['personCount'] ?? '') ?? 0;
//       DateTime time = DateTime.parse(data['time']);
//       historyData?.value = Data(dataNow: DataNow(count: personCount, dateTime: time));
//
//       return Data(dataNow: DataNow(count: personCount, dateTime: time));
//
//
//       return data;
//     //   if (response.statusCode == 200) {
//     //
//     //
//     //
//     //     // weatherData = Weather(iconName: icon, backgroundColor: Colors.white, lat: lat, lon: lon, weatherDescription: weatherDescription, weatherName: mainWeather) as Rx<Weather>;
//     //     //
//     //
//     //     // final results = data['results'] as List<dynamic>;
//     //     //
//     //     // for (var result in results) {
//     //     //   print(result);
//     //     //   final pokemonData = await fetchPokemonData(result['url']);
//     //     //   pokemonList.add(pokemonData);
//     //     // }
//     //     //
//     //     // offset += results.length;
//     //   }
//     } finally {
//       isLoading(false);
//     }
//   }




  String getWeatherConditionName(String iconCode) {
    switch (iconCode) {
      case '01d':
        return 'Clear sky';
      case '02d':
        return 'Few clouds';
      case '03d':
        return 'Scattered clouds';
      case '04d':
        return 'Broken clouds';
      case '09d':
        return 'Shower rain';
      case '10d':
        return 'Rain';
      case '11d':
        return 'Thunderstorm';
      case '13d':
        return 'Snow';
      case '50d':
        return 'Mist';
      default:
        return 'Unknown';
    }
  }





  // Future<Pokemon> fetchPokemonData(String url) async {
  //   final response = await http.get(Uri.parse(url));
  //
  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final types = data['types']
  //         .map((type) => type['type']['name'])
  //         .cast<String>()
  //         .toList();
  //     final abilities = data['abilities']
  //         .map((ability) => ability['ability']['name'])
  //         .cast<String>()
  //         .toList();
  //
  //     final baseStatsData = (data['stats'] as List).map(
  //           (stat) => MapEntry<String, int>(
  //         stat['stat']['name'],
  //         stat['base_stat'],
  //       ),
  //     );
  //
  //     final baseStats = Map.fromEntries(baseStatsData);
  //     final Color pokeColor;
  //
  //     switch (types[0]) {
  //       case 'grass':
  //         pokeColor = Colors.green;
  //       case 'fire':
  //         pokeColor = Colors.red;
  //       case 'water':
  //         pokeColor = Colors.blue;
  //       case 'electric':
  //         pokeColor = Colors.teal;
  //       case 'psychic':
  //         pokeColor = Colors.purple;
  //       case 'rock':
  //         pokeColor = Colors.brown;
  //       case 'ice':
  //         pokeColor = Colors.cyan;
  //       case 'ghost':
  //         pokeColor = Colors.indigo;
  //       case 'bug':
  //         pokeColor = Colors.orange;
  //       case 'dark':
  //         pokeColor = Colors.black;
  //       case 'dragon':
  //         pokeColor = Colors.purpleAccent;
  //       default:
  //         pokeColor = Colors.grey;
  //     }
  //
  //     return Pokemon(
  //         name: data['name'],
  //         id: data['id'],
  //         types: types,
  //         height: data['height'] / 10,
  //         weight: data['weight'] / 10,
  //         abilities: abilities,
  //         baseStats: baseStats,
  //         backgroundColor: pokeColor);
  //   } else {
  //     throw Exception('err');
  //   }
  // }
}


