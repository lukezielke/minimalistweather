import 'package:flutter/material.dart';
import 'package:MinimalWeather/models/weathercode.dart';

var weathercodes = {
  "0": {
    "day": {
      "description": "Sunny",
      "image": "assets/images/clear-day.png"
    },
    "night": {
      "description": "Clear",
      "image": "assets/images/clear-night.png"
    }
  },
  "1": {
    "day": {
      "description": "Mainly Sunny",
      "image": "assets/images/clear-day.png"
    },
    "night": {
      "description": "Mainly Clear",
      "image": "assets/images/clear-night.png"
    }
  },
  "2": {
    "day": {
      "description": "Partly Cloudy",
      "image": "assets/images/partly-cloudy-day.png"
    },
    "night": {
      "description": "Partly Cloudy",
      "image": "assets/images/partly-cloudy-night.png"
    }
  },
  "3": {
    "day": {
      "description": "Cloudy",
      "image": "assets/images/cloudy.png"
    },
    "night": {
      "description": "Cloudy",
      "image": "assets/images/cloudy.png"
    }
  },
  "45": {
    "day": {
      "description": "Foggy",
      "image": "assets/images/fog-day.png"
    },
    "night": {
      "description": "Foggy",
      "image": "assets/images/fog-night.png"
    }
  },
  "48": {
    "day": {
      "description": "Rime Fog",
      "image": "assets/images/fog-day.png"
    },
    "night": {
      "description": "Rime Fog",
      "image": "assets/images/fog-night.png"
    }
  },
  "51": {
    "day": {
      "description": "Light Drizzle",
      "image": "assets/images/drizzle.png"
    },
    "night": {
      "description": "Light Drizzle",
      "image": "assets/images/drizzle.png"
    }
  },
  "53": {
    "day": {
      "description": "Drizzle",
      "image": "assets/images/drizzle.png"
    },
    "night": {
      "description": "Drizzle",
      "image": "assets/images/drizzle.png"
    }
  },
  "55": {
    "day": {
      "description": "Heavy Drizzle",
      "image": "assets/images/extreme-drizzle.png"
    },
    "night": {
      "description": "Heavy Drizzle",
      "image": "assets/images/extreme-drizzle.png"
    }
  },
  "56": {
    "day": {
      "description": "Light Freezing Drizzle",
      "image": "assets/images/sleet.png"
    },
    "night": {
      "description": "Light Freezing Drizzle",
      "image": "assets/images/sleet.png"
    }
  },
  "57": {
    "day": {
      "description": "Freezing Drizzle",
      "image": "assets/images/sleet.png"
    },
    "night": {
      "description": "Freezing Drizzle",
      "image": "assets/images/sleet.png"
    }
  },
  "61": {
    "day": {
      "description": "Light Rain",
      "image": "assets/images/rain.png"
    },
    "night": {
      "description": "Light Rain",
      "image": "assets/images/rain.png"
    }
  },
  "63": {
    "day": {
      "description": "Rain",
      "image": "assets/images/rain.png"
    },
    "night": {
      "description": "Rain",
      "image": "assets/images/rain.png"
    }
  },
  "65": {
    "day": {
      "description": "Heavy Rain",
      "image": "assets/images/extreme-rain.png"
    },
    "night": {
      "description": "Heavy Rain",
      "image": "assets/images/extreme-night-rain.png"
    }
  },
  "66": {
    "day": {
      "description": "Freezing Rain",
      "image": "assets/images/extreme-sleet.png"
    },
    "night": {
      "description": "Freezing Rain",
      "image": "assets/images/extreme-night-sleet.png"
    }
  },
  "67": {
    "day": {
      "description": "Freezing Rain",
      "image": "assets/images/extreme-sleet.png"
    },
    "night": {
      "description": "Freezing Rain",
      "image": "assets/images/extreme-night-sleet.png"
    }
  },
  "71": {
    "day": {
      "description": "Light Snow",
      "image": "assets/images/snow.png"
    },
    "night": {
      "description": "Light Snow",
      "image": "assets/images/snow.png"
    }
  },
  "73": {
    "day": {
      "description": "Snow",
      "image": "assets/images/snow.png"
    },
    "night": {
      "description": "Snow",
      "image": "assets/images/snow.png"
    }
  },
  "75": {
    "day": {
      "description": "Heavy Snow",
      "image": "assets/images/extreme-snow.png"
    },
    "night": {
      "description": "Heavy Snow",
      "image": "assets/images/extreme-night-snow.png"
    }
  },
  "77": {
    "day": {
      "description": "Snow Grains",
      "image": "assets/images/extreme-snow.png"
    },
    "night": {
      "description": "Snow Grains",
      "image": "assets/images/extreme-night-snow.png"
    }
  },
  "80": {
    "day": {
      "description": "Light Showers",
      "image": "assets/images/rain.png"
    },
    "night": {
      "description": "Light Showers",
      "image": "assets/images/rain.png"
    }
  },
  "81": {
    "day": {
      "description": "Showers",
      "image": "assets/images/rain.png"
    },
    "night": {
      "description": "Showers",
      "image": "assets/images/rain.png"
    }
  },
  "82": {
    "day": {
      "description": "Heavy Showers",
      "image": "assets/images/extreme-rain.png"
    },
    "night": {
      "description": "Heavy Showers",
      "image": "assets/images/extreme-night-rain.png"
    }
  },
  "85": {
    "day": {
      "description": "Snow Showers",
      "image": "assets/images/snow.png"
    },
    "night": {
      "description": "Snow Showers",
      "image": "assets/images/snow.png"
    }
  },
  "86": {
    "day": {
      "description": "Snow Showers",
      "image": "assets/images/snow.png"
    },
    "night": {
      "description": "Snow Showers",
      "image": "assets/images/snow.png"
    }
  },
  "95": {
    "day": {
      "description": "Thunderstorm",
      "image": "assets/images/thunderstorms.png"
    },
    "night": {
      "description": "Thunderstorm",
      "image": "assets/images/thunderstorms-night.png"
    }
  },
  "96": {
    "day": {
      "description": "Thunderstorm With Hail",
      "image": "assets/images/thunderstorms-extreme-snow.png"
    },
    "night": {
      "description": "Thunderstorm With Hail",
      "image": "assets/images/thunderstorms-night-extreme-snow.png"
    }
  },
  "99": {
    "day": {
      "description": "Thunderstorm With Hail",
      "image": "assets/images/thunderstorms-extreme-snow.png"
    },
    "night": {
      "description": "Thunderstorm With Hail",
      "image": "assets/images/thunderstorms-night-extreme-snow.png"
    }
  }
};

class WeathercodeCoverter {
  Weathercode convertWeathercode(int weathercode, int is_day) {
    var dt = DateTime.now();
    var daytime = "";
    if (is_day == 1) {
      daytime = "day";
    }
    else {
      daytime = "night";
    }

    return Weathercode(
      text: weathercodes[weathercode.toString()]![daytime]!["description"].toString(),
      imagepath: weathercodes[weathercode.toString()]![daytime]!["image"].toString(),
    );
  }
}