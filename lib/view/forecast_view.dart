import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weather_news_aggregator_app/model/forecast_model.dart';
import 'package:weather_news_aggregator_app/model/temp.dart';
import 'package:weather_news_aggregator_app/model/weather_model.dart'
    as weather;
import 'package:weather_news_aggregator_app/view_controller/forecast_view_controller.dart';

class ForecastView extends ConsumerStatefulWidget {
  const ForecastView({super.key, required this.title, required this.coord});
  final String title;
  final weather.Coord coord;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return ForecastViewState();
  }
}

class ForecastViewState extends ConsumerState<ForecastView> {
  String? title;
  late weather.Coord coord;
  @override
  void initState() {
    title = widget.title;
    coord = widget.coord;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dailyWeatherProviderValue =
        ref.watch(dailyWeatherProvider(widget.title));
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: dailyWeatherProviderValue.when(
          data: (dataValue) {
            final data = _parseForecast(dataValue.list!);
            return ListView.separated(
                itemCount: data.length,
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(
                      DateFormat('EEEE hh:mm a')
                          .format(DateTime.parse(data[index].date)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Temp: "
                            "${Temperature.kelvin(data[index].temperature).celsius.roundToDouble()} \u2103"),
                        Text(
                          'Humidity: ${data[index].humidity.roundToDouble()}%\n'
                          'Wind: ${data[index].windSpeed.roundToDouble()} m/s',
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                });
          },
          error: (o, s) => const Center(child: Text("something went wrong!!")),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }

  List<WeatherForecast> _parseForecast(List<ListElement> list) {
    Map<String, List<WeatherForecast>> dailyForecasts = {};

    for (var item in list) {
      String date =
          item.dtTxt.toString().split(' ')[0]; // Get only the date part
      if (!dailyForecasts.containsKey(date)) {
        dailyForecasts[date] = [];
      }
  
      Map<String,dynamic> map = {
        "dt_txt":date,
        'main':{
          "temp":item.main!.temp,
          "humidity":item.main!.humidity!.toDouble()
        },
        'wind':{
          "speed":item.wind!.speed
        }
      };
      dailyForecasts[date]!.add(WeatherForecast.fromJson(map));
    }

    // Convert the map to a list of WeatherForecast for each day
    return dailyForecasts.entries.map((entry) {
      String date = entry.key;
      List<WeatherForecast> forecasts = entry.value;
      double avgTemp =
          forecasts.map((f) => f.temperature).reduce((a, b) => a + b) /
              forecasts.length;
      double avgHumidity =
          forecasts.map((f) => f.humidity).reduce((a, b) => a + b) /
              forecasts.length;
      double avgWindSpeed =
          forecasts.map((f) => f.windSpeed).reduce((a, b) => a + b) /
              forecasts.length;

      return WeatherForecast(
        date: date,
        temperature: avgTemp,
        humidity: avgHumidity,
        windSpeed: avgWindSpeed,
      );
    }).toList();
  }
}

class WeatherForecast {
  final String date;
  final double temperature;
  final double humidity;
  final double windSpeed;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: json['dt_txt'],
      temperature: json['main']['temp'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
    );
  }
}
