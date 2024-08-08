import 'package:flutter/material.dart';
import '../Services/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Map<String, dynamic>? _weatherData;
  String? _errorMessage;

  Map<String, dynamic>? get weatherData => _weatherData;
  String? get errorMessage => _errorMessage;

  Future<void> fetchWeather(String city) async {
    try {
      _weatherData = await _weatherService.fetchWeather(city);
      _errorMessage = null;
    } catch (e) {
      _weatherData = null;
      _errorMessage = e.toString();
    }
    notifyListeners();
  }
}
