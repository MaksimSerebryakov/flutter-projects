import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class AdditionalWeatherInfo extends StatelessWidget {
  final String wind;
  final String humidity;
  final String pressure;

  const AdditionalWeatherInfo(
      {super.key,
      required this.wind,
      required this.humidity,
      required this.pressure});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddintionalInfoUnit(
              text: 'Wind Speed',
              value: '$wind m/s',
              unitIcon: WeatherIcons.windy,
            ),
            AddintionalInfoUnit(
              text: 'Pressure',
              value: '$pressure hPa',
              unitIcon: WeatherIcons.barometer,
            ),
          ],
        ),
        const SizedBox(height: 30),
        AddintionalInfoUnit(
          text: 'Humidity',
          value: '$humidity %',
          unitIcon: WeatherIcons.humidity,
        ),
      ],
    );
  }
}

class AddintionalInfoUnit extends StatelessWidget {
  final String text;
  final String value;
  final IconData unitIcon;

  const AddintionalInfoUnit(
      {super.key,
      required this.text,
      required this.value,
      required this.unitIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(unitIcon, size: 32),
        const SizedBox(height: 15),
        Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 10),
        Text(value),
      ],
    );
  }
}
