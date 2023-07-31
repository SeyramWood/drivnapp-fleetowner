class EmailInputValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }

    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*(\.[a-zA-Z]{2,})$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }

    return null;
  }
}
