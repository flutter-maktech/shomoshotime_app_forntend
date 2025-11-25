import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';

class HomeViewGrid extends StatelessWidget {
  const HomeViewGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      crossAxisCount: 2,
      crossAxisSpacing: 14.w,
      mainAxisSpacing: 14.h,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.0,
      children: [
        _buildCard(
          title: "Study\nHours",
          value: "24.5",
          color: const Color(0xFF4DB6FF),
        ),
        _buildCard(
          title: "Practice\nQuestion",
          value: "24.5",
          color: const Color(0xFFFFC34D),
        ),
        _buildCard(
          title: "Flashcards\nMastered",
          value: "24.5",
          color: const Color(0xFFB36EFF),
        ),
        _buildCard(
          title: "Mock Exams\nCompleted",
          value: "24.5",
          color: const Color(0xFF3DDACF),
        ),
      ],
    );
  }

  Widget _buildCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bold12.copyWith(color: AppColors.whiteColor,height: 1.3.h),
                ),
              ),
              Container(
                padding: EdgeInsets.all(6.sp),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.access_time,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            value,
            style: AppTextStyles.bold40.copyWith(color: AppColors.whiteColor,height: 1.0.h),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Image.asset(ImagePath.chart,height: 16,),
              SizedBox(width: 6.w),
              Text(
                "+5.2 this week",
                style: AppTextStyles.regular12.copyWith(color: AppColors.whiteColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}