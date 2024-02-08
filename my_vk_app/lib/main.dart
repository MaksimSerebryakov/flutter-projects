import 'package:flutter/material.dart';
import 'package:my_vk_app/training_app/pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VK',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0x20, 0x24, 0x39),
          primary: const Color.fromARGB(255, 0x20, 0x24, 0x39),
          secondary: const Color.fromARGB(255, 0xed, 0x69, 0x2a),
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const MainPage(),
      },
      initialRoute: "/",
    );
  }
}
