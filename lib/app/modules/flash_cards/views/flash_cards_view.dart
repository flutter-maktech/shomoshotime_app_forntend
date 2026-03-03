import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import 'package:shomoshotime/app/modules/common_widgets/primary_app_bar.dart';
import 'package:shomoshotime/app/modules/common_widgets/shimmer_effect.dart';
import 'package:shomoshotime/app/modules/flash_cards/widgets/flash_card_filter_bar.dart';

import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../controllers/flash_cards_controller.dart';
import '../widgets/flash_card_container_widget.dart';

class FlashCardsView extends GetView<FlashCardsController> {
  const FlashCardsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.refreshFlashCards,
        child: SafeArea(
          child: CustomScrollView(
            controller: controller.scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: PrimaryAppBar(
                  notificationOnTap: () => Get.toNamed(Routes.notification),
                  profileOnTap: () => Get.toNamed(Routes.profile),
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
                      Obx(
                        () => CustomTextFormField(
                          searchController: controller.searchController,
                          onClear: controller.clearSearch,
                          isSearchQueryNotEmpty:
                              controller.searchQuery.value.isNotEmpty,
                        ),
                      ),
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
                      child: Obx(
                        () => Row(
                          // Wrap with Obx
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FlashCardFilterBar(
                              title: 'All',
                              index: 0,
                              isSelected:
                                  controller.selectIndex.value == 0, // Dynamic
                              onTap: () => controller.changeIndex(0),
                            ),
                            FlashCardFilterBar(
                              title: 'SPI',
                              index: 1,
                              isSelected:
                                  controller.selectIndex.value == 1, // Dynamic
                              onTap: () => controller.changeIndex(1),
                            ),
                            FlashCardFilterBar(
                              title: 'Vascular',
                              index: 2,
                              isSelected:
                                  controller.selectIndex.value == 2, // Dynamic
                              onTap: () => controller.changeIndex(2),
                            ),
                            FlashCardFilterBar(
                              title: 'OB/GYN',
                              index: 3,
                              isSelected:
                                  controller.selectIndex.value == 3, // Dynamic
                              onTap: () => controller.changeIndex(3),
                            ),
                            FlashCardFilterBar(
                              title: 'Abdomen',
                              index: 4,
                              isSelected:
                                  controller.selectIndex.value == 4, // Dynamic
                              onTap: () => controller.changeIndex(4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(() {
                // This will rebuild when selectIndex or searchController changes
                final filteredCards = controller.filteredFlashCards;

                // Only show full loading if it's the first load and we have no cards
                if (controller.isLoading.value &&
                    controller.allFlashCards.isEmpty) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: ShimmerWrapper(
                          isLoading: true,
                          height: 180.h,
                          child: const SizedBox.shrink(),
                        ),
                      ),
                      childCount: 5,
                    ),
                  );
                }

                if (filteredCards.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.h),
                        child: Text(
                          controller.searchController.text.isEmpty
                              ? 'No flashcards available for this category'
                              : 'No results found for "${controller.searchController.text}"',
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.grey,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: FlashCardContainerWidget(
                        index: index,
                        contentId: filteredCards[index].id,
                      ),
                    );
                  }, childCount: filteredCards.length),
                );
              }),
              // Bottom Loading Indicator
              SliverToBoxAdapter(
                child: Obx(() {
                  if (controller.isLoadingMore.value) {
                    return Padding(
                      padding: EdgeInsets.all(16.sp),
                      child: ShimmerWrapper(
                        isLoading: true,
                        height: 50.h,
                        child: const SizedBox.shrink(),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
