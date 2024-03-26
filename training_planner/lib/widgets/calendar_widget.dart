import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:training_planner/entities/event.dart';
import 'package:training_planner/providers/calendar_provider.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final CalendarController _calendarController = CalendarController();

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    if (_calendarController.view == CalendarView.month &&
        calendarTapDetails.targetElement == CalendarElement.calendarCell) {
      _calendarController.view = CalendarView.day;
    } else if (_calendarController.view == CalendarView.week &&
        calendarTapDetails.targetElement == CalendarElement.viewHeader) {
      _calendarController.view = CalendarView.day;
    }
  }

  @override
  Widget build(BuildContext context) {
    final events = Provider.of<CalendarProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      monthViewSettings:
          const MonthViewSettings(showAgenda: true, agendaStyle: AgendaStyle()),
      controller: _calendarController,
      dataSource: DataSource(events),
      allowedViews: const [
        CalendarView.day,
        CalendarView.week,
        CalendarView.month,
      ],
      onTap: calendarTapped,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeFormat: 'H:mm',
        timeTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
      appointmentTimeTextFormat: 'H:mm',
    );
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Event> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].title;

  @override
  String getNotes(int index) => appointments![index].description;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;

  @override
  Color getColor(int index) => appointments![index].backgroundColor;
}
