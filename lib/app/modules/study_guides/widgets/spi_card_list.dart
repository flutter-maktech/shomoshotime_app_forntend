// SpiCardList.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/study_guides_controller.dart';
import 'spi_fundamentals_card.dart';

class SpiCardList extends StatelessWidget {
  const SpiCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final studyGuidesController = Get.find<StudyGuidesController>();

    return Obx(() {
      // Loading state (Initial)
      if (studyGuidesController.isLoading.value &&
          studyGuidesController.allStudyGuides.isEmpty) {
        return const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      // Filter study guides
      final filteredStudyGuides = studyGuidesController.filterStudyGuides(
        studyGuidesController.allStudyGuides,
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
          studyGuidesController.confirmFileUsage(studyGuide);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: SpiFundamentalsCard(
              cardTitle: studyGuide.title,
              cardSubtitle: studyGuide.subtitle,
              category: studyGuide.category,
              fileUrl: studyGuide.file ?? '',
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
