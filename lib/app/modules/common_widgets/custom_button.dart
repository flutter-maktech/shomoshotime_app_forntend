import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/app_colors.dart';
import '../../data/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  final String childText;
  final void Function()? onTap;
  final Color? buttonColor;
  final Color? buttonChildColor;

  const CustomButton({
    super.key,
    required this.childText,
    this.onTap,
    this.buttonColor,
    this.buttonChildColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.h,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: buttonColor ?? AppColors.primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            childText,
            style: AppTextStyles.spaceGroteskMedium16.copyWith(
              color: buttonChildColor ?? AppColors.blackColor,
            ),
          ),
        ),
      ),
    );
  }
}
