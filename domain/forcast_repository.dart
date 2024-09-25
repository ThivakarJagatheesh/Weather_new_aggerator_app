import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:weather_news_aggregator_app/common/api_constants.dart';
import 'package:weather_news_aggregator_app/common/exception.dart';
import 'package:weather_news_aggregator_app/model/forecast_model.dart';

class ForecastRepository {
  ForecastRepository({required this.client, required this.apiConstants});
  final http.Client client;
  final ApiConstants apiConstants;

  Future<Forecast> getForcast(String city, int cnt) async {
    return _getData(
        uri: Uri.parse(
            "https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=0173724d4abaaa69d8fdb8d90bf13f5e&units=metric"),
        // uri: apiConstants.forecast(lat, lon, cnt),
        builder: (data) {
          debugPrint("data is $data");
          return Forecast.fromJson(data);
        });
  }

  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      debugPrint("url is $uri");
      final response = await client.get(uri);
      switch (response.statusCode) {
        case 200:
          final data = json.decode(response.body);
          return builder(data);
        case 401:
          throw InvalidApiKeyException();
        case 404:
          throw CityNotFoundException();
        default:
          throw UnknownException();
      }
    } on SocketException catch (_) {
      throw NoInternetConnectionException();
    }
  }
}

final forecastRepository = Provider<ForecastRepository>((ref) {
  return ForecastRepository(
      client: http.Client(), apiConstants: ApiConstants());
});
