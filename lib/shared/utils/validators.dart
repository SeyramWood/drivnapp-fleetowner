class MyFormFieldValidator {
  String? nameValidate(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a user name.";
    }

    if (value.length < 3) {
      return "The username must be at least 3 characters long.";
    }

    if (value.length > 16) {
      return "The name is too long.";
    }

    return null;
  }

  String? passwordValidtor(String? value) {
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
