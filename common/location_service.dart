import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_news_aggregator_app/common/shared_storage.dart';

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied.');
        }
      }
    }
    var position = await Geolocator.getCurrentPosition(
        locationSettings:
            const LocationSettings(accuracy: LocationAccuracy.high));

    await getAddress(position);
    return position;
  }

  Future<void> getAddress(Position position) async {
    // Geolocator.getPositionStream().listen((position) async{
    final placemark =
        await placemarkFromCoordinates(position.latitude, position.latitude);
    var address = placemark.first;
    await SharedStorage.setString('name', address.name.toString());
    await SharedStorage.setString('street', address.street.toString());
    await SharedStorage.setString(
        'adminStreet', address.administrativeArea.toString());
    await SharedStorage.setString('country', address.country.toString());
    // });
  }
}
