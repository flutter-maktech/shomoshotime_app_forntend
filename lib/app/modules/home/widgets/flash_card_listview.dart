import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'falsh_card_info.dart';

class FlashCardListView extends StatelessWidget {
  const FlashCardListView({super.key});

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
            flashCardTitle: flashCard.title,
            flashCardSubtitle: 'Total Cards: ${flashCard.flashCardsCount}',
            progress: flashCard.flashCardPercentCompleted / 100,
          );
        },
      );
    });
  }
}