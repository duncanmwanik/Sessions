class Validator {
  static String? validateName({required String name}) {
    if (name.isEmpty) {
      return 'Please enter name';
    }

    return null;
  }

  static String? validateEmail({required String email}) {
    RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

    if (email.isEmpty) {
      return 'Please enter email';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Enter a valid email';
    }

    return null;
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Please enter password';
    } else if (password.length < 6) {
      return 'Password should be at least 6 characters';
    }

    return null;
  }
}
