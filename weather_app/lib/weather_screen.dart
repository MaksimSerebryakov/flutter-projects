import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_info.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherAppScreen extends StatefulWidget {
  const WeatherAppScreen({super.key});

  @override
  State<WeatherAppScreen> createState() => _WeatherAppScreenState();
}

class _WeatherAppScreenState extends State<WeatherAppScreen> {
  late Future<(Map<String, dynamic>, Map<String, dynamic>)> getWeather;

  Future<(Map<String, dynamic>, Map<String, dynamic>)> getCurrWeather() async {
    try {
      var currWeather = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$mscLat&lon=$mscLong&appid=$openWeatherAPIKey'));
      var forecast = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?lat=$mscLat&lon=$mscLong&appid=$openWeatherAPIKey'));
      final Map<String, dynamic> forecastResponse = jsonDecode(forecast.body);
      final Map<String, dynamic> currWeatherResponse =
          jsonDecode(currWeather.body);

      if (forecastResponse['cod'] != '200') {
        throw 'The source returned code "${forecastResponse['cod']}", message: "${forecastResponse['message']}"';
      }

      return (currWeatherResponse, forecastResponse);
    } catch (e) {
      throw e.toString();
    }
  }

  IconData getWeatherIcon(String icon) => switch (icon) {
        'Clouds' => WeatherIcons.cloud,
        'Rain' || 'Drizzle' => WeatherIcons.rain,
        'Clear' => WeatherIcons.day_sunny,
        'Snow' => WeatherIcons.snow,
        _ => WeatherIcons.cloud
      };

  @override
  void initState() {
    super.initState();

    getWeather = getCurrWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'WeatherApp',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                getWeather = getCurrWeather();
              });
            },
            icon: const Icon(
              Icons.refresh,
            ),
            iconSize: 32,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final (currTempData, forecastData) = snapshot.data!;

          final currTemperature =
              (currTempData['main']['temp'] - 273.15).round();
          final String currSky = currTempData['weather'][0]['main'];
          final currSkyIcon = getWeatherIcon(currSky);

          final windSpeed = currTempData['wind']['speed'];
          final humidity = currTempData['main']['humidity'];
          final pressure = currTempData['main']['pressure'];

          final feelsLike =
              (currTempData['main']['feels_like'] - 273.15).round();
          String briefOverview =
              'Feels like $feelsLike, ${currTempData['weather'][0]['description']}';

          var hourlyRow = <HourlyColomn>[];

          for (int i = 0; i < 5; i++) {
            String time = forecastData['list'][i]['dt_txt'].split(' ')[1];
            time = time.split(':').sublist(0, 2).join(':');

            final weatherIcon =
                getWeatherIcon(forecastData['list'][i]['weather'][0]['main']);
            final temperature =
                (forecastData['list'][i]['main']['temp'] - 273.15).round();

            hourlyRow.add(HourlyColomn(
                time: time,
                icon: weatherIcon,
                temperature: temperature.toString()));
          }

          return Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                children: [
                  // main window
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                        child: Column(
                          children: [
                            Text(
                              '$currTemperature \u2103',
                              style: const TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(currSkyIcon, size: 50),
                            const SizedBox(height: 30),
                            Text(
                              currSky,
                              style: const TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // brief overview
                  SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      margin: const EdgeInsets.all(2),
                      color: const Color(0xFF3B78EB),
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          briefOverview,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  // hourly weather
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: hourlyRow,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // additional info
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Additional weather Info',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 23, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 10),
                  AdditionalWeatherInfo(
                    wind: windSpeed.toString(),
                    humidity: humidity.toString(),
                    pressure: pressure.toString(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
