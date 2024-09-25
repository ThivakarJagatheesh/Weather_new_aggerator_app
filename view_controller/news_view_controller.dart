import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_aggregator_app/domain/news_repository.dart';
import 'package:weather_news_aggregator_app/model/news_model.dart';

// Define a FutureProvider with family
final fetchProvider = FutureProvider.autoDispose.family<News, String>((ref, param) async {
  final news = await ref.watch(newsRepository).getNews(param);
 // await NaturalLanguage().getDominantLanguage(null);
  return news;
});

class NaturalLanguage {
  static final NaturalLanguage _naturalLanguage = NaturalLanguage._internal();

  factory NaturalLanguage() {
    return _naturalLanguage;
  }
  NaturalLanguage._internal();

  Future<String> getDominantLanguage(String? text) async {
    final result = await _naturalLanguage.getDominantLanguage(text != null
        ? ""
        : "AC usage is a real drain on the grid... and your wallet. Here's how I harness cross-ventilation to cool my room and save energy in the process.");
    debugPrint("res is $result");
    return result;
  }
}
