import 'package:flutter/material.dart';
import 'package:training_planner/entities/event.dart';
import 'package:intl/intl.dart';

class EventEditingPage extends StatefulWidget {
  final Event? event;

  const EventEditingPage({this.event, super.key});

  @override
  State<EventEditingPage> createState() => _EventEditingPageState();
}

class _EventEditingPageState extends State<EventEditingPage> {
  late DateTime fromDate;
  late DateTime toDate;

  final _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.event == null) {
      fromDate = DateTime.now();
      toDate = fromDate.add(const Duration(hours: 2));
    }
  }

  @override
  void dispose() {
    _textFieldController.dispose();
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
              if (_textFieldController.text == '') {
                print("add title");
              } else {
                print("title: ${_textFieldController.text}");
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
              controller: _textFieldController,
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
            const SizedBox(height: 12),
            // From Date Picker
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    child: Text(
                        DateFormat('E, dd MMM yyyy', 'ru').format(fromDate)),
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: fromDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if (date != null) {
                        fromDate = date;
                        toDate = fromDate.add(const Duration(hours: 2));

                        setState(() {});
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    child: Text(
                      DateFormat('HH:mm', 'ru').format(fromDate),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: fromDate.hour,
                            minute: fromDate.minute,
                          ));

                      if (time != null) {
                        fromDate = DateTime(fromDate.year, fromDate.month,
                            fromDate.day, time.hour, time.minute);
                        toDate = fromDate.add(const Duration(hours: 2));

                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // ToDate Picker
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: GestureDetector(
                    child:
                        Text(DateFormat('E, dd MMM yyyy', 'ru').format(toDate)),
                    onTap: () async {
                      final DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: fromDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );

                      if (date != null &&
                          date.difference(fromDate) > Duration.zero) {
                        toDate = date;

                        setState(() {});
                      } else {
                        print("ToDate is not valid!!!");
                      }
                    },
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: GestureDetector(
                    child: Text(
                      DateFormat('HH:mm', 'ru').format(toDate),
                      textAlign: TextAlign.right,
                    ),
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay(
                            hour: fromDate.hour,
                            minute: fromDate.minute,
                          ));

                      if (time != null) {
                        fromDate = DateTime(fromDate.year, fromDate.month,
                            fromDate.day, time.hour, time.minute);
                        toDate = fromDate.add(const Duration(hours: 1));

                        setState(() {});
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
