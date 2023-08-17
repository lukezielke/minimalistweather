import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:MinimalWeather/methods/get_city.dart';
import 'package:MinimalWeather/methods/get_position.dart';
import 'package:MinimalWeather/models/daily_weather.dart';

class GetDaily {
  Future<WeatherDaily> getDailyData() async {
    try {
      Position currentPosition = await GetPosition().getCurrentPosition();
      var url = Uri.https('api.open-meteo.com', '/v1/forecast',
          {
            'latitude': currentPosition.latitude.toString(),
            "longitude": currentPosition.longitude.toString(),
            "daily": "weathercode,temperature_2m_max,temperature_2m_min,sunrise,sunset,uv_index_max,precipitation_sum",
            "timezone": "auto"
          });

      log(url.toString());
      final response = await http.get(url);
      log(response.statusCode.toString());

      if (response.statusCode == 200) {
        // If the server did return a 200 OK response,
        // then parse the JSON.
        log("Check");
        //log(response.body);
        return WeatherDaily.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load daily data');
      }
    }

    catch (e) {
      log(e.toString());
      throw Exception('Failed to load daily data2');
    }
  }
}