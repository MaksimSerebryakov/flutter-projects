import 'package:flutter/material.dart';
import 'package:training_planner/entities/event.dart';

class CalendarProvider extends ChangeNotifier {
  final List<Event> events = [];

  List<Event> getEvents() => events;

  void addEvent(Event event) {
    events.add(event);
    notifyListeners();
  }

  void removeEvent(int index) {
    events.removeAt(index);
    notifyListeners();
  }
}
