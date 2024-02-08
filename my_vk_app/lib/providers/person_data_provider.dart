import 'package:flutter/material.dart';

class PersonDataProvider extends ChangeNotifier {
  String? personLogin;

  void setLogin(String login) {
    personLogin ??= login;
  }

  String getLogin() {
    return personLogin!;
  }
}
