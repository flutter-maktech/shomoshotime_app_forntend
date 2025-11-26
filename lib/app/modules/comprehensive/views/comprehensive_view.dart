import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

import '../controllers/comprehensive_controller.dart';

class ComprehensiveView extends GetView<ComprehensiveController> {
  const ComprehensiveView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.h),
                child: Column(
                  children: [
                    Image.asset(ImagePath.comprehensiveStudy, height: 200.h),
                    SizedBox(height: 100.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Comprehensive Study Guides',maxLines: 1,overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bold32,
                        ),
                        Text(
                          'Access detailed study materials for SPI, Vascular, OB/GYN,and Abdomen specialties',
                          style: AppTextStyles.regular16,
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.INTERACTIVE_FLASHCARDS);
                      },
                      child: CustomButton(childText: 'NEXT'),
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
