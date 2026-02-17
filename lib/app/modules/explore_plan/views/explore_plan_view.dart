import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import '../controllers/explore_plan_controller.dart';

class ExplorePlanView extends GetView<ExplorePlanController> {
  const ExplorePlanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.explore_outlined,
                size: 80.h,
                color: AppColors.primaryColor,
              ),
              SizedBox(height: 24.h),
              Text(
                'Explore Plans',
                style: AppTextStyles.medium24.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Unlock premium features and enhance your experience by exploring our available plans.',
                textAlign: TextAlign.center,
                style: AppTextStyles.regular14.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 48.h),
              CustomButton(
                childText: 'Explore Plans',
                onTap: () {
                  Get.toNamed(Routes.SUBSCRIPTION_PLAN);
                },
                buttonColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
