import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

class SpiFundamentalsCard extends StatelessWidget {
  final String timeText; // e.g. "9 hours"
  final String chapterText; // e.g. "5/13 Chapters"
  final String progressPercentText; // e.g. "75%"
  final double progressValue;

  const SpiFundamentalsCard({
    super.key,
    required this.timeText,
    required this.chapterText,
    required this.progressPercentText,
    required this.progressValue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 400,
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.appBarBack,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Image.asset(ImagePath.bookImage, scale: 4),
                ),
              ),
              Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: Text(
                    "SPI",
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text('SPI Fundamentals', style: AppTextStyles.bold18),
          Text(
            'Master the core principles of ultrasound physics and',
            style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          ),
          SizedBox(height: 15.h),
          Row(
            children: [
              Image.asset(ImagePath.clockImage, scale: 4),
              SizedBox(width: 5.w),
              Text(
                timeText,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
              SizedBox(width: 8.w),
              Image.asset(ImagePath.arrowCircle, scale: 4),
              SizedBox(width: 5.w),
              Text(
                chapterText,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Text(
                'Progress',
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
              Spacer(),
              Text(
                progressPercentText,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.appBarSub,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(6),
            minHeight: 8,
            valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
            backgroundColor: AppColors.whiteColor,
            value: progressValue,
          ),
          SizedBox(height: 20.h),
          CustomButton(
            childText: 'Continue Reading',
            onTap: () => Get.toNamed(Routes.SPI_FUNDAMENTALS),
          ),
        ],
      ),
    );
  }
}
