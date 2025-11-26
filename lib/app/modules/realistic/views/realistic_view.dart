import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/realistic_controller.dart';

class RealisticView extends GetView<RealisticController> {
  const RealisticView({super.key});

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
                    Image.asset(ImagePath.realistic, height: 200.h),
                    SizedBox(height: 100.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Realistic Mock Exams',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.bold32,
                        ),
                        Text(
                          'Simulate the real exam experience and build your confidence',
                          style: AppTextStyles.regular16,
                        ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                    CustomButton(childText: 'NEXT'),
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
