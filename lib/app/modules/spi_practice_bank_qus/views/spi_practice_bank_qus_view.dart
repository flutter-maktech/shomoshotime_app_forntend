import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_progress.dart';

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
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.h),
                CustomProgress(
                  progress: .2,
                  progressColor: AppColors.appBarCircleAvatarColor,
                ),
              ],
            ),
            SizedBox(height: 30.h),

            Container(
              padding: EdgeInsets.all(14.sp),
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.homeStack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    'What is the typical frequency range for diagnostic ultrasound?',
                  ),
                  SizedBox(height: 24.h),
                  Image.asset(ImagePath.spiPracticeBank, height: 200.h),
                  SizedBox(height: 24.h),
                  CustomRadio(
                    title: '100 - 200 MHz',
                    onPressed: (){},
                  ),
                  CustomButton(childText: "Submit Answer"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }






















  Row spiRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('SPI Practice Bank', style: AppTextStyles.spaceGroteskMedium20),
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ],
    );
  }
}

