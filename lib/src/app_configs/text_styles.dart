import 'package:flutter/material.dart';

import 'app_colors.dart';

TextStyle textStyle() {
  return TextStyle(
    fontFamily: 'Gotham-Bold',
    fontSize: 14,
    fontWeight: FontWeight.w500,
    height: 18 / 14,
    color: AppColors.backgroundColorDash,
  );
}

TextStyle textStyleFont14W400Black() {
  return const TextStyle(
      fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.darBlack);
}


