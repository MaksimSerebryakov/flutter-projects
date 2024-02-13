import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
    return SfCalendar(
      view: CalendarView.month,
      initialSelectedDate: DateTime.now(),
      monthViewSettings:
          const MonthViewSettings(showAgenda: true, agendaStyle: AgendaStyle()),
      controller: _calendarController,
      dataSource: _getCalendarDataSource(),
      allowedViews: const [
        CalendarView.day,
        CalendarView.week,
        CalendarView.month,
      ],
      onTap: calendarTapped,
      timeSlotViewSettings: const TimeSlotViewSettings(
        timeFormat: "H:mm",
        timeTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 13,
        ),
      ),
    );
  }
}

DataSource _getCalendarDataSource() {
  List<Appointment> appointments = <Appointment>[];
  appointments.add(
    Appointment(
        startTime: DateTime.now().add(Duration(hours: 1)),
        endTime: DateTime.now().add(Duration(hours: 5)),
        isAllDay: false,
        subject: 'Meeting 1',
        color: Colors.blue,
        startTimeZone: '',
        endTimeZone: ''),
  );
  appointments.add(
    Appointment(
        startTime: DateTime.now().add(Duration(hours: 2)),
        endTime: DateTime.now().add(Duration(hours: 4)),
        isAllDay: false,
        subject: 'Meeting 2',
        color: Colors.red,
        startTimeZone: '',
        endTimeZone: ''),
  );
  appointments.add(
    Appointment(
        startTime: DateTime.now().add(Duration(hours: 2)),
        endTime: DateTime.now().add(Duration(hours: 4)),
        isAllDay: false,
        subject: 'Meeting 2',
        color: Colors.yellow,
        startTimeZone: '',
        endTimeZone: ''),
  );
  appointments.add(
    Appointment(
        startTime: DateTime.now().add(Duration(hours: 2)),
        endTime: DateTime.now().add(Duration(hours: 4)),
        isAllDay: false,
        subject: 'Meeting 2',
        color: Colors.green,
        startTimeZone: '',
        endTimeZone: ''),
  );

  return DataSource(appointments);
}

class DataSource extends CalendarDataSource {
  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
