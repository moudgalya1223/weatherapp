import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'c6586a42afeb4c3ca3141816240408'; // Your API key for WeatherAPI
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    final response = await http.get(Uri.parse('$baseUrl?key=$apiKey&q=$city&aqi=no'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
