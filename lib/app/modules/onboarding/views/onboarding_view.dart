import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Obx(
                    () => Column(
                  children: [
                    // IMAGE
                    Image.asset(
                      controller.images[controller.currentIndex.value],
                      height: 220.h,
                    ),

                    SizedBox(height: 70.h),

                    // TITLE + SUBTITLE
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 80.h,
                          child: Text(
                            controller.titles[controller.currentIndex.value],
                            style: AppTextStyles.bold32,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SizedBox(
                          height: 80.h,
                          child: Text(
                            controller.subtitles[controller.currentIndex.value],
                            style: AppTextStyles.regular16,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 30.h),

                    // NEXT BUTTON
                    InkWell(
                      onTap: () {
                        controller.nextSlide();
                      },
                      child: CustomButton(
                        childText: 'NEXT',
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        4,
                            (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          height: 8.h,
                          width: controller.currentIndex.value == index
                              ? 24.w
                              : 8.w,
                          decoration: BoxDecoration(
                            color: controller.currentIndex.value == index
                                ? AppColors.primaryColor
                                : Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(999.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
