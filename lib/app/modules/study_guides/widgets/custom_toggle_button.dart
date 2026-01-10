import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../controllers/study_guides_controller.dart';

class CustomToggleButton extends StatelessWidget {
  const CustomToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudyGuidesController>();
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(170),
        color: AppColors.appBarBack,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Obx(
          () => Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.changeValue(0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.select.value == 0
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                  child: Text('Read'),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.changeValue(1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.select.value == 1
                        ? AppColors.primaryColor
                        : AppColors.whiteColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                  child: Text('Audio'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
