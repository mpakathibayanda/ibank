import 'package:ibank/core/extensions/string_ext.dart';

String? firstNameValidation(String? value) {
  if (value == null) return 'First name is required.';
  if (value.isEmpty || value.length < 3 || value.startsWith(' ')) {
    return 'Invalid first name.';
  }
  return null;
}

String? lastNameValidation(String? value) {
  if (value == null) return 'Last name is required.';
  if (value.isEmpty || value.length < 3 || value.startsWith(' ')) {
    return 'Invalid last name.';
  }
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
  if (!value.isCellphone) {
    return 'Invalid phone number, phone must start with +';
  }
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
  if (value.isEmpty || value.startsWith(' ')) return 'Invalid Password.';
  if (value.length < 8) return 'Password must be atleast 8 characters long.';
  return null;
}

String? matchingPasswordValidation(String password, String? value) {
  if (value == null) return 'Confirm password required.';
  if (value.isEmpty) return 'Confirm password required.';
  if (value != password) return 'Passwords do not match';
  return null;
}

String? accountNumberValidation(String? value) {
  if (value == null) return 'Account number is required.';
  if (value.isEmpty || value.length < 5 || value.startsWith(' ')) {
    return 'Invalid Account number.';
  }
  return null;
}

String? accountNameValidation(String? value) {
  if (value == null) return 'Account name is required.';
  if (value.isEmpty || value.length < 5 || value.startsWith(' ')) {
    return 'Invalid Account name.';
  }
  return null;
}

String? amountValidation(String? value) {
  if (value == null) return 'Account name is required.';
  if (value.isEmpty || value.startsWith(' ')) {
    return 'Account name is required.';
  }
  final amount = double.tryParse(value);
  if (amount == null) return 'Invalid amount.';
  if (amount.isNegative) return 'Amount must not be negative.';
  return null;
}

String? requiredValidation(String? value) {
  if (value == null) return 'Account name is required.';
  if (value.isEmpty || value.startsWith(' ')) {
    return 'Account name is required.';
  }
  return null;
}
