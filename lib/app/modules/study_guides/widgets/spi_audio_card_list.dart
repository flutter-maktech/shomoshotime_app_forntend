// SpiAudioCardList.dart (updated)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/shimmer_effect.dart';
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
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ShimmerWrapper(
                isLoading: true,
                height: 120.h,
                child: const SizedBox.shrink(),
              ),
            ),
            childCount: 5,
          ),
        );
      }

      // Filter study guides
      final filteredStudyGuides = studyGuidesController.getLocalFilteredGuides(
        studyGuidesController.allStudyGuides,
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
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }

      // Data state
      return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final audioGuide = filteredStudyGuides[index];
          studyGuidesController.confirmFileUsage(audioGuide);
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: StudyGuideCard(
              cardTitle: audioGuide.title,
              cardSubtitle: audioGuide.subtitle,
              category: audioGuide.category,
              audioUrl: audioGuide.fileUrl ?? '',
            ),
          );
        }, childCount: filteredStudyGuides.length),
      );
    });
  }
}
