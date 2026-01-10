import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/home/controllers/home_controller.dart';

import '../../common_widgets/custom_progress_container.dart';

class StudyGuideListView extends StatelessWidget {
  const StudyGuideListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();

    return Obx(() {
      // Show loading indicator
      if (homeController.isLoading.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Show error message
      if (homeController.errorMessage.value.isNotEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            homeController.errorMessage.value,
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );
      }

      // Show empty state
      if (homeController.studyGuides.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'No study guides available',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
      
      //Item number
      final item = homeController.studyGuides.length;

      // Show study guides list
      return ListView.builder(
        itemCount: item > 4 ? 4 : item,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          final studyGuide = homeController.studyGuides[index];

          return CustomProgressContainer(
            title: studyGuide.title,
            progress:
                0.8, // You can replace this with actual progress data if available
            progressComplete:
                '55% Complete', // You can customize this based on your data
            // Add any additional properties your CustomProgressContainer accepts
          );
        },
      );
    });
  }
}
