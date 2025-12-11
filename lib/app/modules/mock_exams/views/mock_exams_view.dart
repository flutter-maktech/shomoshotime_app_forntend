import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';

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
                          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                            "Questions\nAttempted",
                                            style: AppTextStyles.regular12
                                                .copyWith(
                                              color: AppColors.blackColor,
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
                                        '430',
                                        style: AppTextStyles.bold24.copyWith(
                                          color: AppColors.greyBlack,
                                        ),
                                      ),
                                      SizedBox(height: 14),

                                      Row(
                                        children: [
                                          Image.asset(
                                            ImagePath.frame21Image,
                                            scale: 6,
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              '+52 this week',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyles.regular12
                                                  .copyWith(
                                                color: AppColors.blackColor,
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
                                              color: AppColors.blackColor,
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
                                        '810%',
                                        style: AppTextStyles.bold24.copyWith(
                                          color: AppColors.greyBlack,
                                        ),
                                      ),
                                      SizedBox(height: 6),

                                      Text(
                                        "Above average performance",
                                        style: AppTextStyles.regular12.copyWith(
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

                        SizedBox(height: 13),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Overall\nAccuracy'),
                                    Spacer(),
                                    Image.asset(
                                      ImagePath.frame21Image,
                                      scale: 4,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '12 days',
                                  style: AppTextStyles.bold24.copyWith(
                                    color: AppColors.greyBlack,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Above average performance'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: spiFundamentalsCardWidget(),
                );
              }, childCount: 3),
            ),
          ],
        ),
      ),
    );
  }
  Widget spiFundamentalsCardWidget() {
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
                    "SPI",
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Text('SPI Full Mock Exam', style: AppTextStyles.bold18),
          Text(
            'Complete practice exam covering all SPI topics',
            style: AppTextStyles.regular14.copyWith(color: AppColors.appBarSub),
          ),
          SizedBox(height: 15.h),
          Row(
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
                    '80',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'attempt',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.appBarSub,
                    ),
                  ),
                  Text(
                    '95',
                    style: AppTextStyles.regular14.copyWith(
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),
              Spacer(),
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
            child: SizedBox(width: double.infinity,
              height: 50,
              child: Row(children: [
                SizedBox(width: 10.w,),
                Text('attempt',style: AppTextStyles.regular14.copyWith(color:Colors.grey),),
                Spacer(),
                Text('82%',style: AppTextStyles.regular24.copyWith(color:Colors.black),),
                SizedBox(width: 10.w,),
              ],),),
          ),
          SizedBox(height: 14.h),
          CustomButton(childText: 'Retake Exam',onTap: () => Get.toNamed(Routes.SPI_PRACTICE_BANK_QUS),),
          SizedBox(height: 18.h),
          Center(child: Text('Attempted 3 times',style: AppTextStyles.regular14.copyWith(color: Colors.grey),))
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
