import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_news_aggregator_app/common/widget/celius_farhenheit_conversion.dart';
import 'package:weather_news_aggregator_app/common/widget/weather_icon_image.dart';
import 'package:weather_news_aggregator_app/model/temp.dart';
import 'package:weather_news_aggregator_app/model/weather_model.dart';
import 'package:weather_news_aggregator_app/view/forecast_view.dart';
import 'package:weather_news_aggregator_app/view/news_view.dart';
import 'package:weather_news_aggregator_app/view_controller/weather_view_controller.dart';

// ignore: must_be_immutable
class WeatherView extends ConsumerWidget {
  WeatherView({super.key});

  double? temperature;
  double? temperatureMax;
  double? temperatureMin;
  Position? location;
  String address = "";
  late AsyncValue<Weather> weatherProviderAsync;
  late TemperatureUnit unit;
  @override
  Widget build(BuildContext context, ref) {
    weatherProviderAsync = ref.watch(weatherProvider);
    unit = TemperatureProvider.of(context)!.unit;
    return weatherProviderAsync.when(
        data: (data) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      if (unit == TemperatureUnit.celsius) {
                        temperature =
                            Temperature.kelvin(data.main!.temp!).celsius;
                        temperatureMax =
                            Temperature.kelvin(data.main!.tempMax!).celsius;
                        temperatureMin =
                            Temperature.kelvin(data.main!.tempMin!).celsius;
                      } else {
                        temperature =
                            Temperature.kelvin(data.main!.temp!).farhenheit;
                        temperatureMax =
                            Temperature.kelvin(data.main!.tempMax!).farhenheit;
                        temperatureMin =
                            Temperature.kelvin(data.main!.tempMin!).farhenheit;
                      }
                      final iconUrl =
                          "https://openweathermap.org/img/wn/${data.weather![0].icon!}@2x.png";
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Now"),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "${temperature!.roundToDouble()} ${unit == TemperatureUnit.celsius ? "\u2103" : "F"}",
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          WeatherIconImage(
                                              iconUrl: iconUrl, size: 40),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "${temperatureMin?.roundToDouble()}${unit == TemperatureUnit.celsius ? "\u2103" : "F"} - ${temperatureMax?.roundToDouble()}${unit == TemperatureUnit.celsius ? "\u2103" : "F"}"),
                                  InkWell(
                                    onTap: () async {
                                      var route = MaterialPageRoute(
                                          builder: (_) => ForecastView(
                                              title: data.name ?? '',
                                              coord: data.coord!));
                                      Navigator.push(context, route);
                                    },
                                    child: const Text(
                                      "View more >>",
                                      style: TextStyle(color: Colors.indigo),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Cloudy",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                    'Humidity: ${data.main!.humidity!.roundToDouble()}%\n'
                                    'Wind: ${data.wind!.speed!.roundToDouble()} m/s',
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: data.weather?.length,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                if (data.main != null)
                  Flexible(
                      child: NewsView(
                    express: Temperature.kelvin(data.main!.temp!).celsius <= 10
                        ? "cold"
                        : Temperature.kelvin(data.main!.temp!).celsius <= 30
                            ? "cool"
                            : "hot",
                  ))
              ],
            ),
        error: (o, s) => Center(child: Text("something went wrong!! $o")),
        loading: () => const Center(child: CircularProgressIndicator()));

    // return locationProviderValue.when(
    //     data: (data) {
    //       weatherProvider = ref.watch(currentWeatherProvider(
    //           Coord(lat: data.latitude, lon: data.longitude)));

    //       return weatherProvider.when(
    //           data: (data) => Column(
    //                 mainAxisSize: MainAxisSize.min,
    //                 children: [
    //                   SizedBox(
    //                     height: 150,
    //                     child: ListView.builder(
    //                       itemBuilder: (context, index) {
    //                         temperature = Temperature.kelvin(data.main!.temp!);
    //                         temperatureMax =
    //                             Temperature.kelvin(data.main!.tempMax!).celsius;
    //                         temperatureMin =
    //                             Temperature.kelvin(data.main!.tempMin!).celsius;
    //                         final iconUrl =
    //                             "https://openweathermap.org/img/wn/${data.weather![0].icon!}@2x.png";
    //                         return Card(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(16.0),
    //                             child: Row(
    //                               mainAxisAlignment:
    //                                   MainAxisAlignment.spaceBetween,
    //                               children: [
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     const Text("Now"),
    //                                     Row(
    //                                       mainAxisAlignment:
    //                                           MainAxisAlignment.spaceBetween,
    //                                       children: [
    //                                         Row(
    //                                           children: [
    //                                             Text(
    //                                               "${temperature?.celsius.roundToDouble()}\u2103",
    //                                               style: const TextStyle(
    //                                                   fontSize: 24,
    //                                                   fontWeight:
    //                                                       FontWeight.bold),
    //                                             ),
    //                                             WeatherIconImage(
    //                                                 iconUrl: iconUrl, size: 40),
    //                                           ],
    //                                         ),
    //                                       ],
    //                                     ),
    //                                     Text(
    //                                         "${temperatureMin?.roundToDouble()}\u2103 - ${temperatureMax?.roundToDouble()}\u2103"),
    //                                     InkWell(
    //                                       onTap: () {
    //                                         Coord coord = Coord(
    //                                             lat: location!.latitude,
    //                                             lon: location!.longitude);
    //                                         var route = MaterialPageRoute(
    //                                             builder: (_) => ForecastView(
    //                                                 title: data.name ?? '',
    //                                                 coord: coord));
    //                                         Navigator.push(context, route);
    //                                       },
    //                                       child: const Text(
    //                                         "View more",
    //                                         style:
    //                                             TextStyle(color: Colors.indigo),
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     const Text("Cloudy",
    //                                         style: TextStyle(
    //                                             fontSize: 14,
    //                                             fontWeight: FontWeight.bold)),
    //                                     Text(
    //                                         "humditiy: ${data.main!.humidity!.toString()}"),
    //                                     Text(
    //                                         "wind: ${data.main!.pressure!.toString()}"),
    //                                   ],
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                         );
    //                       },
    //                       itemCount: data.weather?.length,
    //                     ),
    //                   ),
    //                   const SizedBox(
    //                     height: 10,
    //                   ),
    //                   if (data.main != null)
    //                     Flexible(
    //                         child: NewsView(
    //                       express:
    //                           Temperature.kelvin(data.main!.temp!).celsius <= 10
    //                               ? "cold"
    //                               : Temperature.kelvin(data.main!.temp!)
    //                                           .celsius <=
    //                                       30
    //                                   ? "cool"
    //                                   : "hot",
    //                     ))
    //                 ],
    //               ),
    //           error: (o, s) =>
    //               const Center(child: Text("something went wrong!!")),
    //           loading: () => const Center(child: CircularProgressIndicator()));
    //     },
    //     error: (o, s) => const Center(child: Text("something went wrong!!")),
    //     loading: () => const Center(child: CircularProgressIndicator()));
  }
}
