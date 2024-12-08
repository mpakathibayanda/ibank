extension StringExt on String {
  bool get isEmail {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  bool get isCellphone {
    final international = RegExp(
      r'^\+?[1-9]\d{1,14}$',
    );

    final local = RegExp(r'^0[6-8]\d{8}$');
    return international.hasMatch(this) || local.hasMatch(this);
  }

  bool get isIDNumber {
    // Regular expression for basic South African ID structure
    final idRegex = RegExp(r'^\d{13}$');

    // Check if the format is correct
    if (!idRegex.hasMatch(this)) {
      return false;
    }

    // Extract parts of the ID
    final birthDate = substring(0, 6); // YYMMDD
    final luhnDigit = int.parse(substring(12)); // Checksum (Z)

    // Validate date format (YYMMDD)
    if (!_isValidDate(birthDate)) {
      return false;
    }

    // Validate checksum using Luhn algorithm
    return _isValidLuhn(this, luhnDigit);
  }

  // Helper function to validate date format
  bool _isValidDate(String birthDate) {
    try {
      final year = int.parse(birthDate.substring(0, 2));
      final month = int.parse(birthDate.substring(2, 4));
      final day = int.parse(birthDate.substring(4, 6));

      // Validate ranges for month and day
      if (month < 1 || month > 12 || day < 1 || day > 31) {
        return false;
      }

      // Additional check for valid dates (leap years, etc.)
      final yearFull = year + 1900; // Assume 1900s (adjust as needed)
      final date = DateTime(yearFull, month, day);
      return date.year == yearFull && date.month == month && date.day == day;
    } catch (_) {
      return false;
    }
  }

  // Helper function to validate the Luhn algorithm
  bool _isValidLuhn(String idNumber, int checkDigit) {
    final digits = idNumber.substring(0, 12).split('').map(int.parse).toList();

    int sum = 0;
    for (int i = 0; i < digits.length; i++) {
      int digit = digits[i];
      if (i % 2 != 0) {
        // Double every second digit from the right
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
    }

    // Luhn validation: (sum + checkDigit) % 10 == 0
    return (sum + checkDigit) % 10 == 0;
  }
}
