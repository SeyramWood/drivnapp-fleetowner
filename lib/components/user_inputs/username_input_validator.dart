class UsernameInputValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
    return "Please enter a username.";
  }

  if (value.length < 3) {
    return "The username must be at least 3 characters long.";
  }

  if (value.length > 16) {
    return "The username must be no more than 16 characters long.";
  }

    return null;
  }
}
