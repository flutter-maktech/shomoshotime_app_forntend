// SpiCardList.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/shimmer_effect.dart';
import '../controllers/study_guides_controller.dart';
import 'spi_fundamentals_card.dart';

class SpiCardList extends StatelessWidget {
  const SpiCardList({super.key});

  @override
  Widget build(BuildContext context) {
    final studyGuidesController = Get.find<StudyGuidesController>();

    return Obx(() {
      // Loading state (Initial)
      if (studyGuidesController.isFetching.value &&
          studyGuidesController.allStudyGuides.isEmpty) {
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: ShimmerWrapper(
                isLoading: true,
                height: 150.h,
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
              style: const TextStyle(color: Colors.grey),
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
              fileUrl: studyGuide.fileUrl ?? '',
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
