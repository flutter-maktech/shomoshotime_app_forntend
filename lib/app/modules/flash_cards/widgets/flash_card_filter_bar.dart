import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class FlashCardFilterBar extends StatelessWidget {
  const FlashCardFilterBar({
    super.key,
    required this.title,
    required this.index,
    this.onTap,
    required this.isSelected,
  });

  final String title;
  final int index;
  final Function()? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          ),
          child: Text(
            title,
            style: AppTextStyles.regular12.copyWith(
              color: isSelected ? Colors.black : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
