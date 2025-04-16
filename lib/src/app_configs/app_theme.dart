import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme1 = ThemeData(
    primaryColor: const Color(0xFFF47E20),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFFF47E20)),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFFF47E20)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFF47E20)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Color(0xFFF47E20), fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFFF47E20)),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      ),
    ),
  );

  static final ThemeData theme2 = ThemeData(
    primaryColor: const Color(0xFF2EBD8D),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFF2EBD8D)),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF2EBD8D)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF2EBD8D)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Color(0xFF2EBD8D), fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF2EBD8D)),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      ),
    ),
  );

  static final ThemeData theme3 = ThemeData(
    primaryColor: const Color(0xFF3B75F4),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFF3B75F4)),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF3B75F4)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF3B75F4)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Color(0xFF3B75F4), fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF3B75F4)),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      ),
    ),
  );

  static final ThemeData theme4 = ThemeData(
    primaryColor: const Color(0xFF24446F),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFF24446F)),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF24446F)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF24446F)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Color(0xFF24446F), fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF24446F)),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      ),
    ),
  );

  static final ThemeData theme5 = ThemeData(
    primaryColor: const Color(0xFFFE6760),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFFFE6760)),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFFFE6760)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFFFE6760)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Color(0xFFFE6760), fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFFFE6760)),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      ),
    ),
  );

  static final ThemeData theme6 = ThemeData(
    primaryColor: const Color(0xFF35BF91),
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xFF35BF91)),
    buttonTheme: const ButtonThemeData(buttonColor: Color(0xFF35BF91)),
    colorScheme:
        ColorScheme.fromSwatch().copyWith(secondary: const Color(0xFF35BF91)),
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(color: Color(0xFF35BF91), fontSize: 20),
      contentTextStyle: TextStyle(color: Colors.black),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: const Color(0xFF35BF91)),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll<Color>(Colors.white),
      ),
    ),
  );

  static final Map<String, ThemeData> themes = {
    'theme1': theme1,
    'theme2': theme2,
    'theme3': theme3,
    'theme4': theme4,
    'theme5': theme5,
    'theme6': theme6,
  };
}
