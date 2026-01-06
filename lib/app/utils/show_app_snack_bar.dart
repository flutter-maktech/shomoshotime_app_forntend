import 'package:flutter/material.dart';

void showAppSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = const Color(0xFF323232),
  Color textColor = Colors.white,
  double borderRadius = 8,
  int durationSeconds = 2,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: durationSeconds),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    ),
  );
}
