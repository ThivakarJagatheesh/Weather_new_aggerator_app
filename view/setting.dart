import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_news_aggregator_app/common/shared_storage.dart';
import 'package:weather_news_aggregator_app/common/widget/celius_farhenheit_conversion.dart';
import 'package:weather_news_aggregator_app/view/login_view.dart';

class Setting extends StatefulWidget {
  const Setting({
    super.key,
  });

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  String address = "";
  String username = "";
  late TemperatureUnit currentUnit;
  @override
  void initState() {
    address = "${SharedStorage.getString("name")},";
    address += "${SharedStorage.getString("street")},";

    address += "${SharedStorage.getString("adminStreet")},";
    address += SharedStorage.getString("country");
    username = SharedStorage.getString("username");
   
    super.initState();
  }

  getChangeUnit(TemperatureUnit unit) {
    currentUnit = unit;
      TemperatureProvider.of(context)!.unit = unit;
    debugPrint("current unit is ${currentUnit.index}");
    if (mounted) {
      setState(() {});
    }
  }
@override
  void didChangeDependencies() {
    currentUnit = TemperatureProvider.of(context)!.unit;
    getChangeUnit(currentUnit);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, ref, child) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              color: Colors.blueAccent.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Name "),
                  Text(username),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              padding: const EdgeInsets.only(left: 20),
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              color: Colors.blueAccent.withOpacity(0.1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address "),
                  Text(address),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            ListTile(
              title: const Text('Celsius'),
              leading: Radio<TemperatureUnit>(
                value: TemperatureUnit.celsius,
                groupValue: currentUnit,
                onChanged: (TemperatureUnit? value) {
                  if (value != null) {
                    getChangeUnit(value);
                    //  Navigator.pop(context);
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Fahrenheit'),
              leading: Radio<TemperatureUnit>(
                value: TemperatureUnit.fahrenheit,
                groupValue: currentUnit,
                onChanged: (TemperatureUnit? value) {
                  if (value != null) {
                    getChangeUnit(value);
                    //  Navigator.pop(context);
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                showDialogLogout();
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.only(left: 20),
                alignment: Alignment.centerLeft,
                width: MediaQuery.of(context).size.width,
                color: Colors.blueAccent.withOpacity(0.1),
                child: const Text("LogOut"),
              ),
            ),
          ],
        ),
      );
    });
  }

  showDialogLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: const Text("Are you sure want to logout?"),
          ),
          actions: [
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: const Text("no")),
            ElevatedButton.icon(
                onPressed: () async {
                  await SharedStorage().removeAll();
                  var route =
                      MaterialPageRoute(builder: (_) => const LoginPage());
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(context, route, (r) => false);
                  }
                },
                label: const Text("yes")),
          ],
        );
      },
    );
  }
}
