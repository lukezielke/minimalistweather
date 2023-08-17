class WeatherDaily {
  Daily? daily;

  WeatherDaily({this.daily});

  WeatherDaily.fromJson(Map<String, dynamic> json) {
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}

class Daily {
  List<String>? time;
  List<int>? weathercode;
  List<double>? temperature_max;
  List<double>? temperature_min;
  List<String>? sunrise;
  List<String>? sunset;
  List<double>? uv_max;
  List<double>? precipitation_sum;

  Daily({
    this.time,
    this.weathercode,
    this.temperature_max,
    this.temperature_min,
    this.sunrise,
    this.sunset,
    this.uv_max,
    this.precipitation_sum,
  });

  Daily.fromJson(Map<String, dynamic> json) {
    time = json['time'].cast<String>();
    weathercode = json['weathercode'].cast<int>();
    temperature_max = json['temperature_2m_max'].cast<double>();
    temperature_min = json['temperature_2m_min'].cast<double>();
    sunrise = json['sunrise'].cast<String>();
    sunset = json['sunset'].cast<String>();
    uv_max = json['uv_index_max'].cast<double>();
    precipitation_sum = json['precipitation_sum'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['weathercode'] = this.weathercode;
    data['temperature_2m_max'] = this.temperature_max;
    data['temperature_2m_min'] = this.temperature_min;
    data['sunrise'] = this.sunrise;
    data['sunset'] = this.sunset;
    data['uv_index_max'] = this.uv_max;
    data['precipitation_sum'] = this.precipitation_sum;
    return data;
  }
}
