

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';

import '../controllers/vascular_flashcards_controller.dart';

// class VascularFlashcardsView extends GetView<VascularFlashcardsController> {
//   const VascularFlashcardsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  CustomAppBar(title: 'Vascular Flashcards'),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal:16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Obx(
//                     () => Text(
//                   'Question ${controller.currentIndex.value + 1} of ${controller.totalDots}',
//                   style: AppTextStyles.medium16.copyWith(
//                     color: AppColors.greyLight,
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: PageView.builder(
//                   controller: controller.pageController,
//                   itemCount: controller.totalDots,
//                   onPageChanged: controller.onPageChanged,
//                   itemBuilder: (context, index) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 8),
//                         Text(
//                           controller.questionText,
//                           style: AppTextStyles.bold24,
//                         ),
//                         const Spacer(),
//                         SizedBox(
//                           width: double.infinity,
//                           child: OutlinedButton(
//                             onPressed: () {
//                             },
//                             child: const Text('Show Answer'),
//                             style: OutlinedButton.styleFrom(
//                               padding: EdgeInsets.symmetric(vertical: 16)
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 24),
//                       ],
//                     );
//                   },
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 24),
//                 child: Obx(
//                       () => Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: List.generate(
//                       controller.totalDots,
//                           (index) {
//                         final isActive =
//                             controller.currentIndex.value == index;
//
//                         return GestureDetector(
//                           onTap: () => controller.setIndex(index),
//                           child: Container(
//                             margin:
//                             const EdgeInsets.symmetric(horizontal: 4),
//                             width: isActive ? 12 : 8,
//                             height: isActive ? 12 : 8,
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: isActive
//                                   ? Colors.yellow
//                                   : AppColors.appBarBack,
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//               Obx(() =>  Row(
//                 children: [
//                   Expanded(child: CustomButton(onTap: (){
//                     controller.changeButton(0);
//                   },
//                     buttonColor: controller.select.value ==0 ? AppColors.primaryColor:AppColors.lightYellow,
//                     childText: 'Back',)),
//                   const SizedBox(width: 6,),
//                   Expanded(child: CustomButton(onTap: (){
//                     controller.changeButton(1);
//                   }, buttonColor: controller.select.value ==1 ? AppColors.primaryColor:AppColors.lightYellow,
//                       childText: 'Next')),
//                 ],
//               ) )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class VascularFlashcardsView extends GetView<VascularFlashcardsController> {
  const VascularFlashcardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Vascular Flashcards'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question counter
              Obx(
                    () => Text(
                  'Question ${controller.currentIndex.value + 1} of ${controller.totalDots}',
                  style: AppTextStyles.medium16.copyWith(
                    color: AppColors.greyLight,
                  ),
                ),
              ),

              // PageView
              Expanded(
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: controller.totalDots,
                  onPageChanged: controller.onPageChanged,
                  itemBuilder: (context, index) {
                    return Obx(
                          () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            controller.questionText,
                            style: AppTextStyles.bold24,
                          ),

                          const SizedBox(height: 16),

                          // ✅ Show Answer চাপার পর question-এর নিচে answer দেখাবে
                          if (controller.showAnswer.value)
                            Text(
                              controller.answerText,
                              style: AppTextStyles.regular16.copyWith(
                                color: AppColors.greyLight,
                              ),
                            ),

                          const Spacer(),

                          // ✅ Answer দেখানো হলে button লুকাবে
                          if (!controller.showAnswer.value)
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                onPressed: controller.showAnswerText,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16),
                                ),
                                child: const Text('Show Answer'),
                              ),
                            ),

                          const SizedBox(height: 24),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Dots indicator
              Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Obx(
                      () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      controller.totalDots,
                          (index) {
                        final isActive =
                            controller.currentIndex.value == index;

                        return GestureDetector(
                          onTap: () => controller.setIndex(index),
                          child: Container(
                            margin:
                            const EdgeInsets.symmetric(horizontal: 4),
                            width: isActive ? 12 : 8,
                            height: isActive ? 12 : 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isActive
                                  ? Colors.yellow
                                  : AppColors.appBarBack,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Back / Next buttons
              Obx(
                    () => Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          controller.changeButton(0);
                          if (controller.currentIndex.value > 0) {
                            controller.setIndex(
                                controller.currentIndex.value - 1);
                          }
                        },
                        buttonColor: controller.select.value == 0
                            ? AppColors.primaryColor
                            : AppColors.lightYellow,
                        childText: 'Back',
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          controller.changeButton(1);
                          if (controller.currentIndex.value <
                              controller.totalDots - 1) {
                            controller.setIndex(
                                controller.currentIndex.value + 1);
                          }
                        },
                        buttonColor: controller.select.value == 1
                            ? AppColors.primaryColor
                            : AppColors.lightYellow,
                        childText: 'Next',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
