import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_progress.dart';
import '../controllers/spi_practice_bank_qus_controller.dart';
import '../widget/custom_radio.dart';

class SpiPracticeBankQusView extends GetView<SpiPracticeBankQusController> {
  const SpiPracticeBankQusView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final String title = args != null && args['title'] != null
        ? args['title'] as String
        : 'No title available';
    final String category = args != null && args['category'] != null
        ? args['category'] as String
        : 'N/A';
    final String statusLabel = args != null && args['staus_label'] != null
        ? args['staus_label'] as String
        : 'N/A';

    return Scaffold(
      appBar: const CustomAppBar(title: 'Back to Practice'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Obx(() {
          // Show loading if question list is empty
          if (controller.isloading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.questionList.isEmpty) {
            return const Center(child: Text('No questions available.'));
          }
          final question =
              controller.questionList[controller.currentQuestionIndex.value];
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                spiRow(title, category, statusLabel),
                SizedBox(height: 14.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question of ${controller.questionList.length}',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.appBarSub,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    CustomProgress(
                      progress:
                          (controller.currentQuestionIndex.value + 1) /
                          controller.questionList.length,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(14.sp),
                  margin: EdgeInsets.symmetric(vertical: 30.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.homeStack,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      // Question Text
                      Text(question.question, style: AppTextStyles.regular16),
                      SizedBox(height: 10.h),
                      // Question Image
                      if (question.file.isNotEmpty)
                        Image.network(
                          question.file,
                          height: 200.h,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Image not available');
                          },
                        ),
                      SizedBox(height: 20.h),
                      // Options
                      ...List.generate(4, (index) {
                        final options = [
                          question.optionA,
                          question.optionB,
                          question.optionC,
                          question.optionD,
                        ];

                        Color borderColor = AppColors.subscriptionPlanButton;
                        Color textColor = AppColors.blackColor;
                        Color iconColor = AppColors.subscriptionPlanButton;
                        Color boxColor = AppColors.whiteColor;

                        if (controller.showResult.value) {
                          if (index == controller.correctIndex.value) {
                            borderColor = AppColors.greenColor;
                            textColor = AppColors.greenColor;
                            iconColor = AppColors.greenColor;
                            boxColor = AppColors.greenColor.withAlpha(20);
                          } else if (index == controller.selectedIndex.value &&
                              !controller.isCorrectAnswer.value) {
                            borderColor = AppColors.readColor;
                            textColor = AppColors.readColor;
                            iconColor = AppColors.readColor;
                            boxColor = AppColors.readColor.withAlpha(20);
                          }
                        } else if (controller.selectedIndex.value == index) {
                          borderColor = AppColors.subscriptionPlanButton;
                          iconColor = AppColors.subscriptionPlanButton;
                          boxColor = AppColors.whiteColor;
                        }

                        return CustomRadio(
                          title: options[index],
                          icon: controller.selectedIndex.value == index
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          borderColor: borderColor,
                          textColor: textColor,
                          iconColor: iconColor,
                          boxColor: boxColor,
                          onTap: controller.showResult.value
                              ? null
                              : () => controller.selectOption(index),
                        );
                      }),
                      SizedBox(height: 20.h),
                      // Correct / Incorrect Box
                      if (controller.showResult.value)
                        Container(
                          padding: EdgeInsets.all(12.sp),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.sp),
                            color: controller.isCorrectAnswer.value
                                ? AppColors.greenColor.withAlpha(20)
                                : AppColors.readColor.withAlpha(20),
                            border: Border.all(
                              color: controller.isCorrectAnswer.value
                                  ? AppColors.greenColor.withAlpha(35)
                                  : AppColors.readColor.withAlpha(35),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                controller.isCorrectAnswer.value
                                    ? Icons.check_circle
                                    : Icons.cancel,
                                color: controller.isCorrectAnswer.value
                                    ? AppColors.greenColor
                                    : AppColors.readColor,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                controller.isCorrectAnswer.value
                                    ? "Correct Answer"
                                    : "Incorrect Answer",
                                style: AppTextStyles.regular14.copyWith(
                                  color: controller.isCorrectAnswer.value
                                      ? AppColors.greenColor
                                      : AppColors.readColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      SizedBox(height: 20.h),
                      // Submit / Next / Done Button
                      CustomButton(
                        childText: controller.isFinished.value
                            ? "Done"
                            : controller.showResult.value
                            ? "Next"
                            : "Submit Answer",
                        onTap: () {
                          if (controller.isFinished.value) {
                            Get.back(result: true);
                          } else if (controller.showResult.value) {
                            controller.goToNextQuestion();
                          } else {
                            controller.submitAnswer();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Row spiRow(String title, String category, String statusLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyles.spaceGroteskMedium20,
            // overflow: TextOverflow.ellipsis,
            // maxLines: 1,
          ),
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.homeStack,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                child: Center(
                  child: Text(
                    category,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              statusLabel,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.appBarSub,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
