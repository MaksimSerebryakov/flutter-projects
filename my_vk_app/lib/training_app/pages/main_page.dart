import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final String quote;

  // TODO: add a pair library and use instead List<String>
  final List<String> pages = ["Календарь", "Задачи", "Финансы", "Клиенты", "Итоги"];

  @override
  void initState() {
    super.initState();

    quote = "\"Здесь должна быть рандомная цитата из списка\"";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        color: Theme.of(context).colorScheme.primary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: Text(
                quote,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: ListView.builder(
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  final page = pages[index];

                  return Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 50,
                      bottom: 50
                    ),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all<Size>(
                            const Size.fromHeight(60)),
                        backgroundColor: index % 2 == 0 ? MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 0xed, 0x69, 0x2a),
                        ) : MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 0x0c, 0xa1, 0xb1),
                        ),
                      ),
                      child: Text(
                        page,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 28),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
