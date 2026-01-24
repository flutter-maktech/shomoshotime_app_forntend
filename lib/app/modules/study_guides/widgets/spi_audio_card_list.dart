// SpiAudioCardList.dart (updated)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/study_guides_controller.dart';
import 'study_guide_card.dart';

class SpiAudioCardList extends StatelessWidget {
  const SpiAudioCardList({super.key});

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
        true, // isAudioView = true for Audio
      );

      // Empty state after filtering
      if (filteredStudyGuides.isEmpty) {
        return SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              studyGuidesController.searchQuery.value.isNotEmpty
                  ? 'No audio study guides found for "${studyGuidesController.searchQuery.value}"'
                  : 'No audio study guides available',
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Data state
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final audioGuide = filteredStudyGuides[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: StudyGuideCard(
              cardTitle: audioGuide.title,
              cardSubtitle: audioGuide.subtitle,
              category: audioGuide.category,
              audioUrl: audioGuide.file!,
            ),
          );
        }, childCount: filteredStudyGuides.length),
      );
    });
  }
}
