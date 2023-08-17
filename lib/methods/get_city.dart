import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:MinimalWeather/methods/get_position.dart';

import '../models/city.dart';

class GetCity {
  Future<City> getCity() async{
    Position currentPosition = await GetPosition().getCurrentPosition();
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude);

    Placemark place = placemarks[0];
    var cityName = place.locality!;
    return City(
      city: cityName,
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );
  }
}

