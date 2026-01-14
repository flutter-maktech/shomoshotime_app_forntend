// CategoryFilterBar.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';
import '../../core/user_panel_model/study_guide_response_model.dart';
import '../../data/app_colors.dart';
import 'custom_build_container.dart';

class CategoryFilterBar extends StatelessWidget {
  const CategoryFilterBar({super.key, this.isAudioView = false});

  final bool isAudioView;

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      // Get unique categories based on current view type (audio or pdf)
      final categories = _getCategoriesForCurrentView(
        homeController.studyGuides,
        isAudioView,
      );

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
                  CustomBuildContainer(
                    title: allCategories[i],
                    index: i,
                    category: allCategories[i],
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }

  // Get categories for current view type
  // In CategoryFilterBar.dart - inside _getCategoriesForCurrentView method
  List<String> _getCategoriesForCurrentView(
    List<StudyGuide> studyGuides,
    bool isForAudio,
  ) {
    // Debug prints
    print('=== DEBUG: Category Filter ===');
    print('isAudioView: $isForAudio');
    print('Total study guides: ${studyGuides.length}');

    // Use the same filtering logic as SpiCardList and SpiAudioCardList
    final filteredGuides = studyGuides.where((guide) {
      final fileType = guide.fileType?.toLowerCase() ?? '';
      if (isForAudio) {
        // Same logic as SpiAudioCardList
        return fileType == 'mp3' ||
            fileType == 'm4a' ||
            fileType == 'wav' ||
            fileType == 'audio' ||
            fileType == 'aac';
      } else {
        // Same logic as SpiCardList
        return fileType == 'pdf';
      }
    }).toList();

    print('Filtered guides: ${filteredGuides.length}');

    // Extract unique categories
    final categories = filteredGuides
        .map((guide) => guide.category)
        .where((category) => category.isNotEmpty)
        .toSet() // Remove duplicates
        .toList();

    // Sort categories alphabetically
    categories.sort();

    print('Categories found: $categories');
    print('======================\n');

    return categories;
  }
}
