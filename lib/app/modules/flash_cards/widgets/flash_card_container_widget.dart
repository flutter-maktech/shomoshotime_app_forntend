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
      // Show loading indicator
      if (controller.isLoading.value) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: CircularProgressIndicator(),
          ),
        );
      }

      // Show error message
      if (controller.errorMessage.value.isNotEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            controller.errorMessage.value,
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        );
      }
      // Show empty state
      if (controller.flashCards.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'No flashcards available',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        );
      }
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
                      controller.flashCards[index].category,
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.appBarSub,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              controller.flashCards[index].title,
              style: AppTextStyles.bold18,
            ),
            Text(
              controller.flashCards[index].subtitle,
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
                  '${controller.flashCards[index].flashCardsCount} cards',
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
                  '${controller.flashCards[index].flashCardActivitiesCount}/${controller.flashCards[index].flashCardsCount}',
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.appBarSub,
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),
            CustomProgress(
              progress:
                  controller.flashCards[index].flashCardPercentCompleted / 100,
            ),
            SizedBox(height: 20.h),
            CustomButton(
              childText: 'Continue Studying',
              onTap: () {
                Get.toNamed(
                Routes.VASCULAR_FLASHCARDS,
                arguments: {
                  'title': controller.flashCards[index].title,
                  'contentId': contentId,
                },
              );
              },
            ),
          ],
        ),
      );
    });
  }
}
