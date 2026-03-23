import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/entities/hour_dto.dart';
import 'package:weather/domain/use_cases/weather_use_case.dart';
import 'package:weather/features/cubit/weather_states.dart';

class WeatherViewModel extends Cubit<WeatherStates> {
  WeatherViewModel({required this.useCase}) : super(InitialState());
  WeatherUseCase useCase;
  List<HourDto> hours = [];
  late String locationCity;

  void getWeatherByCurrentLocation() async {
    try {
      emit(LoadingState());
      var location = await _getCurrentLocation();
      var weather = await useCase.getWeatherByLocation(
        latitude: location.latitude,
        longitude: location.longitude,
      );

      hours =
          weather.forecastDayDto.first.hours
              .where(
                (element) =>
                    DateTime.fromMillisecondsSinceEpoch(
                      weather.localtimeEpoch * 1000,
                    ).hour <=
                    DateTime.fromMillisecondsSinceEpoch(
                      element.timeEpoch * 1000,
                    ).hour,
              )
              .toList();
      hours.addAll(weather.forecastDayDto[1].hours.toList());
      hours =
          weather.forecastDayDto.first.hours
              .where(
                (element) =>
                    DateTime.fromMillisecondsSinceEpoch(
                      weather.localtimeEpoch * 1000,
                    ).hour <=
                    DateTime.fromMillisecondsSinceEpoch(
                      element.timeEpoch * 1000,
                    ).hour,
              )
              .toList();
      hours.addAll(
        weather.forecastDayDto[1].hours
            .where(
              (element) =>
                  DateTime.fromMillisecondsSinceEpoch(
                    weather.localtimeEpoch * 1000,
                  ).compareTo(
                    DateTime.fromMillisecondsSinceEpoch(
                      element.timeEpoch * 1000,
                    ),
                  ) <=
                  0,
            )
            .toList(),
      );

      locationCity = weather.name;
      emit(SuccessState(weather: weather));
    } catch (e) {
      log(e.toString());
      emit(ErrorState(message: e.toString()));
    }
  }

  void getWeatherByCityName(String cityName) async {
    try {
      emit(LoadingState());
      var weather = await useCase.getWeatheByCityName(cityName: cityName);
      hours =
          weather.forecastDayDto.first.hours
              .where(
                (element) =>
                    DateTime.parse(weather.localTime).hour <=
                    DateTime.parse(element.time).hour,
              )
              .toList();
      hours.addAll(weather.forecastDayDto[1].hours.toList());

      emit(SuccessState(weather: weather));
    } catch (e) {
      emit(ErrorState(message: e.toString()));
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // هل ال GPS شغال؟
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      emit(ErrorState(message: 'Location services are disabled.'));
      // throw Exception('Location services are disabled.');
    }

    // صلاحيات
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        emit(ErrorState(message: 'Location permissions are denied'));
        // throw Exception('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      emit(ErrorState(message: 'Location permissions are permanently denied'));

      // throw Exception('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.best),
    );
  }
}
