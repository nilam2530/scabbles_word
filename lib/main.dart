import 'package:flutter/material.dart';
import 'package:scabbles_word/src/services/injection_container.dart'; // Import the service locator
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'my_app.dart';

void main() async {
  // Initialize the service locator
setupLocator();
  runApp(
    ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => const MyApp(),
    ),
  );
}
