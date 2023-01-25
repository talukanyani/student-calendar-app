import 'package:flutter/services.dart';

TextInputFormatter noSpaceAtStart() {
  return TextInputFormatter.withFunction((oldValue, newValue) {
    return newValue.text.startsWith(' ') ? oldValue : newValue;
  });
}

TextInputFormatter noDoubleSpace() {
  return TextInputFormatter.withFunction((oldValue, newValue) {
    return newValue.text.contains('  ') ? oldValue : newValue;
  });
}

TextInputFormatter noSpace() {
  return TextInputFormatter.withFunction((oldValue, newValue) {
    return newValue.text.contains(' ') ? oldValue : newValue;
  });
}
