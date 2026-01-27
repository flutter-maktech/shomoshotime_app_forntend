import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';

class HomeGridDetails extends StatelessWidget {
  final String studyGuideProgress;
  final String flashCardProgress;
  final String practiceAccuracy;
  final String mockAccuracy;

  const HomeGridDetails({
    super.key,
    required this.studyGuideProgress,
    required this.flashCardProgress,
    required this.practiceAccuracy,
    required this.mockAccuracy,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10.h,
      children: [
        Row(
          spacing: 10.w,
          children: [
            _buildCard(
              title: "Study Guide\nProgress",
              value: studyGuideProgress,
              color: AppColors.homeGridColorOne,
            ),
            _buildCard(
              title: "Flash Card\nProgress",
              value: flashCardProgress,
              color: AppColors.homeGridColorTwo,
            ),
          ],
        ),
        Row(
          spacing: 10.w,
          children: [
            _buildCard(
              title: "Practice\nAccuracy",
              value: practiceAccuracy,
              color: AppColors.homeGridColorThree,
            ),
            _buildCard(
              title: "Mock \nAccuracy",
              value: mockAccuracy,
              color: AppColors.homeGridColorFour,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bold11.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
                Container(
                  // padding: EdgeInsets.all(6.sp),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(6.r),
                    child: Image.asset(
                      ImagePath.clock,
                      color: color,
                      height: 16.h,
                      width: 16.w,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: AppTextStyles.bold38.copyWith(color: AppColors.whiteColor),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
