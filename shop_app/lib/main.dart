import 'package:flutter/material.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/pages/product_details.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(
        fontFamily: 'OpenSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(231, 153, 247, 1),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          prefixIconColor: Color.fromARGB(255, 124, 124, 124),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        useMaterial3: true,
      ),
      home: DetailPage(
        product: products[0],
      ),
    );
  }
}
