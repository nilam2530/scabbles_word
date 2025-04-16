import 'package:scabbles_word/src/utils/string_hardcoded_ext.dart';

class Validator {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email id/Phone number'.hardcoded;
    }
    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email id'.hardcoded;
    }
    return null;
  }

  static String? validateEmailOrPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email id/Phone number'.hardcoded;
    }

    final emailRegExp =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    final phoneRegExp = RegExp(
        r'^\+?[0-9]{10,13}$'); // Adjust according to the phone number format you expect

    if (!emailRegExp.hasMatch(value) && !phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid email id or phone number'.hardcoded;
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password'.hardcoded;
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long'.hardcoded;
    }
    if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
      return 'Password must contain at least one lowercase letter'.hardcoded;
    }
    if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
      return 'Password must contain at least one uppercase letter'.hardcoded;
    }
    if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
      return 'Password must contain at least one number'.hardcoded;
    }
    if (!RegExp(r'(?=.*[\W_])').hasMatch(value)) {
      return 'Password must contain at least one special character'.hardcoded;
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String? original) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password'.hardcoded;
    }

    if (value != original) {
      return 'Passwords do not match'.hardcoded;
    }
    return null;
  }

  static String? validateMobile(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number'.hardcoded;
    }
    final mobileRegExp = RegExp(r'^[0-9]{10}$');
    if (!mobileRegExp.hasMatch(value)) {
      return 'Mobile number must be 10 digits long'.hardcoded;
    }
    return null;
  }
}
