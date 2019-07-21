class Validator {
  Validator._() {}

  static bool nameValidator(String name) {
    return name != null &&
        name.length > 0 &&
        RegExp("^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*\$").hasMatch(name);
  }

  static bool phoneValidator(String phone) {
    return phone != null &&
        phone.length > 0 &&
        RegExp("^[0-9]*\$").hasMatch(phone);
  }

  static bool emailValidator(String email) {
    return email != null &&
        RegExp("^(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+\$)")
            .hasMatch(email) &&
        email.length > 0;
  }
}
