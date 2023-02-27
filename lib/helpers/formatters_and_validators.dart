import 'package:flutter/services.dart';

class InputFormatter {
  static TextInputFormatter noSpaceAtStart() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue.text.startsWith(' ') ? oldValue : newValue;
    });
  }

  static TextInputFormatter noDoubleSpace() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue.text.contains('  ') ? oldValue : newValue;
    });
  }

  static TextInputFormatter noSpace() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue.text.contains(' ') ? oldValue : newValue;
    });
  }
}

class InputValidator {
  static bool isValidName(String value) {
    final regex = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]?)+");
    return regex.hasMatch(value);
  }

  static bool isValidEmail(String value) {
    final regex = RegExp(r"^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{1,10})+$");
    return regex.hasMatch(value);
  }

  static bool isStrongPassword(String value) {
    final regex = RegExp(
      r"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,64}$",
    );
    return regex.hasMatch(value);
  }
}
