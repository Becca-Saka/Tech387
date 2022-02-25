class Validator {
  static String? passwordValidator(String? val) {
    RegExp uppercasePattern = RegExp('(?=.*[A-Z])');
    RegExp lowercasePattern = RegExp('(?=.*[a-z])');
    RegExp digitPattern = RegExp('(?=.*?[0-9])');
    RegExp spcPattern = RegExp('(?=.*?[!@#\$&*~])');

    if (!(val!.length >= 8)) {
      return 'Must be at least 8 characters in length';
    } else if (!uppercasePattern.hasMatch(val)) {
      return 'should contain at least one upper case';
    } else if (!lowercasePattern.hasMatch(val)) {
      return 'should contain at least one lower case';
    } else if (!digitPattern.hasMatch(val)) {
      return 'should contain at least one number';
    } else if (!spcPattern.hasMatch(val)) {
      return 'should contain at least one special character';
    } else {
      return null;
    }
  }
    static String? nameValidator(String? val,) {
    if (val == null || val.isEmpty) {
      return 'Name cannot be empty';
    }
    return null;
  }
  static String? userNameValidator(String? val, bool exist) {
    if (val == null || val.isEmpty) {
      return 'Username cannot be empty';
    } else if (exist) {
      return 'Username is taken';
    }
    return null;
  }

  static String? confirmPasswordValidation(String? first, String? second) {
    if (second == null || second.isEmpty) {
      return 'Password cannot be empty';
    } else if (first != second) {
      return 'Password does not match';
    }
    return null;
  }

  static String? emailValidator(String? val) {
    RegExp emailValid =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

    if (val == null || val.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailValid.hasMatch(val)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
