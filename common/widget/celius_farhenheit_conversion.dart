import 'package:flutter/material.dart';

enum TemperatureUnit { celsius, fahrenheit }

// ignore: must_be_immutable
class TemperatureProvider extends InheritedWidget {
   TemperatureUnit unit;

  TemperatureProvider({
    super.key,
    required this.unit,
    required super.child,
  });

  static TemperatureProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TemperatureProvider>();
  }

  @override
  bool updateShouldNotify(TemperatureProvider oldWidget) {
    return  oldWidget.unit != unit;
  }
}
