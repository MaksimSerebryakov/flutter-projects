import 'package:flutter/material.dart';
import 'package:my_vk_app/providers/person_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:my_vk_app/widgets/auth/auth_widget.dart';
import 'package:my_vk_app/widgets/auth/password_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PersonDataProvider(),
      child: MaterialApp(
        title: 'VK',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 46, 98, 177)),
          useMaterial3: true,
        ),
        routes: {
          "/": (context) => const AuthWidget(),
          "/password": (context) => const PasswordWidget(),
        },
        initialRoute: "/",
      ),
    );
  }
}
