class PasswordInputValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
    return "Please enter password.";
  } else if (value.length < 8) {
    return "The password must be at least 8 characters long.";
  } else if (!value.contains(RegExp(r'[0-9]'))) {
    return "The password must contain at least one number.";
  } else if (!value.contains(RegExp(r'[A-Z]'))) {
    return "The password must contain at least one capital letter.";
  }
    return null;
  }
}
