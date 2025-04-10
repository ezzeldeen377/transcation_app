


import 'package:transcation_app/core/helpers/app_regex.dart';

String? emptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "This field cannot be empty.";
  }
  return null;
}

String? phoneValidator(String? value) {
  // Check if the value is empty using isEmptyValidator
  String? emptyValidation = emptyValidator(value);
  if (emptyValidation != null) {
    return emptyValidation;
  }
  if (!AppRegex.isPhoneValid(value!)) {
    return  "Invalid phone number.";
  }
  return null;
}

String? numbersValidator(String? value) {
  // Check if the value is empty using isEmptyValidator
  String? emptyValidation = emptyValidator(value);
  if (emptyValidation != null) {
    return emptyValidation;
  }
  if (!AppRegex.isNumber(value!)) {
    return  "Invalid number.";
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return  "Please enter an email.";
  }
  // RegEx to validate email format
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return "Invalid email format.";
  }
  return null; // Validation passed
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return  "Please enter a password.";
  }
  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
    return  "Password must be at least 8 characters long, include a letter, a number, and a special character.";
  }
  return null;
}