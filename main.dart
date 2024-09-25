import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_aggregator_app/common/shared_storage.dart';
import 'package:weather_news_aggregator_app/common/widget/celius_farhenheit_conversion.dart';
import 'package:weather_news_aggregator_app/view/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedStorage.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  final TemperatureUnit temperatureUnit = TemperatureUnit.celsius;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return TemperatureProvider(
      unit: temperatureUnit,
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a purple toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage()),
    );
  }
}
