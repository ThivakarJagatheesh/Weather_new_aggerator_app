import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:weather_news_aggregator_app/common/api_constants.dart';
import 'package:weather_news_aggregator_app/common/exception.dart';
import 'package:weather_news_aggregator_app/model/news_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  NewsRepository({required this.client,required this.apiConstants});
  final http.Client client;
 final ApiConstants apiConstants;
  Future<News> getNews(String countryCode) async {
    return _getData(
        uri: apiConstants.buildUri(
            endpoint: "everything",
            baseUrl: ApiConstants.newsBaseUurl,
            apiPath: ApiConstants.newsApiPath,
            parametersBuilder: () {
              String apiKey = "2d002190c1124f0595a037cc58eb7240";
              return apiConstants.countryQueryParameters(countryCode, apiKey);
            }),
        builder: (data) {
          debugPrint("data is $data");
          return News.fromJson(data);
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

final newsRepository = Provider<NewsRepository>((ref) {
  return NewsRepository(client: http.Client(),apiConstants: ApiConstants());
});
