import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(WeatherApp());
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherScreen(),
    );
  }
}
class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Map<String, dynamic>? weatherData;
  String selectedCity = 'Bangkok';

  Future<void> fetchWeatherData() async {
    final response = await http.get(
        Uri.parse("https://cpsu-test-api.herokuapp.com/api/1_2566/weather/current?city=$selectedCity"));

    if (response.statusCode == 200) {
      setState(() {
        weatherData = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load weather data');
    }
  }


  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                selectedCity = value;
                fetchWeatherData();
              });
            },
            itemBuilder: (BuildContext context) {
              return ['Bangkok', 'Nakorn Pathom', 'Paris'].map((city) {
                return PopupMenuItem(
                  value: city,
                  child: Text(city),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: weatherData == null
            ? CircularProgressIndicator()
            : WeatherInfo(data: weatherData!),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  final Map<String, dynamic> data;

  WeatherInfo({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('City: ${data['city']}'),
        Text('Temperature: ${data['temperature']}°C'),
        Text('Weather: ${data['description']}'),
      ],
    );
  }
}

