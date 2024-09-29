import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/weather_model.dart';
import 'package:weather/weather_service.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WeatherScreen> {
  final _weatherService = WeatherService('5f384f5ab7594073b8d192145242509');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';
    switch (mainCondition.toLowerCase()) {
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/Weather-windy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/Weather-storm.json';
      case 'thunderstorm':
        return 'assets/rain with thunder.mp4';
      case 'clear':
        return 'assets/Weather-partly cloudy.json';
      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
            ),
            Text(_weather?.cityName ?? 'Loading City...'),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()}°C'),
            Text(_weather?.mainCondition ?? ""),
          ],
        ),
      ),
    );
  }
}
