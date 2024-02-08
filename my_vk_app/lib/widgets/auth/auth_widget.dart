import 'package:flutter/material.dart';
import 'package:my_vk_app/providers/person_data_provider.dart';
import 'package:provider/provider.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({super.key});

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
        centerTitle: true,
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 12,
            width: double.infinity,
          ),
          Text(
            "Вход ВКонтакте",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 21,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Введите телефон или почту, которые\nпривязаны к аккаунту",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 129, 140, 153),
            ),
          ),
          SizedBox(height: 24),
          _EnterForm()
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
  final _phoneEmailController = TextEditingController();

  String? errorText;

  bool saveInput = false;
  bool isEmptyPhoneEmailField = true;

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  void _continue() {
    final login = _phoneEmailController.text;

    if (login == "admin") {
      debugPrint("continue: ${_phoneEmailController.text}");
      errorText = null;

      Provider.of<PersonDataProvider>(context, listen: false).setLogin(login);

      Navigator.pushNamed(context, "/password");
    } else {
      errorText = "One of parameters specified was missing or invalid";
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                errorText!,
                style: const TextStyle(
                    color: Color.fromARGB(255, 129, 140, 153),
                    fontWeight: FontWeight.w400),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              backgroundColor: Colors.white,
              alignment: Alignment.bottomCenter,
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 20,
              ),
            );
          });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _phoneEmailController.dispose();
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
            controller: _phoneEmailController,
            onChanged: (value) {
              if (value != '') {
                isEmptyPhoneEmailField = false;
              } else {
                isEmptyPhoneEmailField = true;
              }

              setState(() {});
            },
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
              hintText: "Телефон или почта",
              hintStyle: textStyle,
              fillColor: Color.fromARGB(255, 242, 243, 245),
              hoverColor: Color.fromARGB(255, 242, 243, 245),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 184, 185, 186)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                borderSide: BorderSide(
                    width: 1, color: Color.fromARGB(255, 56, 102, 242)),
              ),
            ),
            cursorColor: Colors.black,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  saveInput = !saveInput;
                  setState(() {});
                },
                child: saveInput == false
                    ? Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: const Color.fromARGB(255, 184, 191, 205),
                            width: 2,
                          ),
                        ),
                      )
                    : Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 56, 102, 242),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
              ),
              const SizedBox(width: 14),
              const Text(
                "Сохранить вход",
                style: textStyle,
              ),
              Tooltip(
                message:
                    "Сохранить вход\n\nВыберите, чтобы сохранить\nданные аккаунта для быстрого\nвхода на этом устройстве",
                key: tooltipkey,
                triggerMode: TooltipTriggerMode.manual,
                showDuration: const Duration(seconds: 0),
                child: IconButton(
                  onPressed: () {
                    tooltipkey.currentState?.ensureTooltipVisible();
                  },
                  icon: const Icon(Icons.question_mark),
                ),
              )
            ],
          ),
          const SizedBox(height: 28),
          SizedBox(
            height: 46,
            width: double.infinity,
            child: TextButton(
              onPressed: isEmptyPhoneEmailField == true ? null : _continue,
              style: isEmptyPhoneEmailField == true
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
