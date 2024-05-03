class AppValidations {
  static bool isValidEmail(String email) {
    // Regular expression to match a valid email address
    RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    // Check if the email matches the regular expression
    return emailRegExp.hasMatch(email);
  }

  static bool isValidPhoneNumber(String phoneNumber) {
    // Regular expression to match a valid phone number
    RegExp phoneRegExp = RegExp(r'^\+?[1-9]\d{1,14}$');

    return phoneRegExp.hasMatch(phoneNumber);
  }
}
