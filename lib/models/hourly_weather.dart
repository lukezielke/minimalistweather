class WeatherHourly {
  Hourly? hourly;

  WeatherHourly({this.hourly});

  WeatherHourly.fromJson(Map<String, dynamic> json) {
    hourly =
        json['hourly'] != null ? new Hourly.fromJson(json['hourly']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hourly != null) {
      data['hourly'] = this.hourly!.toJson();
    }
    return data;
  }
}

class Hourly {
  List<String>? time;
  List<double>? temperature;
  List<int>? precipitationProbability;
  List<int>? weathercode;
  List<int>? is_day;

  //List<String>? imagepath;
  //List<String>? weather;

  Hourly({
    this.time,
    this.temperature,
    this.precipitationProbability,
    this.weathercode,
    this.is_day,

    //this.imagepath,
    //this.weather,
  });

  Hourly.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    temperature = json['temperature_2m'].cast<double>();
    precipitationProbability = json['precipitation_probability'].cast<int>();
    weathercode = json['weathercode'].cast<int>();
    is_day = json['is_day'].cast<int>();

    //imagepath = weathercodes[weathercode.toString()]?[time.toString()]!["image"];
    //weather = weathercodes[weathercode.toString()]?[time.toString()]!["description"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['temperature_2m'] = this.temperature;
    data['precipitation_probability'] = this.precipitationProbability;
    data['weathercode'] = this.weathercode;
    data['is_day'] = this.is_day;

    //data['imagepath'] = this.imagepath;
    //data['weather'] = this.weather;

    return data;
  }
}
