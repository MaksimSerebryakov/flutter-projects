import 'package:flutter/material.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

// With such a realization the button doesn't really necessary here
// but it's useful as a training

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  double currAmount = 0;
  double rate = 98.15; // currency rate

  TextEditingController textEditingController =
      TextEditingController(); // controller for the Textfield

  void convert() {
    if (textEditingController.text != '') {
      currAmount = double.parse(textEditingController.text) * rate;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();

    debugPrint('initializing the State');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 119, 66),
        elevation: 0,
        title: const Text('Currency Converter'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 254, 255),
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        currAmount == 0.0 ? '0' : currAmount.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFECDEDE),
                    ),
                  ),
                  const WidgetSpan(
                    child: Icon(
                      Icons.currency_ruble,
                      size: 30,
                      color: Color(0xFFECDEDE),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: textEditingController,
                onChanged: (value) {
                  if (value == '') {
                    currAmount = 0;
                  }
                  convert();
                },
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
            ),
            // button
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
                left: 12,
                right: 12,
              ),
              child: ElevatedButton(
                onPressed: convert,
                onLongPress: () {
                  debugPrint('LONG pressed');
                },
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: const Color.fromRGBO(44, 43, 43, 1),
                  foregroundColor: const Color(0xFFECDEDE),
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
