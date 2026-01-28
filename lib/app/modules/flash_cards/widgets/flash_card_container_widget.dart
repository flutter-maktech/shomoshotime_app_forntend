import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_progress.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../controllers/flash_cards_controller.dart';

class FlashCardContainerWidget extends StatelessWidget {
  const FlashCardContainerWidget({
    super.key,
    required this.index,
    required this.contentId,
  });
  final int index, contentId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FlashCardsController>();
    return Obx(() {
      // Get the filtered cards
      final filteredCards = controller.filteredFlashCards;

      // Check if we have cards for the current index
      if (index >= filteredCards.length) {
        return SizedBox.shrink(); // Return empty if index out of bounds
      }
      final card = filteredCards[index]; // Use the filtered card
      return Container(
        width: double.infinity,
        // height: 400,
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.appBarBack,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Image.asset(ImagePath.bookImage, scale: 4),
                  ),
                ),
                Spacer(),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Text(
                      card.category,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.appBarSub,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(card.title, style: AppTextStyles.bold18),
            Text(
              card.subtitle,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.appBarSub,
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              children: [
                Image.asset(ImagePath.layerImage, scale: 4),
                SizedBox(width: 5.w),
                Text(
                  '${card.flashCardsCount} cards',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.appBarSub,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Progress',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.appBarSub,
                  ),
                ),

                Text(
                  '${card.flashCardActivitiesCount}/${card.flashCardsCount}',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.appBarSub,
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),
            CustomProgress(progress: card.flashCardPercentCompleted / 100),
            SizedBox(height: 20.h),
            CustomButton(
              childText: 'Continue Studying',
              onTap: () async {
                final result = await Get.toNamed(
                  Routes.VASCULAR_FLASHCARDS,
                  arguments: {'title': card.title, 'contentId': contentId},
                );
                if (result == true) {
                  controller.refreshFlashCards();
                }
              },
            ),
          ],
        ),
      );
    });
  }
}
