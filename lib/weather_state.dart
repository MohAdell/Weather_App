part of 'weather_cubit.dart';

@immutable
sealed class WeatherState {}

final class WeatherInitial extends WeatherState {}

final class WeatherLoading extends WeatherState {}

final class WeatherScuess extends WeatherState {
  final Weather model;
  final String cityname;
  WeatherScuess(this.model, this.cityname);
}

final class WeatherFaliuere extends WeatherState {
  final String errmsg;

  WeatherFaliuere(this.errmsg);
}
