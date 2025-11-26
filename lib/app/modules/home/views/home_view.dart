import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shomoshotime/app/data/app_colors.dart';
import 'package:shomoshotime/app/data/app_text_styles.dart';
import '../../../routes/app_pages.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_progress.dart';
import '../../common_widgets/custom_progress_container.dart';
import '../../common_widgets/primary_app_bar.dart';
import '../controllers/home_controller.dart';
import '../widget/grid.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 188.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.homeStack,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryAppBar(notificationOnTap: () {}, profileOnTap: () {}),
                SizedBox(height: 10.h),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 30.h,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.w,
                            vertical: 14.h,
                          ),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.homeStack.withAlpha(200),
                                blurRadius: 10,
                                spreadRadius: 8,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome back,\nSarah!",
                                style: AppTextStyles.spaceGroteskMedium20,
                              ),
                              SizedBox(height: 22.h),
                              Grid(
                                firstCardValue: "24.5",
                                firstCardChartValue: "5.2",
                                secondCardValue: "24.5",
                                secondCardChartValue: "5.2",
                                thirdCardValue: "24.5",
                                thirdCardChartValue: "5.2",
                                fourthCardValue: "24.5",
                                fourthCardChartValue: "5.2",
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            children: [
                              buildRow(
                                title: 'Continue Learning',
                                subTitle: 'Pick up where you left off',
                                onTap: () {
                                  Get.toNamed(Routes.CONTINUE_LEARNING);
                                },
                              ),
                              SizedBox(height: 22.h),
                              ListView.builder(
                                itemCount: 5,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) =>
                                    CustomProgressContainer(
                                      title: 'SPI Study Guide - Chapter 5',
                                      subTitleContainerText: 'Study',
                                      subTitleText: '2 Hours Ago',
                                      progress: .7,
                                    ),
                              ),
                              SizedBox(height: 45.h),
                              buildRow(
                                title: 'Category Progress',
                                subTitle: 'Your mastery across specialties',
                                onTap: () {
                                  Get.toNamed(Routes.CATEGORY_PROGRESS);
                                },
                              ),
                              SizedBox(height: 22.h),
                              ListView.builder(
                                itemCount: 5,
                                padding: EdgeInsets.zero,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                primary: false,
                                itemBuilder: (context, index) =>
                                    CustomProgressContainer(
                                      title: 'SPI Study Guide - Chapter 5',
                                      suffixTitle: '156 / 240',
                                      progress: .8,
                                      progressComplete: '55% Complete',
                                    ),
                              ),

                              SizedBox(height: 25.h),
                            ],
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
    );
  }

  Row buildRow({
    required String title,
    required String subTitle,
    required Function()? onTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.spaceGroteskMedium20,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              subTitle,
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.appBarSub,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Text(
              'View All',
              style: AppTextStyles.regular14.copyWith(
                color: AppColors.primaryGray,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ),
      ],
    );
  }
}
