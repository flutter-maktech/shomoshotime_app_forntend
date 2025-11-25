import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'custom_progress.dart';

class CustomProgressContainer extends StatelessWidget {
  final String? title;
  final String? subTitleContainerText;
  final String? subTitleText;
  final double? progress;

  const CustomProgressContainer({
    super.key,
    this.title,
    this.subTitleContainerText,
    this.subTitleText,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      margin: EdgeInsets.symmetric(vertical: 4.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.progressContainerBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title ?? '', style: AppTextStyles.regular12),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              children: [
                Container(
                  height: 17,
                  width: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      subTitleContainerText ?? '',
                      style: AppTextStyles.regular8,
                    ),
                  ),
                ),
                SizedBox(width: 7.w),
                Text(subTitleText ?? '', style: AppTextStyles.regular8),
              ],
            ),
          ),

          CustomProgress(progress: progress ?? .5),
        ],
      ),
    );
  }
}
