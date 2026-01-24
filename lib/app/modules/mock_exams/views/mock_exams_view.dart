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
import '../controllers/mock_exams_controller.dart';

class MockExamsView extends GetView<MockExamsController> {
  const MockExamsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isloading.value && controller.allMockTests.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.errorText.value.isNotEmpty &&
              controller.allMockTests.isEmpty) {
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
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                        borderRadius: BorderRadius.circular(8),
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
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                              ),
                                              Spacer(),
                                              Image.asset(
                                                ImagePath.frameImage,
                                                scale: 5,
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 14),
                                          Text(
                                            '${controller.mockTestAnalytics.isNotEmpty ? controller.mockTestAnalytics[0].mocktestProgress : 0}%',
                                            style: AppTextStyles.bold24
                                                .copyWith(
                                                  color: AppColors.greyBlack,
                                                ),
                                          ),
                                          SizedBox(height: 14),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Keep it up!',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyles.regular12
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

                                  SizedBox(width: 14),

                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(8),
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
                                                      color:
                                                          AppColors.blackColor,
                                                    ),
                                              ),
                                              Spacer(),
                                              Image.asset(
                                                ImagePath.frameImage,
                                                scale: 5,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 6),

                                          Text(
                                            '${controller.mockTestAnalytics.isNotEmpty ? controller.mockTestAnalytics[0].mocktestAccuracy : 0}%',
                                            style: AppTextStyles.bold24
                                                .copyWith(
                                                  color: AppColors.greyBlack,
                                                ),
                                          ),
                                          SizedBox(height: 6),

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

                Obx(() {
                  final list = controller.questionSets;
                  // Make a copy of your original list
                  List<QuestionSetData> sortedList = [...list];

                  // Sort by whether the user can retake the exam
                  sortedList.sort((a, b) {
                    final aCanRetake =
                        a.mockTestAttempts.isEmpty ||
                        a.mockTestAttempts.last.attemptNumber < 3;
                    final bCanRetake =
                        b.mockTestAttempts.isEmpty ||
                        b.mockTestAttempts.last.attemptNumber < 3;

                    // true comes before false
                    if (aCanRetake && !bCanRetake) return -1;
                    if (!aCanRetake && bCanRetake) return 1;
                    return 0;
                  });

                  if (list.isEmpty && !controller.isloading.value) {
                    return SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: Center(
                          child: Text(
                            'No Mock Test questions available.',
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: spiFundamentalsCardWidget(sortedList[index]),
                      );
                    }, childCount: sortedList.length),
                  );
                }),

                // Bottom loading indicator
                Obx(() {
                  if (controller.isLoadingMore.value) {
                    return const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
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
    final attemptNumber = questionSet.mockTestAttempts.isNotEmpty
        ? questionSet.mockTestAttempts.last.attemptNumber
        : 0;
    final bool canRetake = attemptNumber < 3;
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
                  child: Image.asset(ImagePath.frameImage, scale: 4),
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
                  Spacer(),
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
            childText: canRetake ? 'Retake Exam' : 'Max Attempts Reached',
            buttonColor: canRetake
                ? AppColors.primaryColor
                : AppColors.appBarBack,
            onTap: canRetake
                ? () {
                    controller.startMockTest(questionSet.id);
                    Get.toNamed(
                      Routes.SPI_PRACTICE_BANK_QUS,
                      arguments: {
                        'id': questionSet.id,
                        'title': questionSet.title,
                        'category': questionSet.category,
                        'staus_label': questionSet.statusLabel,
                      },
                    );
                  }
                : null, // 👈 disables button
          ),
          SizedBox(height: 18.h),
          Center(
            child: Text(
              'Attempted $attemptNumber times',
              style: AppTextStyles.regular14.copyWith(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  GestureDetector buildContainer(String title, int index) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: controller.selectIndex.value == index
              ? AppColors.primaryColor
              : AppColors.whiteColor,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          child: Text(
            title,
            style: AppTextStyles.regular13.copyWith(
              color: controller.selectIndex.value == index
                  ? Colors.black
                  : AppColors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
