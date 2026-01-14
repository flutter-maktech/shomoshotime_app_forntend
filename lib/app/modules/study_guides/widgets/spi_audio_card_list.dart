// SpiAudioCardList.dart (updated)
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/study_guides_controller.dart';
import 'study_guide_card.dart';

class SpiAudioCardList extends StatelessWidget {
  const SpiAudioCardList({super.key});

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