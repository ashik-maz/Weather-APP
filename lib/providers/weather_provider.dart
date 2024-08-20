import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/weather_model.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherModel? weatherData;
  String? cityName;

  Future<void> fetchWeatherData(String city) async {
    final String baseUrl = 'http://api.weatherapi.com/v1';
    final String apiKey = '865394b2a7214003a60134500242008';
    final String url = '$baseUrl/forecast.json?key=$apiKey&q=$city&days=1';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      weatherData = WeatherModel.fromJson(data);
      cityName = city;
      notifyListeners();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
