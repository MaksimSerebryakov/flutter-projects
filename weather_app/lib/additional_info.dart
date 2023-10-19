import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class AdditionalWeatherInfo extends StatelessWidget {
  const AdditionalWeatherInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AddintionalInfoUnit(
              text: 'Wind Speed',
              value: '10 m/s',
              unitIcon: WeatherIcons.windy,
            ),
            AddintionalInfoUnit(
              text: 'Pressure',
              value: '773 mm',
              unitIcon: WeatherIcons.barometer,
            ),
          ],
        ),
        SizedBox(height: 30),
        AddintionalInfoUnit(
          text: 'Humidity',
          value: '81%',
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
