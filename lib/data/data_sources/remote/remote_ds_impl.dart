import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:weather/core/api/api_constants.dart';
import 'package:weather/data/models/weather_response.dart';
import 'package:weather/data/data_sources/remote/remote_ds.dart';

@Injectable(as: RemoteDs)
class RemoteDsImpl implements RemoteDs {
  Dio dio;
  RemoteDsImpl({required this.dio});
  @override
  Future<WeatherResponse> getWeather({required String city}) async {
    try {
      var response = await dio.get(
        ApiConstants.forcastEndPoint,
        queryParameters: {"q": city, "days": 1},
      );
      WeatherResponse weather = WeatherResponse.fromJson(response.data);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
