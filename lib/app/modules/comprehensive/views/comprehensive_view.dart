  import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/data/image_path.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_button.dart';
import 'package:shomoshotime/app/routes/app_pages.dart';

import '../../../data/app_colors.dart';
import '../controllers/comprehensive_controller.dart';

// class ComprehensiveView extends GetView<ComprehensiveController> {
//   const ComprehensiveView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SafeArea(
//           child: SingleChildScrollView(
//             child: Center(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.h),
//                 child: Column(
//                   children: [
//                     Image.asset(ImagePath.comprehensiveStudy, height: 200.h),
//                     SizedBox(height: 100.h),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Comprehensive Study Guides',maxLines: 1,overflow: TextOverflow.ellipsis,
//                           style: AppTextStyles.bold32,
//                         ),
//                         Text(
//                           'Access detailed study materials for SPI, Vascular, OB/GYN,and Abdomen specialties',
//                           style: AppTextStyles.regular16,
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 40.h),
//                     InkWell(
//                       onTap: () {
//                         Get.toNamed(Routes.INTERACTIVE_FLASHCARDS);
//                       },
//                       child: CustomButton(childText: 'NEXT'),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




  class ComprehensiveView extends GetView<ComprehensiveController> {
    const ComprehensiveView({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [
            // Background Image
            Obx(
                  () => Positioned.fill(
                child: Image.asset(
                  controller.images[controller.currentIndex.value],
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 100),

                      // Title
                      Obx(
                            () => Text(
                          controller.titles[controller.currentIndex.value],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 30,
                            fontFamily: 'PlayfairDisplay',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),

                      // Subtitle
                      Obx(
                            () => SizedBox(
                          width: 353,
                          child: Text(
                            controller.subtitles[controller.currentIndex.value],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),

                  // Bottom slider + button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(
                              () => Row(
                            children: List.generate(
                              controller.images.length,
                                  (index) => GestureDetector(
                                onTap: () => controller.onDotTap(index),
                                child: Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: Container(
                                    width: controller.currentIndex.value == index
                                        ? 16
                                        : 5,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: controller.currentIndex.value ==
                                          index
                                          ? AppColors.primaryColor
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: controller.onNext,
                        child: const CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Icon(
                            Icons.arrow_forward_outlined,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }
  }
