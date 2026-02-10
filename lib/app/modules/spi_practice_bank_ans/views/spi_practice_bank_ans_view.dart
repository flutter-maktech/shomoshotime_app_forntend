import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_progress.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';
import '../../spi_practice_bank_qus/controllers/spi_practice_bank_qus_controller.dart';

class SpiPracticeBankAnsView extends GetView<SpiPracticeBankQusController> {
  const SpiPracticeBankAnsView({super.key});

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
      appBar: CustomAppBar(title: 'Back to Practice'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
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
                    'Question of ${controller.questionList.isNotEmpty ? controller.questionList.length : 0}',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomProgress(
                    progress: .2,
                    progressColor: AppColors.appBarCircleAvatarColor,
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
                    Text(
                      'What is the typical frequency range for diagnostic ultrasound?',
                      style: AppTextStyles.regular16,
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      child: Image.asset(
                        ImagePath.spiPracticeBank,
                        height: 200.h,
                      ),
                    ),

                    // RADIO LIST
                    // Obx(
                    //   () => Column(
                    //     children: [
                    //       CustomRadio(
                    //         title: '0.5 - 1 MHz',
                    //         icon: controller.selectedIndex.value == 0
                    //             ? Icons.radio_button_checked
                    //             : Icons.radio_button_off,
                    //         // onTap: () => controller.selectOption(0),
                    //       ),
                    //       CustomRadio(
                    //         title: '2 - 15 MHz',
                    //         icon: controller.selectedIndex.value == 1
                    //             ? Icons.radio_button_checked
                    //             : Icons.radio_button_off,
                    //         // onTap: () => controller.selectOption(1),
                    //       ),
                    //       CustomRadio(
                    //         title: '20 - 50 MHz',
                    //         icon: controller.selectedIndex.value == 2
                    //             ? Icons.radio_button_checked
                    //             : Icons.radio_button_off,
                    //         // onTap: () => controller.selectOption(2),
                    //       ),
                    //       CustomRadio(
                    //         title: '100 - 200 MHz',
                    //         icon: controller.selectedIndex.value == 3
                    //             ? Icons.radio_button_checked
                    //             : Icons.radio_button_off,
                    //         // onTap: () => controller.selectOption(3),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    SizedBox(height: 20.h),
                    Container(
                      padding: EdgeInsets.all(12.sp),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
                        color: AppColors.readColor.withAlpha(20),
                        border: Border.all(
                          color: AppColors.readColor.withAlpha(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(ImagePath.incorrect, height: 20.h),
                              SizedBox(width: 8.h),
                              Text(
                                "Incorrect",
                                style: AppTextStyles.regular14.copyWith(
                                  color: AppColors.readColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            "Diagnostic ultrasound typically uses frequencies between 2-15 MHz Higher frequencies providebetter resolution bur nave less penetration depth.",
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.incorrectColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.h),
                      child: CustomButton(
                        childText: "Next Question",
                        childImage: ImagePath.arrowForward,
                        onTap: () => Get.offAllNamed(
                          Routes.CUSTOM_BOTTOM_NAVIGATION_BAR,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row spiRow(String title, String category, String statusLabel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.spaceGroteskMedium20,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
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
