import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/app_colors.dart';
import '../../data/app_text_styles.dart';

class CustomRichText extends StatelessWidget {
  final String firstText;
  final String secondText;
  final Color? firstTextColor;
  final Color? secondTextColor;
  final void Function()? onTap;

  const CustomRichText({
    super.key,
    required this.firstText,
    required this.secondText,
    this.firstTextColor,
    this.secondTextColor, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            firstText,
            style: AppTextStyles.regular12.copyWith(
              color: firstTextColor ?? AppColors.blackColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.h),
              child: Text(
                secondText,
                style: AppTextStyles.bold12.copyWith(
                  color: secondTextColor ?? AppColors.blueColor,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
