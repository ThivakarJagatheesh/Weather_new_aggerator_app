import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_news_aggregator_app/common/api_constants.dart';
import 'package:weather_news_aggregator_app/common/exception.dart';
import 'package:weather_news_aggregator_app/model/weather_model.dart'
    as weather;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  WeatherRepository({required this.client, required this.apiConstants});
  final http.Client client;
  final ApiConstants apiConstants;

  Future<weather.Weather> getWeather(
    String lon,
    String lat,
  ) async {
    return _getData(
        uri: apiConstants.weather(lat,lon
        ),
        builder: (data) => weather.Weather.fromJson(data));
  }



  Future<T> _getData<T>({
    required Uri uri,
    required T Function(dynamic data) builder,
  }) async {
    try {
      debugPrint("uri is $uri");
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

final weatherRepository = Provider<WeatherRepository>((ref) {
  return WeatherRepository(client: http.Client(), apiConstants: ApiConstants());
});
