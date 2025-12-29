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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // IMAGE
                  Image.asset(
                    controller.images[controller.currentIndex.value],
                    height: 220.h,
                  ),
                  SizedBox(height: 70.h),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.titles[controller.currentIndex.value],
                        style: AppTextStyles.bold32,
                      ),
                      Text(
                        controller.subtitles[controller.currentIndex.value],
                        style: AppTextStyles.regular16,
                      ),
                    ],
                  ),
                  // NEXT BUTTON
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.nextSlide();
                        },
                        child: CustomButton(childText: 'NEXT'),
                      ),
                      SizedBox(height: 24.h),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
