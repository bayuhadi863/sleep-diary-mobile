class TValidator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong.';
    }

    // Regex for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'Email tidak valid.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password tidak boleh kosong.';
    }

    // Check for minimum password length
    if (value.length < 8) {
      return 'Password minimal 8 karakter.';
    }

    // // Check for uppercase letters
    // if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Minimal ada satu huruf kapital.';
    // }

    // // Check for numbers
    // if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Minimal ada satu angka.';
    // }

    // // Check for special characters
    // if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return 'Minimal ada satu karakter spesial.';
    // }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama tidak boleh kosong.';
    }

    // Regex for name validation
    final nameRegExp = RegExp(r'^[A-Za-z\s]+$');

    if (!nameRegExp.hasMatch(value)) {
      return 'Nama tidak valid.';
    }

    return null;
  }

  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      return '$fieldName tidak boleh kosong.';
    }

    return null;
  }
}
