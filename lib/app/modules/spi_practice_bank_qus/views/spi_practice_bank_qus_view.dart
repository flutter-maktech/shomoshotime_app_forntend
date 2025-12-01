import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_progress.dart';

import '../../../routes/app_pages.dart';
import '../controllers/spi_practice_bank_qus_controller.dart';
import '../widget/custom_radio.dart';

class SpiPracticeBankQusView extends GetView<SpiPracticeBankQusController> {
  const SpiPracticeBankQusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Back to Practice'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              spiRow(),
              SizedBox(height: 14.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Question 1 of 5',
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
                    Obx(
                      () => Column(
                        children: [
                          CustomRadio(
                            title: '0.5 - 1 MHz',
                            icon: controller.selectedIndex.value == 0
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            onTap: () => controller.selectOption(0),
                          ),
                          CustomRadio(
                            title: '2 - 15 MHz',
                            icon: controller.selectedIndex.value == 1
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            onTap: () => controller.selectOption(1),
                          ),
                          CustomRadio(
                            title: '20 - 50 MHz',
                            icon: controller.selectedIndex.value == 2
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            onTap: () => controller.selectOption(2),
                          ),
                          CustomRadio(
                            title: '100 - 200 MHz',
                            icon: controller.selectedIndex.value == 3
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            onTap: () => controller.selectOption(3),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    CustomButton(
                      childText: "Submit Answer",
                      onTap: () {
                        Get.toNamed(Routes.SPI_PRACTICE_BANK_ANS);
                      },
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

  Row spiRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'SPI Practice Bank',
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
                    'SPI',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Text(
              'Easy',
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
