// study_guides_view.dart (refactored)
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../../common_widgets/header_section.dart';
import '../../common_widgets/primary_app_bar.dart';
import '../../flash_cards/widgets/flash_card_filter_bar.dart';
import '../controllers/study_guides_controller.dart';
import '../../common_widgets/shimmer_effect.dart';
import '../widgets/spi_audio_card_list.dart';
import '../widgets/spi_card_list.dart';

class StudyGuidesView extends GetView<StudyGuidesController> {
  const StudyGuidesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: controller.refreshStudyGuides,
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
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeaderSection(),
                      SizedBox(height: 12.h),
                      Obx(
                        () => CustomTextFormField(
                          onClear: controller.clearSearch,
                          onChanged: controller.onSearchChanged,
                          searchController: controller.searchController,
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
                              onTap: () {
                                controller.changeIndex(0);
                                controller.filterStudyGuides('All');
                              },
                            ),
                            FlashCardFilterBar(
                              title: 'SPI',
                              index: 1,
                              isSelected:
                                  controller.selectIndex.value == 1, // Dynamic
                              onTap: () {
                                controller.changeIndex(1);
                                controller.filterStudyGuides('SPI');
                              },
                            ),
                            FlashCardFilterBar(
                              title: 'Vascular',
                              index: 2,
                              isSelected:
                                  controller.selectIndex.value == 2, // Dynamic
                              onTap: () {
                                controller.changeIndex(2);
                                controller.filterStudyGuides('Vascular');
                              },
                            ),
                            FlashCardFilterBar(
                              title: 'OB/GYN',
                              index: 3,
                              isSelected:
                                  controller.selectIndex.value == 3, // Dynamic
                              onTap: () {
                                controller.changeIndex(3);
                                controller.filterStudyGuides('OB/GYN');
                              },
                            ),
                            FlashCardFilterBar(
                              title: 'Abdomen',
                              index: 4,
                              isSelected:
                                  controller.selectIndex.value == 4, // Dynamic
                              onTap: () {
                                controller.changeIndex(4);
                                controller.filterStudyGuides('Abdomen');
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Content section
              Obx(() {
                if (controller.select.value == 0) {
                  return const SpiCardList();
                } else {
                  return const SpiAudioCardList();
                }
              }),
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
