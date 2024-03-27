import 'package:flutter/material.dart';
import 'package:training_planner/entities/event.dart';

class CalendarProvider extends ChangeNotifier {
  final List<Event> events = [];

  List<Event> getEvents() => events;

  void addEvent(Event event) {
    events.add(event);

    notifyListeners();
  }

  void removeEvent(Event oldEvent) {
    events.remove(oldEvent);

    notifyListeners();
  }

  void editEvent(Event newEvent, Event oldEvent) {
    int index = events.indexOf(oldEvent);

    if (index >= 0 && index <= events.length) {
      events[index] = newEvent;
    }

    notifyListeners();
  }
}
