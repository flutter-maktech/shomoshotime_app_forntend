import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/interactive_flashcards_controller.dart';

class InteractiveFlashcardsView
    extends GetView<InteractiveFlashcardsController> {
  const InteractiveFlashcardsView({super.key});

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
                    Image.asset(ImagePath.interactive, height: 200.h),
                    SizedBox(height: 100.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interactive Flashcards',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bold32,
                        ),
                        Text(
                          'Master key concepts with our smart flashcard system and track your progress',
                          style: AppTextStyles.regular16,
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.PRACTICE);
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
