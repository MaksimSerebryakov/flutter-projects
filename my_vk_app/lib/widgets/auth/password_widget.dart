import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_vk_app/providers/person_data_provider.dart';
import 'package:provider/provider.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget({super.key});

  @override
  State<PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  late final String login;

  @override
  void initState() {
    super.initState();

    login = Provider.of<PersonDataProvider>(context, listen: false).getLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 56, 102, 242),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 57, 37, 255),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'VK',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              'ID',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 12,
            width: double.infinity,
          ),
          const Text(
            "Введите пароль",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Введите ваш текущий пароль, привязанный к",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 129, 140, 153),
            ),
          ),
          Text(
            login,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 24),
          const _EnterForm()
        ],
      ),
    );
  }
}

class _EnterForm extends StatefulWidget {
  const _EnterForm({super.key});

  @override
  State<_EnterForm> createState() => _EnterFormState();
}

class _EnterFormState extends State<_EnterForm> {
  final _passwordController = TextEditingController();

  String? errorText;

  bool isEmptyPasswordField = true;
  bool showPassword = false;

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  void _continue() {}

  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 129, 140, 153),
        fontWeight: FontWeight.w400);
    const nextButtonInactiveColor = MaterialStatePropertyAll(
      Color.fromARGB(255, 130, 153, 240),
    );
    final nextButtonShape = MaterialStateProperty.all<RoundedRectangleBorder>(
      const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          TextField(
            textAlignVertical: TextAlignVertical.center,
            controller: _passwordController,
            onChanged: (value) {
              if (value != '') {
                isEmptyPasswordField = false;
              } else {
                isEmptyPasswordField = true;
              }

              setState(() {});
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 12),
              hintText: "Введите пароль",
              hintStyle: textStyle,
              fillColor: const Color.fromARGB(255, 242, 243, 245),
              hoverColor: const Color.fromARGB(255, 242, 243, 245),
              filled: true,
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 184, 185, 186)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 56, 102, 242)),
              ),
              suffix: showPassword == false
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: const Icon(Icons.visibility, size: 16),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      child: const Icon(Icons.visibility_off, size: 16),
                    ),
            ),
            cursorColor: Colors.black,
            style: const TextStyle(fontWeight: FontWeight.w500),
            obscureText: showPassword == true ? false : true,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () {},
            child: const Text("Забыли или не установили пароль?"),
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 46,
            width: double.infinity,
            child: TextButton(
              onPressed: isEmptyPasswordField == true ? null : _continue,
              style: isEmptyPasswordField == true
                  ? ButtonStyle(
                      backgroundColor: nextButtonInactiveColor,
                      overlayColor: nextButtonInactiveColor,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    )
                  : ButtonStyle(
                      backgroundColor: const MaterialStatePropertyAll(
                          Color.fromARGB(255, 60, 96, 231)),
                      overlayColor: nextButtonInactiveColor,
                      shape: nextButtonShape,
                    ),
              child: const Text(
                "Продолжить",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
