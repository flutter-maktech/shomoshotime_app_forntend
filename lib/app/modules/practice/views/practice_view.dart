import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/primary_app_bar.dart';

import '../../common_widgets/shimmer_effect.dart';

import '../../../core/user_panel_model/question_set_response.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_text_form_field.dart';
import '../../flash_cards/widgets/flash_card_filter_bar.dart';
import '../controllers/practice_controller.dart';

class PracticeView extends GetView<PracticeController> {
  const PracticeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          final progress = controller.userAnalyticsData.isNotEmpty
              ? controller.userAnalyticsData[0].practiceProgress
              : 0;
          final accuracy = controller.userAnalyticsData.isNotEmpty
              ? controller.userAnalyticsData[0].practiceAccuracy
              : 0;
          if (controller.errorText.value.isNotEmpty &&
              controller.allQuestionSets.isEmpty &&
              !controller.isloading.value) {
            return Center(child: Text(controller.errorText.value));
          }
          return RefreshIndicator(
            onRefresh: controller.refreshPracticeData,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: controller.scrollController,
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
                          'Practice Questions',
                          style: AppTextStyles.medium20.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                        Text(
                          'Test your knowledge with thousands of practice questions',
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16.h,
                    ),
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
                                    controller.selectIndex.value ==
                                    0, // Dynamic
                                onTap: () => controller.changeIndex(0),
                              ),
                              FlashCardFilterBar(
                                title: 'SPI',
                                index: 1,
                                isSelected:
                                    controller.selectIndex.value ==
                                    1, // Dynamic
                                onTap: () => controller.changeIndex(1),
                              ),
                              FlashCardFilterBar(
                                title: 'Vascular',
                                index: 2,
                                isSelected:
                                    controller.selectIndex.value ==
                                    2, // Dynamic
                                onTap: () => controller.changeIndex(2),
                              ),
                              FlashCardFilterBar(
                                title: 'OB/GYN',
                                index: 3,
                                isSelected:
                                    controller.selectIndex.value ==
                                    3, // Dynamic
                                onTap: () => controller.changeIndex(3),
                              ),
                              FlashCardFilterBar(
                                title: 'Abdomen',
                                index: 4,
                                isSelected:
                                    controller.selectIndex.value ==
                                    4, // Dynamic
                                onTap: () => controller.changeIndex(4),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: ShimmerWrapper(
                      isLoading:
                          controller.isloading.value &&
                          controller.userAnalyticsData.isEmpty,
                      height: 120.h,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: AppColors.homeStack,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // IMPORTANT
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Practice \nProgress",
                                                  style: AppTextStyles.regular12
                                                      .copyWith(
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Image.asset(
                                                  ImagePath.frameImage,
                                                  scale: 5,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 14),
                                            Text(
                                              '$progress',
                                              style: AppTextStyles.bold24
                                                  .copyWith(
                                                    color: AppColors.greyBlack,
                                                  ),
                                            ),
                                            const SizedBox(height: 14),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Keep it up!',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppTextStyles
                                                        .regular12
                                                        .copyWith(
                                                          color: AppColors
                                                              .blackColor,
                                                        ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: AppColors.whiteColor,
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Overall\nAccuracy",
                                                  style: AppTextStyles.regular12
                                                      .copyWith(
                                                        color: AppColors
                                                            .blackColor,
                                                      ),
                                                ),
                                                const Spacer(),
                                                Image.asset(
                                                  ImagePath.frameImage,
                                                  scale: 5,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              '$accuracy%',
                                              style: AppTextStyles.bold24
                                                  .copyWith(
                                                    color: AppColors.greyBlack,
                                                  ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "Above average performance",
                                              style: AppTextStyles.regular12
                                                  .copyWith(
                                                    color: AppColors.blackColor,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                Obx(() {
                  final list = controller.filteredQuestionSets;

                  if (controller.isloading.value &&
                      controller.allQuestionSets.isEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: ShimmerWrapper(
                            isLoading: true,
                            height: 250.h,
                            child: const SizedBox.shrink(),
                          ),
                        ),
                        childCount: 5,
                      ),
                    );
                  }

                  if (list.isEmpty && !controller.isloading.value) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.h),
                        child: Center(
                          child: Text(
                            'No practice questions available for this category',
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.appBarSub,
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
                        child: spiFundamentalsCardWidget(list[index]),
                      );
                    }, childCount: list.length),
                  );
                }),

                // Bottom loader for pagination
                Obx(() {
                  if (controller.isLoadingMore.value) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: ShimmerWrapper(
                          isLoading: true,
                          height: 50.h,
                          child: const SizedBox.shrink(),
                        ),
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox.shrink());
                }),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget spiFundamentalsCardWidget(QuestionSetData questionSet) {
    final practice = questionSet.questionAnswers.isNotEmpty
        ? questionSet.questionAnswers.first.practice
        : null;

    final title = questionSet.title;
    // final subtitle = questionSet.subtitle;
    final totalQuestions = questionSet.totalQuestions;
    // final statusLabel = questionSet.statusLabel;
    final category = questionSet.category;
    final accuracy = practice?.accuracy ?? 0;
    final attempt = practice?.totalAttempts ?? 0;
    return Container(
      width: double.infinity,
      // height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
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
                  child: Image.asset(ImagePath.frameImage, scale: 4),
                ),
              ),
              const Spacer(),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Text(
                    category,
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text(title, style: AppTextStyles.bold18),
          // Text(
          //   subtitle,
          //   style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          // ),
          SizedBox(height: 5.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    'Questions',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    totalQuestions.toString(),
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    'Attempt',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '$attempt',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                children: [
                  Text(
                    'Accuracy',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '$accuracy%',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                  // SizedBox(height: 12.h),
                  // Text(
                  //   'Difficulty',
                  //   style: AppTextStyles.regular14.copyWith(
                  //     color: AppColors.appBarSub,
                  //   ),
                  // ),
                  // Text(
                  //   statusLabel,
                  //   style: AppTextStyles.regular14.copyWith(color: Colors.blue),
                  // ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          CustomButton(
            childText: 'Continue Reading',
            onTap: () async {
              final result = await Get.toNamed(
                Routes.spiPracticeBankQus,
                arguments: {
                  'id': questionSet.id,
                  'title': questionSet.title,
                  'category': questionSet.category,
                  'staus_label': questionSet.statusLabel,
                  'totalQuestions': questionSet.totalQuestions,
                  'from': 'practice',
                },
              );
              if (result == true) {
                controller.refreshPracticeData();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget searchButtonWidget() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(Icons.search, size: 16),
        filled: true,
        fillColor: AppColors.appBarBack,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
