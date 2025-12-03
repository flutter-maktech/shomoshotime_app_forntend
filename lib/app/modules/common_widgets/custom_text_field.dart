import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final String? topHintText;
  final String hintText;

  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    this.topHintText,
    required this.hintText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topHintText ?? '',
            style: AppTextStyles.regular12.copyWith(
              color: AppColors.hintTextColor,
            ),
          ),
          SizedBox(height: 4.h),
          TextField(
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: AppTextStyles.regular16.copyWith(
                color: AppColors.hintTextColor,
              ),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}
