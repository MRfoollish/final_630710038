class WeatherData {
  final String city;
  final String country;
  final DateTime lastUpdated;
  final double tempC;
  final double tempF;
  final double feelsLikeC;
  final double feelsLikeF;
  final double windKph;
  final double windMph;
  final double humidity;
  final int uv;

  WeatherData({
    required this.city,
    required this.country,
    required this.lastUpdated,
    required this.tempC,
    required this.tempF,
    required this.feelsLikeC,
    required this.feelsLikeF,
    required this.windKph,
    required this.windMph,
    required this.humidity,
    required this.uv,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      city: json['city'],
      country: json['country'],
      lastUpdated: json['lastUpdated'],
      tempC: json['tempC'],
      tempF: json['tempF'],
      feelsLikeC: json['feelsLikeC'],
      feelsLikeF: json['feelsLikeF'],
      windKph: json['windKph'],
      windMph: json['windMph'],
      humidity: json['humidity'],
      uv: json['uv'],
    );
  }
}

