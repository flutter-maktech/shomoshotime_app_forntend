import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/custom_build_container.dart';
import 'package:shomoshotime/app/modules/common_widgets/primary_app_bar.dart';

import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../controllers/flash_cards_controller.dart';
import '../widgets/flash_card_container_widget.dart';

class FlashCardsView extends GetView<FlashCardsController> {
  const FlashCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: PrimaryAppBar(
                notificationOnTap: () => Get.toNamed(Routes.NOTIFICATION),
                profileOnTap: () => Get.toNamed(Routes.PROFILE),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Flashcards',
                      style: AppTextStyles.medium20.copyWith(
                        color: AppColors.blackColor,
                      ),
                    ),
                    Text(
                      'Master key concepts with interactive flashcards',
                      style: AppTextStyles.regular14.copyWith(
                        color: AppColors.appBarSub,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFormField(),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.h),
                child: Container(
                  color: AppColors.appBarBack,
                  width: double.infinity,
                  height: 50.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 8.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomBuildContainer(
                          title: 'All',
                          index: 0,
                          category: '',
                        ),
                        CustomBuildContainer(
                          title: 'SPI',
                          index: 1,
                          category: 'SPI',
                        ),
                        CustomBuildContainer(
                          title: 'Vascular',
                          index: 2,
                          category: 'Vascular',
                        ),
                        CustomBuildContainer(
                          title: 'OB/GYN',
                          index: 3,
                          category: 'OB/GYN',
                        ),
                        CustomBuildContainer(
                          title: 'Abdomen',
                          index: 4,
                          category: 'Abdomen',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Obx(() {
              if (controller.flashCards.isEmpty) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              }

              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: FlashCardContainerWidget(
                      index: index,
                      contentId: controller.flashCards[index].id,
                    ),
                  );
                }, childCount: controller.flashCards.length),
              );
            }),
          ],
        ),
      ),
    );
  }
}
