import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatelessWidget {
  const CurrencyConverterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderSide: const BorderSide(
        width: 1.5,
      ),
      borderRadius: BorderRadius.circular(12),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 48, 119, 66),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'MyAPP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFECDEDE),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                cursorColor: const Color.fromRGBO(34, 34, 34, 1),
                style: const TextStyle(
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Please input the amount of currency',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                  ),
                  prefixIcon: const Icon(
                    Icons.monetization_on_outlined,
                    color: Colors.black,
                  ),
                  hoverColor: const Color.fromRGBO(48, 119, 66, 0.219),
                  filled: true,
                  fillColor: const Color(0xFFECDEDE),
                  focusedBorder: border,
                  enabledBorder: border,
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
