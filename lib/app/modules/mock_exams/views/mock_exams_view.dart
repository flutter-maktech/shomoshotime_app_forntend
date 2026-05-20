import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../core/user_panel_model/question_set_response.dart';
import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../../../data/image_path.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/primary_app_bar.dart';
import '../../common_widgets/shimmer_effect.dart';
import '../../flash_cards/widgets/flash_card_filter_bar.dart';
import '../controllers/mock_exams_controller.dart';

class MockExamsView extends GetView<MockExamsController> {
  const MockExamsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.errorText.value.isNotEmpty &&
              controller.allMockTests.isEmpty &&
              !controller.isloading.value) {
            return Center(child: Text(controller.errorText.value));
          }
          return RefreshIndicator(
            onRefresh: controller.refreshMockTestData,
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
                          'Mock Exams',
                          style: AppTextStyles.medium20.copyWith(
                            color: AppColors.blackColor,
                          ),
                        ),
                        Text(
                          'Simulate the real exam',
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.appBarSub,
                          ),
                        ),
                        const SizedBox(height: 16),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlashCardFilterBar(
                                title: 'All',
                                index: 0,
                                isSelected: controller.selectIndex.value == 0,
                                onTap: () => controller.changeIndex(0),
                              ),
                              FlashCardFilterBar(
                                title: 'SPI',
                                index: 1,
                                isSelected: controller.selectIndex.value == 1,
                                onTap: () => controller.changeIndex(1),
                              ),
                              FlashCardFilterBar(
                                title: 'Vascular',
                                index: 2,
                                isSelected: controller.selectIndex.value == 2,
                                onTap: () => controller.changeIndex(2),
                              ),
                              FlashCardFilterBar(
                                title: 'OB/GYN',
                                index: 3,
                                isSelected: controller.selectIndex.value == 3,
                                onTap: () => controller.changeIndex(3),
                              ),
                              FlashCardFilterBar(
                                title: 'Abdomen',
                                index: 4,
                                isSelected: controller.selectIndex.value == 4,
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
                          controller.mockTestAnalytics.isEmpty,
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
                                                  "Mock Test \nProgress",
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
                                              '${controller.mockTestAnalytics.isNotEmpty ? controller.mockTestAnalytics[0].mocktestProgress : 0}%',
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
                                              '${controller.mockTestAnalytics.isNotEmpty ? controller.mockTestAnalytics[0].mocktestAccuracy : 0}%',
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
                  final list = controller.questionSets;
                  // Make a copy of your original list
                  List<QuestionSetData> sortedList = [...list];

                  // No sorting needed since attempts are unlimited

                  if (controller.isloading.value &&
                      controller.allMockTests.isEmpty) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: ShimmerWrapper(
                            isLoading: true,
                            height: 300.h,
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
                            'No Mock Test questions available for this category.',
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
                        child: spiFundamentalsCardWidget(sortedList[index]),
                      );
                    }, childCount: sortedList.length),
                  );
                }),

                // Bottom loading indicator
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
    final title = questionSet.title;
    final subtitle = questionSet.subtitle;
    final totalQuestions = questionSet.totalQuestions;
    final category = questionSet.category;
    final scorePercentage = questionSet.mockTestAttempts.isNotEmpty
        ? questionSet.mockTestAttempts.last.scorePercentage
        : 0;
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
          Text(
            subtitle,
            style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    '$totalQuestions',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              // Spacer(),
              // Column(
              //   children: [
              //     Text(
              //       'Attempt',
              //       style: AppTextStyles.regular14.copyWith(
              //         color: AppColors.appBarSub,
              //       ),
              //     ),
              //     Text(
              //       '$attempt',
              //       style: AppTextStyles.regular14.copyWith(
              //         color: AppColors.blackColor,
              //       ),
              //     ),
              //   ],
              // ),
              // Spacer(),
              Column(
                children: [
                  Text(
                    'Pass Score',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '85%',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.whiteColor,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: Row(
                children: [
                  SizedBox(width: 10.w),
                  Text(
                    'Attempt Accuracy',
                    style: AppTextStyles.regular14.copyWith(color: Colors.grey),
                  ),
                  const Spacer(),
                  Text(
                    '$scorePercentage %',
                    style: AppTextStyles.regular24.copyWith(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.h),
          CustomButton(
            childText: 'Take Exam',
            buttonColor: AppColors.primaryColor,
            onTap: () async {
              controller.startMockTest(questionSet.id);
              final result = await Get.toNamed(
                Routes.spiPracticeBankQus,
                arguments: {
                  'id': questionSet.id,
                  'title': questionSet.title,
                  'category': questionSet.category,
                  'staus_label': questionSet.statusLabel,
                },
              );
              if (result == true) {
                controller.refreshMockTestData();
              }
            },
          ),
        ],
      ),
    );
  }


}

