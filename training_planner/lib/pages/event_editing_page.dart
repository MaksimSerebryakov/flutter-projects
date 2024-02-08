import 'package:flutter/material.dart';
import 'package:training_planner/entities/event.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({this.event, super.key});

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = fromDate.add(const Duration(hours: 2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "",
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        backgroundColor: const Color.fromARGB(255, 0x0c, 0xa1, 0xb1),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
