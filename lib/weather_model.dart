class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final DateTime lastUpdate;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition,
      required this.lastUpdate});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainCondition: json['weather'][0]['main'],
      lastUpdate: DateTime.parse(json['current']['last_updated']),
    );
  }
}
