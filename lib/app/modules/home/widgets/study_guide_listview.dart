import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_progress_container.dart';

class StudyGuideListView extends StatelessWidget {
  const StudyGuideListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      if (homeController.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
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
                Routes.SPI_FUNDAMENTALS,
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
