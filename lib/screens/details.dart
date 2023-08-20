import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:MinimalWeather/methods/get_daily_data.dart';

import '../animations/widget_dot_fade.dart';
import '../methods/get_hourly_data.dart';
import '../methods/convert_weathercode.dart';
import '../models/hourly_weather.dart';
import '../models/daily_weather.dart';

extension E on String {
  String lastChars(int n) => substring(length - n);
}

double lowestTemperature(day0_lowest, day1_lowest) {
  return min(day0_lowest, day1_lowest);
}

double highestTemperature(day0_highest, day1_highest) {
  return max(day0_highest, day1_highest);
}

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  late Future<WeatherHourly> futureWeatherHourly;
  late Future<WeatherDaily> futureWeatherDaily;

  @override
  void initState() {
    super.initState();
    futureWeatherHourly = GetHourly().getHourlyData();
    futureWeatherDaily = GetDaily().getDailyData();
  }

  @override
  var dt = DateTime.now();

  Widget build(BuildContext context) {
    var hour = dt.hour;
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.zero,
          border: Border.all(color: Color(0xffffffff), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SafeArea(
              child: Icon(
                Icons.expand_less,
                color: Colors.grey[400],
                size: 28,
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Text(
                DateFormat('EEEE').format(DateTime.now()).toString(),
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: GoogleFonts.openSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[500]),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
              child: Align(
                  alignment: Alignment.center,
                  child: FutureBuilder<WeatherDaily>(
                    future: futureWeatherDaily,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var imagepath = WeathercodeCoverter()
                            .convertWeathercode(
                                snapshot.data!.daily!.weathercode![0], 1)
                            .imagepath;
                        return Image(
                          image: AssetImage(imagepath),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.cover,
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      // By default, show a loading spinner.
                      return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                    },
                  )),
            ),
            Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.zero,
                border: Border.all(color: Color(0xffffffff), width: 1),
              ),
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                shrinkWrap: false,
                physics: ScrollPhysics(),
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot
                                            .data!.hourly!.weathercode![hour],
                                        snapshot.data!.hourly!.is_day![hour])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot.data!
                                  .hourly!.precipitationProbability?[dt.hour]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot.data!.hourly!.time?[dt.hour]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 1]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 1],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 1])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 1]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 1]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 2]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 2],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 2])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 2]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 2]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 3]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 3],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 3])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 3]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 3]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 4]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 4],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 4])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 4]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 4]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 5]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 5],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 5])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 5]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 5]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 6]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 6],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 6])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 6]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 6]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 7]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 7],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 7])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 7]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 7]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 8]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 8],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 8])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 8]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 8]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 9]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 9],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 9])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 9]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 9]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 10]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 10],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 10])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 10]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 10]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 11]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 11],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 11])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 11]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 11]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 12]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 12],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 12])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 12]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 12]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 13]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 13],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 13])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 13]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 13]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 14]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 14],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 14])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 14]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 14]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 15]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 15],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 15])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 15]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 15]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 16]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 16],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 16])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 16]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 16]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 17]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 17],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 17])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 17]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 17]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 18]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 18],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 18])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 18]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 18]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 19]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 19],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 19])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 19]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 19]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 20]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 20],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 20])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 20]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 20]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 21]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 21],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 21])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 21]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 21]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 22]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 22],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 22])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 22]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 22]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.zero,
                      border: Border.all(color: Color(0xffffffff), width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var temperature = snapshot
                                  .data!.hourly!.temperature?[dt.hour + 23]
                                  .toString();
                              return Text(
                                "$temperature°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        Align(
                          alignment: Alignment(0.0, -0.3),
                          child: FutureBuilder<WeatherHourly>(
                            future: futureWeatherHourly,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var imagepath = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.hourly!
                                            .weathercode![hour + 23],
                                        snapshot
                                            .data!.hourly!.is_day![hour + 23])
                                    .imagepath;
                                return Image(
                                  image: AssetImage(imagepath),
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.fitWidth,
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                            },
                          ),
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitationProbability = snapshot
                                  .data!
                                  .hourly!
                                  .precipitationProbability?[dt.hour + 23]
                                  .toString();
                              return Text(
                                "$precipitationProbability%",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.blue[800]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                        FutureBuilder<WeatherHourly>(
                          future: futureWeatherHourly,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var time = snapshot
                                  .data!.hourly!.time?[dt.hour + 23]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "$time",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Colors.grey[700]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment(-1, 0.0),
                        child: Text(
                          " Temperature max/min",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.grey[900]),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1, 0.0),
                        child: Text(
                          " Sunrise",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.grey[900]),
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, 0.0),
                        child: Text(
                          " Sunset",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.grey[900]),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1, 0.0),
                        child: Text(
                          " Precipitation",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.grey[900]),
                        ),
                      ),
                      Align(
                        alignment: Alignment(-1, 0.0),
                        child: Text(
                          " UV Index",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: GoogleFonts.openSans(
                              fontWeight: FontWeight.w400,
                              fontSize: 17,
                              color: Colors.grey[900]),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Align(
                        alignment: Alignment(1, 0.0),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var max = highestTemperature(
                                      snapshot.data!.daily!.temperature_max?[0],
                                      snapshot.data!.daily!.temperature_max?[1])
                                  .toString();
                              var min = lowestTemperature(
                                      snapshot.data!.daily!.temperature_min?[0],
                                      snapshot.data!.daily!.temperature_min?[1])
                                  .toString();
                              return Text(
                                "       ${max}°/${min}°",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[600]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, 0.0),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var sunrise = snapshot.data!.daily!.sunrise?[0]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "       ${sunrise}",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[600]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, 0.0),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var sunset = snapshot.data!.daily!.sunset?[0]
                                  .lastChars(5)
                                  .toString();
                              return Text(
                                "       ${sunset}",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[600]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, 0.0),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var precipitation_sum = snapshot
                                  .data!.daily!.precipitation_sum?[0]
                                  .toString();
                              return Text(
                                "       ${precipitation_sum}mm",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[600]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment(1, 0.0),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var uv_index =
                                  snapshot.data!.daily!.uv_max?[0].toString();
                              return Text(
                                "       ${uv_index}",
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.openSans(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 17,
                                    color: Colors.grey[600]),
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return WidgetDotFade(color: Colors.lightBlue[300], size: 20.0);
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
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
