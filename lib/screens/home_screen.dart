import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/weather_provider.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter city',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
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
            SizedBox(height: 20),
            Consumer<WeatherProvider>(
              builder: (context, provider, child) {
                if (provider.errorMessage != null) {
                  return Text(
                    provider.errorMessage!,
                    style: TextStyle(color: Colors.red),
                  );
                }
                if (provider.weatherData == null) {
                  return Text('Enter a city to get weather data');
                }
                final weather = provider.weatherData!;
                return Column(
                  children: [
                    Text(
                     "PLACE:"   '${weather['location']['name']}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold , color: Colors.blueAccent),
                    ),
                    // Text(
                    //   '${weather['main']['temp']}°C',
                    //   style: TextStyle(fontSize: 48),
                    // ),
                    // Text(
                    //   '${weather['weather'][0]['description']}',
                    //   style: TextStyle(fontSize: 18),
                    // ),
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
