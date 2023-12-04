import 'package:get/get.dart';

class CustomValidator {
  static String? emailValidation(
      {required String value, required String name}) {
    if (value.isEmpty || value == "") {
      return "Please enter $name";
    } else if (!GetUtils.isEmail(value)) {
      return "invalid $name";
    } else {
      return null;
    }
  }

  static String? passwordValidation(
      {required String value, required String name}) {

    //Regex patterns for password validation.
    String wholePattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    String capsPattern = r'^(?=.*?[A-Z])(?=.*?[a-z]).{8,}$';
    String numberPattern = r'^(?=.*?[0-9]).{8,}$';
    String specialPattern = r'^(?=.*?[!@#\$&*~]).{8,}$';

    RegExp wholeRegex = RegExp(wholePattern);
    RegExp capsRegex = RegExp(capsPattern);
    RegExp numRegex = RegExp(numberPattern);
    RegExp specialRegex = RegExp(specialPattern);

    if (value.isEmpty || value == "") {
      return "Please enter $name";
    } else if (value.length < 8) {
      return "$name should be 8 character long.";
    } else if (!capsRegex.hasMatch(value)) {
      return "Enter atleast one small and capital alphabet.";
    } else if (!numRegex.hasMatch(value)) {
      return "Enter atleast one number.";
    } else if (!specialRegex.hasMatch(value)) {
      return "Enter atleast one special character (!@#\\\$&*~).";
    } else if (!wholeRegex.hasMatch(value)) {
      return "invalid $name";
    } else {
      return null;
    }
  }
}
