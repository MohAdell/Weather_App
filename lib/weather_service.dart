import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:weather/weather_model.dart';

class WeatherService {
  Dio dio = Dio();
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
    final response = await http
        // .get(Uri.parse('$BASE_URL?key=$apiKey&q=$cityName&units=metric'));
        // .get(Uri.parse('$BASE_URL?q=$cityName&appid=$apiKey&units=metric'));
        .get(Uri.parse(
            'http://api.weatherapi.com/v1/forecast.json?key=5f384f5ab7594073b8d192145242509&q=$cityName&aqi=no'));
    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("FAILED TO LOAD WEATHER DATA");
    }
  }

  Future<String> getCurrentCity() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      // desiredAccuracy: LocationAccuracy.high
    );

    List<Placemark> placemark =
        await placemarkFromCoordinates(position.altitude, position.longitude);

    String? city = placemark[0].locality;
    return city ?? "";
  }
}
