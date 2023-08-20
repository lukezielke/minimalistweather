import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:MinimalWeather/methods/get_hourly_data.dart';
import 'package:MinimalWeather/methods/convert_weathercode.dart';
import 'package:MinimalWeather/models/city.dart';
import 'package:MinimalWeather/methods/get_city.dart';
import 'package:MinimalWeather/models/hourly_weather.dart';

import '../animations/widget_dot_fade.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

class _StartState extends State<Start> {
  late Future<WeatherHourly> futureWeatherHourly;
  late Future<City> futureCity;

  @override
  void initState() {
    super.initState();
    futureCity = GetCity().getCity();
    futureWeatherHourly = GetHourly().getHourlyData();
  }

  @override
  var dt = DateTime.now();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: Color(0x4d9e9e9e), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeArea(
              child: FutureBuilder<City>(
                future: futureCity,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.city.toString(),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: GoogleFonts.openSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[500]));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a loading spinner.
                  return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Align(
                  alignment: Alignment(0.7, -0.7),
                  child: FutureBuilder<WeatherHourly>(
                    future: futureWeatherHourly,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var imagepath = WeathercodeCoverter()
                            .convertWeathercode(
                                snapshot.data!.hourly!.weathercode![dt.hour],
                                snapshot.data!.hourly!.is_day![dt.hour])
                            .imagepath;
                        return Image(
                          image: AssetImage(imagepath!),
                          height: MediaQuery.of(context).size.height * 0.45,
                          width: MediaQuery.of(context).size.width *
                              0.7000000000000001,
                          fit: BoxFit.cover,
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                    },
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Align(
                alignment: Alignment(-0.77, -0.0),
                child: FutureBuilder<WeatherHourly>(
                  future: futureWeatherHourly,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      var temperature = snapshot
                          .data!.hourly!.temperature?[dt.hour]
                          .toString();
                      return Text("$temperature°",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontSize: 70,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[700]));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    // By default, show a loading spinner.
                    return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Align(
                alignment: Alignment(-0.7, 0.0),
                child: FutureBuilder<WeatherHourly>(
                    future: futureWeatherHourly,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var text = WeathercodeCoverter()
                            .convertWeathercode(
                                snapshot.data!.hourly!.weathercode![dt.hour],
                                snapshot.data!.hourly!.is_day![dt.hour])
                            .text;
                        return Text(
                          text!,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[500]),
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Icon(
                Icons.expand_more,
                color: Colors.grey[400],
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
