import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_aggregator_app/domain/forcast_repository.dart';
import 'package:weather_news_aggregator_app/model/forecast_model.dart';


final dailyWeatherProvider = FutureProvider.family<Forecast,String>((ref,param) async {
  
  final forecast =
      await ref.watch(forecastRepository).getForcast(param, 5);
  return forecast;
});