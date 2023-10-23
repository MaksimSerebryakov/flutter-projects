import 'package:flutter/cupertino.dart';

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
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: CupertinoColors.activeGreen.darkColor,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color.fromARGB(255, 48, 119, 66),
        middle: Text(
          'Currency Converter',
          style: TextStyle(
            fontSize: 35,
            color: CupertinoColors.white,
          ),
        ),
      ),
      child: Center(
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
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFECDEDE),
                    ),
                  ),
                  const WidgetSpan(
                    child: Icon(
                      CupertinoIcons.money_rubl,
                      size: 35,
                      color: Color(0xFFECDEDE),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoTextField(
                controller: textEditingController,
                onChanged: (value) {
                  if (value == '') {
                    currAmount = 0;
                  }
                  convert();
                },
                cursorColor: const Color.fromRGBO(34, 34, 34, 1),
                style: const TextStyle(
                  color: CupertinoColors.black,
                ),
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color(0xFFECDEDE),
                  borderRadius: BorderRadius.circular(12),
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                placeholder: 'Please input the amount of currency',
                prefix: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: const Icon(
                    CupertinoIcons.money_dollar_circle,
                    color: CupertinoColors.black,
                  ),
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
              child: CupertinoButton(
                onPressed: convert,
                color: CupertinoColors.black,
                child: const Text('Convert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
