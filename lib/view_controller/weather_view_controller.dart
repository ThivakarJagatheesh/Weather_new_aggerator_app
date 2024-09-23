import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_aggregator_app/common/location_service.dart';
import 'package:weather_news_aggregator_app/domain/weather_repository.dart';

import 'package:weather_news_aggregator_app/model/weather_model.dart';

final locationProvider = Provider<LocationService>((ref) => LocationService());
final weatherProvider = FutureProvider.autoDispose<Weather>((ref) async {
  final position = await ref.watch(locationProvider).getCurrentLocation();
  final weather = await ref
      .watch(weatherRepository)
      .getWeather(position.longitude.toString(), position.latitude.toString());
  return weather;
});
