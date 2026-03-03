import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';
import 'package:shomoshotime/app/modules/common_widgets/shimmer_effect.dart';

import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_progress_container.dart';

class StudyGuideListView extends StatelessWidget {
  const StudyGuideListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      if (homeController.isLoading.value &&
          homeController.studyGuides.isEmpty) {
        return Column(
          children: List.generate(
            4,
            (index) => Padding(
              padding: EdgeInsets.symmetric(vertical: 4.w),
              child: ShimmerWrapper(
                isLoading: true,
                height: 80.h,
                child: const SizedBox.shrink(),
              ),
            ),
          ),
        );
      }

      if (homeController.errorMessage.value.isNotEmpty) {
        return Text(homeController.errorMessage.value);
      }

      final pdfStudyGuides = homeController.studyGuides
          .where((e) => e.file!.toLowerCase().endsWith('.pdf'))
          .toList();

      if (pdfStudyGuides.isEmpty) {
        return const Text('No study guides available');
      }

      return ListView.builder(
        itemCount: pdfStudyGuides.length > 4 ? 4 : pdfStudyGuides.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final studyGuide = pdfStudyGuides[index];

          return CustomProgressContainer(
            title: studyGuide.title,
            onTap: () {
              Get.toNamed(
                Routes.spiFundamentals,
                arguments: {
                  'pdfUrl': studyGuide.file,
                  'title': studyGuide.title,
                  'contentId': studyGuide.id,
                },
              );
            },
            progress: studyGuide.studyGuidePercentCompleted / 100,
            progressComplete:
                '${studyGuide.studyGuidePercentCompleted.round()}% completed',
          );
        },
      );
    });
  }
}
