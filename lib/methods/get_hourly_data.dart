// ignore_for_file: dead_code

import 'dart:convert';
//import 'dart:math';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:MinimalWeather/methods/get_position.dart';
import 'package:MinimalWeather/models/hourly_weather.dart';


class GetHourly {
  Future<WeatherHourly> getHourlyData() async {
    try {
      Position currentPosition = await GetPosition().getCurrentPosition();
      var url = Uri.https('api.open-meteo.com', '/v1/forecast',
          {
            'latitude': currentPosition.latitude.toString(),
            "longitude": currentPosition.longitude.toString(),
            "hourly": "temperature_2m,precipitation_probability,weathercode,is_day",
            "forecast_days": "3",
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
        return WeatherHourly.fromJson(jsonDecode(response.body));
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load hourly data');
      }
    }

    catch (e) {
      log(e.toString());
      throw Exception('Failed to load hourly data2');
    }
  }
  }
