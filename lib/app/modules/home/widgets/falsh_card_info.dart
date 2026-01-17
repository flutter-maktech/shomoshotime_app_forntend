import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_progress.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class FlashCardInfo extends StatelessWidget {
  const FlashCardInfo({
    super.key,
    required this.flashCardTitle,
    required this.flashCardSubtitle,
    required this.progress,
    this.onTap,
  });
  final String flashCardTitle, flashCardSubtitle;
  final double progress;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.sp),
        margin: EdgeInsets.symmetric(vertical: 4.w),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.progressContainerBg,
          borderRadius: BorderRadius.circular(4.r),
        ),
        child: Column(
          spacing: 5.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(flashCardTitle, style: AppTextStyles.regular14),
            Text(
              flashCardSubtitle,
              style: AppTextStyles.regular12.apply(color: AppColors.appBarSub),
            ),
            CustomProgress(progress: progress),
          ],
        ),
      ),
    );
  }
}
