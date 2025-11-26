import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'custom_progress.dart';

class CustomProgressContainer extends StatelessWidget {
  final String? title;
  final String? suffixTitle;
  final String? subTitleContainerText;
  final String? subTitleText;
  final double? progress;
  final String? progressComplete;

  const CustomProgressContainer({
    super.key,
    this.title,
    this.subTitleContainerText,
    this.subTitleText,
    this.progress,
    this.suffixTitle,
    this.progressComplete,
  });

  @override
  Widget build(BuildContext context) {
    final hasSubtitle =
        (subTitleContainerText != null &&
            subTitleContainerText!.trim().isNotEmpty) ||
        (subTitleText != null && subTitleText!.trim().isNotEmpty);

    return Container(
      padding: EdgeInsets.all(14.sp),
      margin: EdgeInsets.symmetric(vertical: 4.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.progressContainerBg,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title ?? '',
                    style: AppTextStyles.regular12,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                Text(suffixTitle ?? '', style: AppTextStyles.regular8),
              ],
            ),
          ),
          if (hasSubtitle)
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  if (subTitleContainerText != null &&
                      subTitleContainerText!.trim().isNotEmpty)
                    Container(
                      height: 15.h,
                      padding: EdgeInsets.symmetric(horizontal: 6.w),
                      margin: EdgeInsets.only(right: 7.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        color: AppColors.primaryColor,
                      ),
                      child: Center(
                        child: Text(
                          subTitleContainerText!,
                          style: AppTextStyles.regular8,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  if (subTitleText != null && subTitleText!.trim().isNotEmpty)
                    Expanded(
                      child: Text(
                        subTitleText!,
                        style: AppTextStyles.regular8,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                ],
              ),
            ),
          CustomProgress(progress: progress ?? 0.0),
          if (progressComplete != null && progressComplete!.trim().isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 6.h),
              child: Text(
                progressComplete!,
                style: AppTextStyles.regular12,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
        ],
      ),
    );
  }
}
