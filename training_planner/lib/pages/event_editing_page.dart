import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:provider/provider.dart';
import 'package:pair/pair.dart';
import 'package:intl/intl.dart';

import 'package:training_planner/entities/event.dart';
import 'package:training_planner/providers/calendar_provider.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({this.event, super.key});

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;
  bool _isAllDay = false;
  Pair<Color, String> _selectedColor =
      const Pair(Color.fromARGB(255, 96, 219, 168), 'ПТ');

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  final List<Pair<Color, String>> tags = [
    const Pair(Color.fromARGB(255, 96, 219, 168), 'ПТ'),
    const Pair(Color.fromARGB(255, 119, 89, 201), 'ВПТ'),
    const Pair(Color.fromARGB(255, 219, 96, 133), 'Встреча'),
  ];

  bool isEditing = false;

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = fromDate.add(const Duration(hours: 2));
    } else {
      fromDate = widget.event!.from;
      toDate = widget.event!.to;

      if (widget.event!.title != '') {
        isEditing = true;
        _isAllDay = widget.event!.isAllDay;
        _titleController.text = widget.event!.title;
        _descriptionController.text = widget.event!.description;

        for (var tag in tags) {
          if (widget.event!.backgroundColor == tag.key) {
            _selectedColor = tag;
          }
        }
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textFieldBorder = UnderlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100)));

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
            onPressed: () {
              if (_titleController.text == '') {
                showAdaptiveDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text(
                          'Введи название события!',
                          style: TextStyle(
                            color: Color.fromARGB(255, 197, 73, 73),
                            fontSize: 23,
                          ),
                        ),
                      );
                    });
              } else {
                if (isEditing == true) {
                  Provider.of<CalendarProvider>(context, listen: false)
                      .editEvent(
                          Event(
                            title: _titleController.text,
                            from: fromDate,
                            to: toDate,
                            isAllDay: _isAllDay,
                            description: _descriptionController.text,
                            backgroundColor: _selectedColor.key,
                          ),
                          widget.event!);
                } else {
                  Provider.of<CalendarProvider>(context, listen: false)
                      .addEvent(Event(
                          title: _titleController.text,
                          from: fromDate,
                          to: toDate,
                          isAllDay: _isAllDay,
                          description: _descriptionController.text,
                          backgroundColor: _selectedColor.key));
                }

                Navigator.of(context).pop();
              }
            },
            icon: const Icon(
              Icons.done,
              color: Colors.white,
            ),
          ),
        ],
      ),
      // Event Config
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Label
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: "Название",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                enabledBorder: textFieldBorder,
                focusedBorder: textFieldBorder,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              onSubmitted: (value) {},
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  const Expanded(
                      child: Text(
                    'Весь день',
                    style: TextStyle(fontSize: 15),
                  )),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Switch.adaptive(
                        applyCupertinoTheme: true,
                        value: _isAllDay,
                        inactiveTrackColor: Colors.white,
                        onChanged: (bool value) {
                          _isAllDay = value;
                          setState(() {});
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            // fromDate Picker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      child: Text(
                        DateFormat('E, dd MMM yyyy', 'ru').format(fromDate),
                        style: const TextStyle(fontSize: 15),
                      ),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: fromDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          fromDate = date;

                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _isAllDay == true
                        ? const Text('')
                        : GestureDetector(
                            child: Text(
                              DateFormat('HH:mm', 'ru').format(fromDate),
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 15),
                            ),
                            onTap: () async {
                              final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                    hour: fromDate.hour,
                                    minute: fromDate.minute,
                                  ));

                              if (time != null) {
                                fromDate = DateTime(
                                    fromDate.year,
                                    fromDate.month,
                                    fromDate.day,
                                    time.hour,
                                    time.minute);

                                if (fromDate.isAfter(toDate)) {
                                  toDate =
                                      fromDate.add(const Duration(hours: 2));
                                }

                                setState(() {});
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // toDate Picker
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    flex: 7,
                    child: GestureDetector(
                      child: Text(
                        DateFormat('E, dd MMM yyyy', 'ru').format(toDate),
                        style: const TextStyle(fontSize: 15),
                      ),
                      onTap: () async {
                        final DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: fromDate,
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );

                        if (date != null && date.isAfter(fromDate)) {
                          toDate = date;

                          setState(() {});
                        }
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: _isAllDay == true
                        ? const Text('')
                        : GestureDetector(
                            child: Text(
                              DateFormat('HH:mm', 'ru').format(toDate),
                              textAlign: TextAlign.right,
                              style: const TextStyle(fontSize: 15),
                            ),
                            onTap: () async {
                              final TimeOfDay? time = await showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay(
                                    hour: fromDate.hour,
                                    minute: fromDate.minute,
                                  ));

                              if (time != null &&
                                  DateTime(toDate.year, toDate.month,
                                          toDate.day, time.hour, time.minute)
                                      .isAfter(fromDate)) {
                                toDate = DateTime(toDate.year, toDate.month,
                                    toDate.day, time.hour, time.minute);

                                setState(() {});
                              }
                            },
                          ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 25),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(Icons.lens, color: _selectedColor.key),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        child: Text(
                          _selectedColor.value,
                          style: const TextStyle(fontSize: 15),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: SizedBox(
                                  width: double.maxFinite,
                                  height: 300,
                                  child: ListView.builder(
                                    itemCount: tags.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        leading: Icon(
                                          Icons.lens,
                                          color: tags[index].key,
                                        ),
                                        title: Text(tags[index].value),
                                        onTap: () {
                                          setState(() {
                                            _selectedColor = tags[index];
                                          });

                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 25),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                prefixIcon: Icon(
                  Icons.subject,
                  color: Color.fromARGB(255, 100, 100, 100),
                ),
                hintText: "Заметки",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                enabledBorder: textFieldBorder,
                focusedBorder: textFieldBorder,
              ),
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              onSubmitted: (value) {},
            ),
          ],
        ),
      ),
      floatingActionButton: isEditing == false
          ? null
          : FloatingActionButton(
              elevation: 2,
              onPressed: () {
                Provider.of<CalendarProvider>(context, listen: false)
                    .removeEvent(widget.event!);
                Navigator.of(context).pop();
              },
              shape: const CircleBorder(),
              child: const Icon(Icons.delete),
            ),
    );
  }
}
