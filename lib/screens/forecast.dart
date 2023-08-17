import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:MinimalWeather/methods/convert_weathercode.dart';

import '../methods/get_daily_data.dart';
import '../models/daily_weather.dart';

extension E on String {
  String firstChars(int n) => substring(0, n);
}

class Forecast extends StatefulWidget {
  const Forecast({super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> {
  @override
  late Future<WeatherDaily> futureWeatherDaily;

  void initState() {
    futureWeatherDaily = GetDaily().getDailyData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SafeArea(
            child: Icon(
              Icons.expand_less,
              color: Color(0xff212435),
              size: 24,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var date =
                                    snapshot.data!.daily!.time?[1].toString();
                                return Text(
                                  DateFormat('EEEE')
                                      .format(
                                          DateTime.parse(date!.firstChars(10)))
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey[800]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var weathertext = WeathercodeCoverter()
                                    .convertWeathercode(
                                        snapshot.data!.daily!.weathercode![1],
                                        1)
                                    .text;
                                return Text(
                                  weathertext,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.grey[600]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var date =
                                snapshot.data!.daily!.time?[2].toString();
                                return Text(
                                  DateFormat('EEEE')
                                      .format(
                                      DateTime.parse(date!.firstChars(10)))
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey[800]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var weathertext = WeathercodeCoverter()
                                    .convertWeathercode(
                                    snapshot.data!.daily!.weathercode![2],
                                    1)
                                    .text;
                                return Text(
                                  weathertext,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.grey[600]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var date =
                                snapshot.data!.daily!.time?[3].toString();
                                return Text(
                                  DateFormat('EEEE')
                                      .format(
                                      DateTime.parse(date!.firstChars(10)))
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey[800]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var weathertext = WeathercodeCoverter()
                                    .convertWeathercode(
                                    snapshot.data!.daily!.weathercode![3],
                                    1)
                                    .text;
                                return Text(
                                  weathertext,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.grey[600]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var date =
                                snapshot.data!.daily!.time?[4].toString();
                                return Text(
                                  DateFormat('EEEE')
                                      .format(
                                      DateTime.parse(date!.firstChars(10)))
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey[800]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var weathertext = WeathercodeCoverter()
                                    .convertWeathercode(
                                    snapshot.data!.daily!.weathercode![4],
                                    1)
                                    .text;
                                return Text(
                                  weathertext,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.grey[600]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var date =
                                snapshot.data!.daily!.time?[5].toString();
                                return Text(
                                  DateFormat('EEEE')
                                      .format(
                                      DateTime.parse(date!.firstChars(10)))
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey[800]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var weathertext = WeathercodeCoverter()
                                    .convertWeathercode(
                                    snapshot.data!.daily!.weathercode![5],
                                    1)
                                    .text;
                                return Text(
                                  weathertext,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.grey[600]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var date =
                                snapshot.data!.daily!.time?[6].toString();
                                return Text(
                                  DateFormat('EEEE')
                                      .format(
                                      DateTime.parse(date!.firstChars(10)))
                                      .toString(),
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.grey[800]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                          FutureBuilder<WeatherDaily>(
                            future: futureWeatherDaily,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var weathertext = WeathercodeCoverter()
                                    .convertWeathercode(
                                    snapshot.data!.daily!.weathercode![6],
                                    1)
                                    .text;
                                return Text(
                                  weathertext,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.clip,
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 20,
                                      color: Colors.grey[600]),
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              // By default, show a loading spinner.
                              return const CircularProgressIndicator();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var imagepath = WeathercodeCoverter()
                                  .convertWeathercode(
                                      snapshot.data!.daily!.weathercode![1], 1)
                                  .imagepath;
                              return Image(
                                image: AssetImage(imagepath),
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var imagepath = WeathercodeCoverter()
                                  .convertWeathercode(
                                  snapshot.data!.daily!.weathercode![2], 1)
                                  .imagepath;
                              return Image(
                                image: AssetImage(imagepath),
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var imagepath = WeathercodeCoverter()
                                  .convertWeathercode(
                                  snapshot.data!.daily!.weathercode![3], 1)
                                  .imagepath;
                              return Image(
                                image: AssetImage(imagepath),
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var imagepath = WeathercodeCoverter()
                                  .convertWeathercode(
                                  snapshot.data!.daily!.weathercode![4], 1)
                                  .imagepath;
                              return Image(
                                image: AssetImage(imagepath),
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var imagepath = WeathercodeCoverter()
                                  .convertWeathercode(
                                  snapshot.data!.daily!.weathercode![5], 1)
                                  .imagepath;
                              return Image(
                                image: AssetImage(imagepath),
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                        child: FutureBuilder<WeatherDaily>(
                          future: futureWeatherDaily,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var imagepath = WeathercodeCoverter()
                                  .convertWeathercode(
                                  snapshot.data!.daily!.weathercode![6], 1)
                                  .imagepath;
                              return Image(
                                image: AssetImage(imagepath),
                                height: 80,
                                width: 70,
                                fit: BoxFit.cover,
                              );
                            } else if (snapshot.hasError) {
                              return Text('${snapshot.error}');
                            }
                            // By default, show a loading spinner.
                            return const CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var max = snapshot
                                      .data!.daily!.temperature_max?[1]
                                      .toString();
                                  var min = snapshot
                                      .data!.daily!.temperature_min?[1]
                                      .toString();
                                  return Text(
                                    "${max}°/${min}°",
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
                                return const CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var precipitation_sum = snapshot
                                      .data!.daily!.precipitation_sum?[1]
                                      .toString();
                                  return Text(
                                    "${precipitation_sum}mm",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var max = snapshot
                                      .data!.daily!.temperature_max?[2]
                                      .toString();
                                  var min = snapshot
                                      .data!.daily!.temperature_min?[2]
                                      .toString();
                                  return Text(
                                    "${max}°/${min}°",
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
                                return const CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var precipitation_sum = snapshot
                                      .data!.daily!.precipitation_sum?[2]
                                      .toString();
                                  return Text(
                                    "${precipitation_sum}mm",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var max = snapshot
                                      .data!.daily!.temperature_max?[3]
                                      .toString();
                                  var min = snapshot
                                      .data!.daily!.temperature_min?[3]
                                      .toString();
                                  return Text(
                                    "${max}°/${min}°",
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
                                return const CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var precipitation_sum = snapshot
                                      .data!.daily!.precipitation_sum?[3]
                                      .toString();
                                  return Text(
                                    "${precipitation_sum}mm",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var max = snapshot
                                      .data!.daily!.temperature_max?[4]
                                      .toString();
                                  var min = snapshot
                                      .data!.daily!.temperature_min?[4]
                                      .toString();
                                  return Text(
                                    "${max}°/${min}°",
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
                                return const CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var precipitation_sum = snapshot
                                      .data!.daily!.precipitation_sum?[4]
                                      .toString();
                                  return Text(
                                    "${precipitation_sum}mm",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var max = snapshot
                                      .data!.daily!.temperature_max?[5]
                                      .toString();
                                  var min = snapshot
                                      .data!.daily!.temperature_min?[5]
                                      .toString();
                                  return Text(
                                    "${max}°/${min}°",
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
                                return const CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var precipitation_sum = snapshot
                                      .data!.daily!.precipitation_sum?[5]
                                      .toString();
                                  return Text(
                                    "${precipitation_sum}mm",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var max = snapshot
                                      .data!.daily!.temperature_max?[6]
                                      .toString();
                                  var min = snapshot
                                      .data!.daily!.temperature_min?[6]
                                      .toString();
                                  return Text(
                                    "${max}°/${min}°",
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
                                return const CircularProgressIndicator();
                              },
                            ),
                            FutureBuilder<WeatherDaily>(
                              future: futureWeatherDaily,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var precipitation_sum = snapshot
                                      .data!.daily!.precipitation_sum?[6]
                                      .toString();
                                  return Text(
                                    "${precipitation_sum}mm",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.clip,
                                    style: GoogleFonts.openSans(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.blue[800]),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('${snapshot.error}');
                                }
                                // By default, show a loading spinner.
                                return const CircularProgressIndicator();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
