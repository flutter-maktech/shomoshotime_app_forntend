import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../common_widgets/shimmer_effect.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import 'home_grid_details.dart';

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
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            final controller = Get.find<HomeController>();
            return Text(
              "Welcome back,\n${controller.userName.value.split(' ').first}!",
              style: AppTextStyles.spaceGroteskMedium20,
            );
          }),
          SizedBox(height: 22.h),
          Obx(() {
            final controller = Get.find<HomeController>();
            final analytics = controller.userAnalyticsData.isNotEmpty
                ? controller.userAnalyticsData[0]
                : null;

            return ShimmerWrapper(
              isLoading: controller.isLoading.value && analytics == null,
              height: 160.h,
              child: HomeGridDetails(
                studyGuideProgress:
                    "${analytics?.studyAnalytics.progressPercent.toInt() ?? 0}%",
                flashCardProgress:
                    "${analytics?.flashcardAnalytics.progressPercent.toInt() ?? 0}%",
                practiceAccuracy:
                    "${analytics?.practiceAccuracy.toInt() ?? 0}%",
                mockAccuracy: "${analytics?.mocktestAccuracy.toInt() ?? 0}%",
              ),
            );
          }),
        ],
      ),
    );
  }
}
