import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';

class Grid extends StatelessWidget {
  final String firstCardValue;
  final String firstCardChartValue;
  final String secondCardValue;
  final String secondCardChartValue;
  final String thirdCardValue;
  final String thirdCardChartValue;
  final String fourthCardValue;
  final String fourthCardChartValue;

  const Grid({
    super.key,
    required this.firstCardValue,
    required this.firstCardChartValue,
    required this.secondCardValue,
    required this.secondCardChartValue,
    required this.thirdCardValue,
    required this.thirdCardChartValue,
    required this.fourthCardValue,
    required this.fourthCardChartValue,
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
              title: "Study\nHours",
              value: firstCardValue,
              color: AppColors.homeGridColorOne,
              chartValue: firstCardChartValue,
            ),
            _buildCard(
              title: "Practice\nQuestion",
              value: secondCardValue,
              color: AppColors.homeGridColorTwo,
              chartValue: secondCardChartValue,
            ),
          ],
        ),
        Row(
          spacing: 10.w,
          children: [
            _buildCard(
              title: "Flashcards\nMastered",
              value: thirdCardValue,
              color: AppColors.homeGridColorThree,
              chartValue: thirdCardChartValue,
            ),
            _buildCard(
              title: "Mock Exams\nCompleted",
              value: fourthCardValue,
              color: AppColors.homeGridColorFour,
              chartValue: fourthCardChartValue,
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
    required String chartValue,
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: [
            //     Image.asset(ImagePath.chart, height: 16.h, width: 16.w),
            //     Expanded(
            //       child: Text(
            //         " +$chartValue this week",
            //         style: AppTextStyles.regular12.copyWith(
            //           color: AppColors.whiteColor,
            //         ),
            //         overflow: TextOverflow.ellipsis,
            //         maxLines: 1,
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
