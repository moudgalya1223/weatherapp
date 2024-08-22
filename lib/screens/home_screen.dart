import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Path to your background image
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Please Enter city',
                labelStyle: const TextStyle(color:Color.fromARGB(255, 1, 1, 1)), 
                suffixIcon: IconButton(
                  icon:const Icon(Icons.search),
                  onPressed: () {
                    final city = _controller.text;
                    if (city.isNotEmpty) {
                      Provider.of<WeatherProvider>(context, listen: false)
                          .fetchWeather(city);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.errorMessage != null) {
                  return Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  );
                }
                if (provider.weatherData == null) {
                  return const Text('Enter a city to get weather data');
                }
                final weather = provider.weatherData!;
                return Column(
                  children: [
                    Text(
                      'Location: ${weather['location']['region']}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'country: ${weather['location']['country']}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'Time: ${weather['location']['localtime']}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'Current Temp: ${weather['current']['temp_c']}°C',
                      style: const TextStyle(fontSize: 24, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'Current Temp: ${weather['current']['temp_f']}°F',
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'Weather: ${weather['current']['condition']['text']}',
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    
                    Text(
                      'UV in Your Area: ${weather['current']['uv']}',
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'Feelslike: ${weather['current']['feelslike_c']}°C',
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                    Text(
                      'Wind Direction: ${weather['current']['wind_dir']}',
                      style: const TextStyle(fontSize: 18, color: Color.fromARGB(255, 1, 1, 1)),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
