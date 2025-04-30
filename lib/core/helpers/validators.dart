


import 'package:transcation_app/core/helpers/app_regex.dart';

String? emptyValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "هذا الحقل مطلوب";
  }
  return null;
}

String? phoneValidator(String? value) {
  String? emptyValidation = emptyValidator(value);
  if (emptyValidation != null) {
    return emptyValidation;
  }
  if (!AppRegex.isPhoneValid(value!)) {
    return "رقم الهاتف غير صالح";
  }
  return null;
}

String? numbersValidator(String? value) {
  String? emptyValidation = emptyValidator(value);
  if (emptyValidation != null) {
    return emptyValidation;
  }
  if (!AppRegex.isNumber(value!)) {
    return "الرقم غير صالح";
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "يرجى إدخال البريد الإلكتروني";
  }
  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
    return "صيغة البريد الإلكتروني غير صحيحة";
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value == null || value.isEmpty) {
    return "يرجى إدخال كلمة المرور";
  }
  if (!RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$').hasMatch(value)) {
    return "يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل وتتضمن حرفاً ورقماً ورمزاً خاصاً";
  }
  return null;
}