import 'package:scabbles_word/src/themes/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import screen utils for responsiveness

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool fullWidth;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? borderColor;
  final Widget? imageIcon; // Icon widget for Google sign-in button, etc.

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.fullWidth = true,
    this.backgroundColor = Colors.black,
    this.foregroundColor = Colors.white,
    this.borderColor,
    this.imageIcon,
  });

  @override
  Widget build(BuildContext context) {
    return _buildButton();
  }

  Widget _buildButton() {
    return Row(
      children: [
        if (!fullWidth) const Spacer(),
        Expanded(
          flex: fullWidth ? 1 : 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  vertical: 14.h,
                  horizontal: 28.w), // Responsive padding using ScreenUtil
              minimumSize: Size(430.w, 44.h), // Set a responsive minimum size
              backgroundColor: backgroundColor,
              foregroundColor: foregroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(6.r),
                  bottomLeft: Radius.circular(6.r),
                  bottomRight: Radius.circular(6.r),
                  topRight: Radius.circular(6.r),
                ), // Responsive border radius
                side: BorderSide(
                  color: borderColor ?? Colors.transparent,
                  width: 0.5.w, // Responsive border width
                ),
              ),
            ),
            onPressed: onPressed,
            child: Opacity(
              opacity: onPressed == null
                  ? 0.5
                  : 1.0, // Adjust opacity based on button state
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageIcon != null) ...[
                    imageIcon!, // Display the imageIcon if it's provided
                    SizedBox(
                        width:
                            10.w), // Responsive spacing between icon and text
                  ],
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: ralewayTextStyel.copyWith(
                      fontSize: 6.sp, // Responsive text size using .sp
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
