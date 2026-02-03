import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/utils/app_exception.dart';
import 'package:weather/domain/use_cases/weather_use_case.dart';
import 'package:weather/features/weather_cubit/weather_states.dart';

class WeatherViewModel extends Cubit<WeatherStates> {
  WeatherUseCase weatherUseCase;
  WeatherViewModel({required this.weatherUseCase})
    : super(WeatherInitialState());
  final TextEditingController cityController = TextEditingController();
  String? condition;

  void getWeather({required String cityName}) async {
    try {
      emit(WeatherLoadingState());
      var weather = await weatherUseCase.getWeather(cityName: cityName);
      condition = weather.condition;
      emit(WeatherSuccessState(responseDto: weather));
    } catch (e) {
      log(e.toString());
      if (e is DioException && e.error is AppException) {
        emit(WeatherErrorState(message: (e.error as AppException).message));
      } else {
        emit(WeatherErrorState(message: 'Unexpected error'));
      }
    }
  }

  void searchTap() {
    emit(SearchState());
  }
}
