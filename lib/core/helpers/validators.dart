import 'package:ibank/core/extensions/string_ext.dart';

String? nameValidation(String? value) {
  if (value == null) return 'Fullname is required.';
  if (value.isEmpty) return 'Fullname is required.';
  if (value.isEmpty) return 'Invalid Fullname.';
  return null;
}

String? emailValidation(String? value) {
  if (value == null) return 'Email address is required.';
  if (value.isEmpty) return 'Email address is required.';
  if (!value.isEmail) return 'Invalid email address.';
  return null;
}

String? cellphoneValidation(String? value) {
  if (value == null) return 'Cellphone number is required.';
  if (value.isEmpty) return 'Cellphone number is required.';
  if (!value.isCellphone) return 'Invalid cellphone number.';
  return null;
}

String? idNumberValidation(String? value) {
  if (value == null) return 'ID number is required.';
  if (value.isEmpty) return 'ID number is required.';
  if (!value.isIDNumber) return 'Invalid ID number.';
  return null;
}

String? usernameValidation(String? value) {
  if (value == null) return 'username is required.';
  if (value.isEmpty) return 'username is required.';
  if (!value.isEmail && !value.isCellphone) return 'Invalid username.';
  return null;
}

String? passwordValidation(String? value) {
  if (value == null) return 'Password required.';
  if (value.isEmpty) return 'Password required.';
  if (value.length < 8) return 'Password must be atleast 8 characters long.';
  return null;
}

String? matchingPasswordValidation(String password, String? value) {
  if (value == null) return 'Confirm password required.';
  if (value.isEmpty) return 'Confirm password required.';
  if (value != password) return 'Passwords do not match';
  return null;
}
