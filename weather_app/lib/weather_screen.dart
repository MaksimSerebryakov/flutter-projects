import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info.dart';
import 'package:weather_app/hourly_info.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherAppScreen extends StatefulWidget {
  const WeatherAppScreen({super.key});

  @override
  State<WeatherAppScreen> createState() => _WeatherAppScreenState();
}

class _WeatherAppScreenState extends State<WeatherAppScreen> {
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
            onPressed: () {},
            icon: const Icon(
              Icons.refresh,
            ),
            iconSize: 32,
          ),
        ],
      ),
      body: FutureBuilder(
        future: getCurrWeather(),
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
          final currSky = currTempData['weather'][0]['main'];

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
                            const Icon(
                              Icons.cloud,
                              size: 50,
                            ),
                            Text(
                              '$currSky',
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // brief overview
                  const SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Card(
                      margin: EdgeInsets.all(2),
                      color: Color(0xFF3B78EB),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Brief overview',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 17),
                  // hourly weather
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        HourlyColomn(
                          time: '22:00',
                          temperature: '7',
                          icon: Icons.cloud,
                        ),
                        HourlyColomn(
                          time: '23:00',
                          temperature: '8',
                          icon: Icons.cloud,
                        ),
                        HourlyColomn(
                          time: '24:00',
                          temperature: '7',
                          icon: Icons.cloud,
                        ),
                        HourlyColomn(
                          time: '00:00',
                          temperature: '6',
                          icon: Icons.cloud,
                        ),
                        HourlyColomn(
                          time: '01:00',
                          temperature: '5',
                          icon: Icons.cloud,
                        ),
                      ],
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
                  SizedBox(height: 10),
                  AdditionalWeatherInfo(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
