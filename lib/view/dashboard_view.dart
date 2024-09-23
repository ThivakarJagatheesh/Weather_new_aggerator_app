import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_news_aggregator_app/model/weather_model.dart';
import 'package:weather_news_aggregator_app/view/home_view.dart';
import 'package:weather_news_aggregator_app/view/setting.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  Coord? coord;
  int currentIndex = 0;
  String currentAddress = "";
  String? countryCode;
  List<Widget> bodyWidget = [];
  late StreamSubscription<Position> getPositionStream;

  @override
  void initState() {
    super.initState();
    getWidget();
  }

  getWidget() {
    bodyWidget = [
      const HomeView(
      ),
     const Setting()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:currentIndex==0? const Text("Dashboard"):const Text("setting"),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: bodyWidget.isNotEmpty
          ? IndexedStack(
              children: [bodyWidget[currentIndex]],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            currentIndex = index;
            setState(() {});
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.dashboard,
                  semanticLabel: "Dashboard",
                ),
                label: "Dashboard"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  semanticLabel: "settings",
                ),
                label: "settings")
          ]),
    );
  }
}
