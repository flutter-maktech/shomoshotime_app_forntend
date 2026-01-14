// SpiCardList.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/study_guides_controller.dart';
import 'spi_fundamentals_card.dart';

class SpiCardList extends StatelessWidget {
  const SpiCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final studyGuidesController = Get.find<StudyGuidesController>();

    return Obx(() {
      // Loading state
      if (homeController.isLoading.value) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      // Error state
      if (homeController.errorMessage.value.isNotEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              homeController.errorMessage.value,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Filter study guides
      final filteredStudyGuides = studyGuidesController.filterStudyGuides(
        homeController.studyGuides,
        studyGuidesController.selectedCategory.value,
        studyGuidesController.searchQuery.value,
        false, // isAudioView = false for PDF
      );

      // Empty state after filtering
      if (filteredStudyGuides.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              studyGuidesController.selectedCategory.value == 'All'
                  ? 'No PDF study guides available'
                  : 'No PDF study guides found for ${studyGuidesController.selectedCategory.value}',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Data state
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final studyGuide = filteredStudyGuides[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SpiFundamentalsCard(
              cardTitle: studyGuide.title,
              cardSubtitle: studyGuide.subtitle,
              category: studyGuide.category,
              fileUrl: studyGuide.file!,
              contentId: studyGuide.id,
              pageNumber:
                  '${studyGuide.studyGuideActivitiesCount}/${studyGuide.totalPage} Pages',
              progressPercentText:
                  '${(studyGuide.studyGuidePercentCompleted).round()}%',
              progressValue: studyGuide.studyGuidePercentCompleted / 100,
            ),
          );
        }, childCount: filteredStudyGuides.length),
      );
    });
  }
}