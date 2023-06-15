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
