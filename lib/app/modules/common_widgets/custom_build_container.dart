import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/app_colors.dart';
import '../../data/app_text_styles.dart';
import '../study_guides/controllers/study_guides_controller.dart';

class CustomBuildContainer extends StatelessWidget {
  const CustomBuildContainer({
    super.key,
    required this.title,
    required this.index,
    required this.category,
  });

  final String title;
  final int index;
  final String category;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudyGuidesController>();
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.changeIndex(index);
          controller.setSelectedCategory(category);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: controller.selectIndex.value == index
                ? AppColors.primaryColor
                : AppColors.whiteColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              title,
              style: AppTextStyles.regular13.copyWith(
                color: controller.selectIndex.value == index
                    ? Colors.black
                    : AppColors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}