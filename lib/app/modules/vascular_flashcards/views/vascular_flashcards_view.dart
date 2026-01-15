import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';

import '../controllers/vascular_flashcards_controller.dart';

class VascularFlashcardsView extends GetView<FlashcardsSetController> {
  const VascularFlashcardsView({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['contentId'] != null) {
      controller.contentId.value = arguments['contentId'];
    }
    final title = arguments != null && arguments['title'] != null
        ? arguments['title'] as String
        : 'No Title available';

    return Scaffold(
      appBar: CustomAppBar(title: title),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Obx(() {
            // 1️⃣ LOADING STATE
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            // 2️⃣ ERROR STATE
            if (controller.errorMessage.value.isNotEmpty) {
              return Center(
                child: Text(
                  controller.errorMessage.value,
                  style: AppTextStyles.medium16.copyWith(
                    color: Colors.redAccent,
                  ),
                ),
              );
            }

            final cards = controller.cards;
            final totalQuestion = cards.length;

            // 3️⃣ EMPTY STATE (after loading finished)
            if (totalQuestion == 0) {
              return Center(
                child: Text(
                  'No questions available',
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.greyLight,
                  ),
                ),
              );
            }

            // 4️⃣ NORMAL FLOW (DATA EXISTS)
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Question ${controller.currentIndex.value + 1} of $totalQuestion',
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.greyLight,
                  ),
                ),
                SizedBox(height: 8.h),

                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: totalQuestion,
                    onPageChanged: controller.onPageChanged,
                    itemBuilder: (context, index) {
                      final question = cards[index].question;
                      final answer = cards[index].answer;

                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(question, style: AppTextStyles.bold24),
                            SizedBox(height: 16.h),

                            Obx(() {
                              if (controller.showAnswer.value &&
                                  controller.currentIndex.value == index) {
                                return Text(
                                  answer,
                                  style: AppTextStyles.regular16.copyWith(
                                    color: AppColors.greyLight,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // Show Answer Button
                if (!controller.showAnswer.value)
                  Padding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: controller.showAnswerText,
                        child: const Text('Show Answer'),
                      ),
                    ),
                  ),
                // Dots indicator
                if (totalQuestion > 0)
                  Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalQuestion, (index) {
                        final isActive = controller.currentIndex.value == index;

                        return GestureDetector(
                          onTap: () => controller.setIndex(index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            margin: EdgeInsets.symmetric(horizontal: 4.w),
                            width: isActive ? 24.w : 10.w,
                            height: 10.h,
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppColors.primaryColor
                                  : Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                // Back / Next buttons
                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => CustomButton(
                          onTap: () {
                            controller.changeButton(0);
                            if (controller.currentIndex.value > 0) {
                              controller.setIndex(
                                controller.currentIndex.value - 1,
                              );
                            }
                          },
                          buttonColor: controller.select.value == 0
                              ? AppColors.primaryColor
                              : AppColors.lightYellow,
                          childText: 'Back',
                        ),
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Obx(
                        () => CustomButton(
                          onTap: () {
                            controller.changeButton(1);
                            if (controller.currentIndex.value <
                                totalQuestion - 1) {
                              controller.setIndex(
                                controller.currentIndex.value + 1,
                              );
                            }
                          },
                          buttonColor: controller.select.value == 1
                              ? AppColors.primaryColor
                              : AppColors.lightYellow,
                          childText: 'Next',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
