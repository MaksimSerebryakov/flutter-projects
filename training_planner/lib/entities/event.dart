import 'package:flutter/material.dart';

class Event {
  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

  Event(
      {required this.title,
      this.description = '',
      required this.from,
      required this.to,
      this.backgroundColor = const Color.fromARGB(255, 0x20, 0x24, 0x39),
      this.isAllDay = false});
}
