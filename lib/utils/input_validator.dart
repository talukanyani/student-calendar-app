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
    final regex = RegExp(r"^(?=.*[A-z])(?=.*\d)(?=.*\W).{6,60}$");
    return regex.hasMatch(value);
  }
}
