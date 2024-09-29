import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather/weather_model.dart';
import 'package:weather/weather_service.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;

  WeatherCubit(this.weatherService) : super(WeatherInitial());

  Weather? weatherModel;

  Future<void> getWeather(String cityName) async {
    emit(WeatherLoading());
    try {
      weatherModel = await weatherService.getWeather(cityName);
      emit(WeatherScuess(weatherModel!, cityName));
    } on DioError catch (dioError) {
      emit(WeatherFaliuere("Network issue: ${dioError.message}"));
    } catch (e) {
      emit(WeatherFaliuere("An unexpected error occurred: $e"));
    }
  }
}
