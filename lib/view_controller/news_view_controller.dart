import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_aggregator_app/domain/news_repository.dart';
import 'package:weather_news_aggregator_app/model/news_model.dart';

// Define a FutureProvider with family 
final fetchProvider = FutureProvider.family<News, String>((ref, param) async {
  final news = await ref.watch(newsRepository).getNews(param);
  return news;
});



