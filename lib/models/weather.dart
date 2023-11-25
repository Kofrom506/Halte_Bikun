import 'package:flutter/material.dart';

class Weather {
  final String? weatherName;
  final String? weatherDescription;


  final String? iconName;

  final double? temp;
  final double? lon;
  final double? lat;

  late final Color? iconColor;

  Weather({
    this.weatherName,
    this.temp,
    this.weatherDescription,
    this.iconName,
    this.lon,
    this.lat,
    this.iconColor,
  });
}