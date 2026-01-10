import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../core/user_panel_model/study_guide_response_model.dart';
import '../../data/app_colors.dart';
import 'custom_build_container.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      // Get unique categories from study guides
      final categories = _getUniqueCategories(controller.studyGuides);

      // Add "All" option at the beginning
      final allCategories = ['All', ...categories];

      return Container(
        color: AppColors.appBarBack,
        width: double.infinity,
        height: 46.h,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Row(
              spacing: 25.w,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < allCategories.length; i++)
                  CustomBuildContainer(title: allCategories[i], index: i),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Helper method to extract unique categories
  List<String> _getUniqueCategories(List<StudyGuide> studyGuides) {
    final categories = studyGuides
        .map((guide) => guide.category)
        .where((category) => category.isNotEmpty)
        .toSet() // Remove duplicates
        .toList();

    // Sort categories alphabetically
    categories.sort();

    return categories;
  }
}
