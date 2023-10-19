import 'package:flutter/material.dart';

class HourlyColomn extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData icon;

  const HourlyColomn(
      {super.key,
      required this.time,
      required this.icon,
      required this.temperature});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: const EdgeInsets.all(8),
        width: 110,
        child: Column(
          children: [
            // time
            Text(
              time,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 6),
            // weather Icon
            Icon(icon, size: 32),
            const SizedBox(height: 6),
            // temperature
            Text(
              '$temperature \u2103',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
