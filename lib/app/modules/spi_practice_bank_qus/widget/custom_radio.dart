import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/app_text_styles.dart';

class CustomRadio extends StatelessWidget {
  final String? title;
  final void Function()? onTap;
  final IconData icon;
  final Color borderColor;
  final Color textColor;
  final Color iconColor;
  final Color boxColor;

  const CustomRadio({
    super.key,
    this.title,
    this.onTap,
    required this.icon,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
    required this.boxColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: borderColor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title ?? '',
                  style: AppTextStyles.medium12.copyWith(color: textColor),
                ),
              ),
              Icon(icon, color: iconColor),
            ],
          ),
        ),
      ),
    );
  }
}
