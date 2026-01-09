import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/modules/home/widgets/grid.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';

class StudyHeaderInfo extends StatelessWidget {
  const StudyHeaderInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.homeStack.withAlpha(200),
            blurRadius: 10,
            spreadRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back,\nSarah!",
            style: AppTextStyles.spaceGroteskMedium20,
          ),
          SizedBox(height: 22.h),
          Grid(
            firstCardValue: "24.5",
            firstCardChartValue: "5.2",
            secondCardValue: "24.5",
            secondCardChartValue: "5.2",
            thirdCardValue: "24.5",
            thirdCardChartValue: "5.2",
            fourthCardValue: "24.5",
            fourthCardChartValue: "5.2",
          ),
        ],
      ),
    );
  }
}
