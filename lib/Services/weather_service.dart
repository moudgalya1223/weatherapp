import 'package:dio/dio.dart';

class WeatherService {
  final String apiKey = 'c6586a42afeb4c3ca3141816240408'; // Your API key for WeatherAPI
  final String baseUrl = 'http://api.weatherapi.com/v1/current.json';
  final Dio _dio = Dio();  // Create a Dio instance

  Future<Map<String, dynamic>> fetchWeather(String city) async {
    try {
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'key': apiKey,
          'q': city,
          'aqi': 'no',
        },
      );

      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      throw Exception('Failed to load weather data: $e');
    }
  }
}
