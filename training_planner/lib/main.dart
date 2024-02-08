import 'package:flutter/material.dart';

import 'package:training_planner/pages/calendar_page.dart';
import 'package:training_planner/pages/main_page.dart';
import 'package:training_planner/pages/event_editing_page.dart';

import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
        // ... other locales the app supports
      ],
      locale: const Locale('ru'),
      title: 'TrainingPlanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'TenorSans',
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0x20, 0x24, 0x39),
          primary: const Color.fromARGB(255, 0x20, 0x24, 0x39),
          secondary: const Color.fromARGB(255, 0xed, 0x69, 0x2a),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const MainPage(),
        "calendar": (context) => const CalendarPage(),
        "add_event": (context) => const EventEditingPage(),
      },
      initialRoute: "/",
    );
  }
}
