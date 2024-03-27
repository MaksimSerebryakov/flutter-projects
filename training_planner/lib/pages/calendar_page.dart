import 'package:flutter/material.dart';
import 'package:training_planner/widgets/calendar_widget.dart';
dslkfmldkmflkwdflkwd
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Календарь",
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        backgroundColor: const Color.fromARGB(255, 0x0c, 0xa1, 0xb1),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'add_event');
        },
        elevation: 2,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
