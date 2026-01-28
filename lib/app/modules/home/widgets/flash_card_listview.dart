import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/shimmer_effect.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';
import 'falsh_card_info.dart';

class FlashCardListView extends StatelessWidget {
  const FlashCardListView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    return Obx(() {
      // Show loading indicator
      if (homeController.isLoading.value && homeController.flashCards.isEmpty) {
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
            'No flashcards available',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
      final item = homeController.flashCards.length;
      return ListView.builder(
        itemCount: item > 4 ? 4 : item,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        primary: false,
        itemBuilder: (context, index) {
          final flashCard = homeController.flashCards[index];
          return FlashCardInfo(
            onTap: () async {
              final result = await Get.toNamed(
                Routes.VASCULAR_FLASHCARDS,
                arguments: {
                  'title': flashCard.title,
                  'contentId': flashCard.id,
                },
              );
              if (result == true) {
                homeController.fetchFlashCards();
                homeController.fetchUserAnalytics();
              }
            },
            flashCardTitle: flashCard.title,
            flashCardSubtitle: 'Total Cards: ${flashCard.flashCardsCount}',
            progress: flashCard.flashCardPercentCompleted / 100,
          );
        },
      );
    });
  }
}
