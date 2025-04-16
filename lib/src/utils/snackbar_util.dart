import 'package:flutter/material.dart';

class SnackbarUtil {
  static void showSnackbar(BuildContext context,
      {required String message, bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.black,
      ),
    );
  }
}
