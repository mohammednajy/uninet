extension ValidationExt on String {
  String? get isValidEmail {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    String? result;
    if (isEmpty) {
      result = 'This field is required';
    } else if (!(emailRegExp.hasMatch(this))) {
      result = 'enter valid email';
    }
    return result;
  }

  String? get isValidField {
    String? result;
    if (isEmpty) {
      result = 'This field is required';
    }
    return result;
  }

  String? get isValidPassword {
    String? result;

    // final passwordRegExp =
    //     RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (isEmpty) {
      result = 'This field is required';
    } else if (this.length < 5) {
      result = 'enter valid password';
    }
    return result;
  }

  String? get isValidPhone {
    String? result;
    final phoneRegExp = RegExp(r"^\+?[0-9]{7}$");
    if (isEmpty) {
      result = 'This field is required';
    } else if (!(phoneRegExp.hasMatch(this))) {
      result = 'enter valid phone number';
    }
    return result;
  }

  String? get isValidOtp {
    String? result;
    if (isEmpty || this.length < 5) {
      result = 'plz, fill all fields';
    } else if (!RegExp(r'^[0-9]+$').hasMatch(this)) {
      result = 'just number value';
    }
    return result;
  }
}
